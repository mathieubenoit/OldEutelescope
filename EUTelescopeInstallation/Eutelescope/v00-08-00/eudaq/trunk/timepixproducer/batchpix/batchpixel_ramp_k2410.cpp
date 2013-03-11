/*
 * batchpixel.cpp
 *
 *  Created on: Mar 2012
 *  Authors:	John Idarraga <idarraga@cern.ch>
 *    			Martin Kuppa <mkroupa@uh.edu>
 */

#include "mpxmanagerapi.h"
#include "mpxhw.h"

#include <stdio.h>
#include <stdlib.h>
#include <fstream>

#include <string.h>
#include <dlfcn.h>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

#include <stdio.h>   /* Standard input/output definitions */
#include <string.h>  /* String function definitions */
#include <unistd.h>  /* UNIX standard function definitions */
#include <fcntl.h>   /* File control definitions */
#include <errno.h>   /* Error number definitions */
#include <termios.h> /* POSIX terminal control definitions */
#include <stdlib.h>

int open_port(const char *);
void terminate_string(char *);

int main(int argc, char ** argv) {

	// Keithley control
	if(argc < 7) {
		cout << "use: " << endl;
		cout << "     " << argv[0] << " min max step dataset(string) port(/dev/ttyUSB0) IKRUM(int)" << endl;
		exit(1);
	}

	int minV = atoi(argv[1]);
	int maxV = atoi(argv[2]);
	int stepV = atoi(argv[3]);
	string dataset(argv[4]);
	string serialPort(argv[5]);
	int ikrum_setting = atoi(argv[6]);

	int fd = open_port( serialPort.c_str() );

	vector<string> startup;
	startup.push_back("*rst\r");
	startup.push_back("*rst\r");
	startup.push_back(":sour:func volt\r");
	startup.push_back(":sour:volt:mode fixed\r");
	startup.push_back(":sour:volt:range 200\r");
	startup.push_back(":sour:volt:level 0\r"); // set 0 V
	startup.push_back(":sens:curr:prot 100E-6\r");
	startup.push_back(":sens:func \"curr\"\r");
	startup.push_back(":sens:curr:range 10E-6\r");
	startup.push_back(":form:elem curr\r");
	startup.push_back(":output on\r");
	startup.push_back(":read?\r");

	// start up

	vector<string>::iterator itr = startup.begin();
	int n = 0;
	for( ; itr != startup.end() ; itr++) {

		printf("%s \n",(*itr).c_str());
		n = write(fd, (*itr).c_str(), (*itr).size());
		if (n < 0) {
			fputs("write() of n bytes failed!\n", stderr);
		}

		usleep(500000); // 500ms

	}

	string tempC = "";
	//char tempC[256];
	char tV[256];
	//char tV2[256];

	//ofstream outfile (outputfilename.c_str());

	////////////////////////////////////////////////////////////
	// Pixelman

	// Init manager
	int control = -1;
	u32 flags = MGRINIT_NOEXHANDLING;
	control = mgrInitManager(flags, '\0');
	if(mgrIsRunning()){
		cout << "Manager running " << endl;
	}

	// Find device
	DEVID devId;
	int count = 0;
	control = mpxCtrlGetFirstMpx(&devId, &count);
	cout << "found : " << count << " | devId : " << devId << endl;
	// The next device will be the dummy
	//while (control == 0) {
	//	control = mpxCtrlGetNextMpx(&devId);
	//	cout << "found : " << count << " | devId : " << devId << endl;
	//	usleep(500000);
	//}

	// Load binary pixels config
	control = mpxCtrlLoadPixelsCfg(devId, "./B08_W0170_Centroid.bpc", true);
	cout << "Load pixels config : " << control << endl;

	// Get number of parameters in the Hw Info list
	int hwInfoCount = 0;
	control = mpxCtrlGetHwInfoCount(devId, &hwInfoCount);
	cout << "count : " << hwInfoCount << endl;

	// Set bias voltage
	double voltage = 15.0;
	byte * data = new byte(sizeof(double));//(byte)voltage;
	data = (byte * )(&voltage);
	control = mpxCtrlSetHwInfoItem(devId, 8, data, sizeof(double));	 // 8 voltage
	cout << "Set voltage : " << control << endl;

	// sleep
	usleep(100000);

	// Read bias voltage and bias voltage verification
	ItemInfo data_hv;
	int datar_size = 8;
	double voltage_back;
	data_hv.data = &voltage_back;

	// 18 signal delay u16
	// 12 Freq
	// 8 HV
	// 9 HV ver
	for ( int i = 8 ; i < 10 ; i++ ) {

		cout << "Item : " << i << endl;
		mpxCtrlGetHwInfoItem(devId, i, &data_hv, &datar_size);
		cout << "data size  : " << datar_size << endl;
		cout << "array size : " << data_hv.count << endl;
		cout << "flags      : " << data_hv.flags << endl;
		cout << "name       : " << data_hv.name << endl;
		cout << "descr      : " << data_hv.descr << endl;
		cout << "type       : " << data_hv.type << endl;
		cout << "data       : " << voltage_back << endl;

		// rewind
		datar_size = 0;
	}

	// check mode
	int mode;
	control = mpxCtrlGetAcqMode(devId, &mode);
	cout << "Acq mode = " << mode << endl;

	mode = 1;
	control = mpxCtrlSetAcqMode(devId, mode);
	cout << "Acq mode = " << mode << endl;

	// Get and Set Daqs
	DACTYPE dacVals[14];
	int chipnumber = 0;
	control = mpxCtrlGetDACs(devId, dacVals, 14, chipnumber);
	cout << "Thl fine = " << dacVals[TPX_THLFINE] << endl;

	dacVals[TPX_THLFINE] = 392; // 1000e- above thl adjustment mean
	dacVals[TPX_IKRUM] = ikrum_setting;
	control = mpxCtrlSetDACs(devId, dacVals, 14, chipnumber);

	sleep(1);

	DACTYPE dacVals_new[14];
	control = mpxCtrlGetDACs(devId, dacVals_new, 14, chipnumber);
	cout << "Thl fine = " << dacVals_new[TPX_THLFINE] << endl;
	cout << "IKRUM    = " << dacVals_new[TPX_IKRUM] << endl;

	// pre-set for voltage
	// write voltage
	voltage = 1;
	byte * data_preset = new byte(sizeof(double));
	data_preset = (byte * )(&voltage);
	control = mpxCtrlSetHwInfoItem(devId, 8, data_preset, sizeof(double));	 // 8 voltage
	if(control == 0) cout << "Set voltage preset OK " << endl;
	sleep(1);

	// Set bias voltage
	string filename = "";
	char temp[256];
	//ItemInfo data1;
	datar_size = 8;

	float lastVoltage = 0.;
	for (float voltage = minV ; voltage <= maxV ; voltage += stepV) {
		//for(voltage = 5 ; voltage <= 90 ; voltage+=1){ // works starting at 5 volts

		// write voltage
		//byte * data = new byte(sizeof(double));
		//data = (byte * )(&voltage);
		//control = mpxCtrlSetHwInfoItem(devId, 8, data, sizeof(double));	 // 8 voltage
		//if(control == 0) cout << "Set voltage OK " << endl;

		// start the string
		tempC = ":sour:volt:level ";
		// sprintf the voltage (float)
		sprintf(tV,"%.1f", voltage);
		// append voltage and CR
		tempC.append(tV);
		tempC.append("\r");

		cout << tempC << endl;
		// write to device
		n = write(fd, tempC.c_str(), tempC.size());
		// keep track of last voltage sent
		lastVoltage = voltage;
		if (n < 0) {
			fputs("write() of n bytes failed!\n", stderr);
		}

		// Stabilization //////////////////////////////////
		// Let the new set stabilize
		usleep(500000); // 500ms

		// read voltage ver
		//data1.data = &voltage_back;
		//mpxCtrlGetHwInfoItem(devId, 9, &data1, &datar_size);
		//cout << "read voltage = " << voltage_back << " | voltage = " << voltage << endl;
		// build a name

		sprintf(temp,"%.1f", voltage);
		filename = dataset;
		filename += "__";
		filename += temp;
		filename += "/frame_";
		cout << "Start acquisition.  Write to --> " << filename << endl;
		// perform acquisition
		control = mpxCtrlPerformFrameAcq(devId, 1000, 0.01, FSAVE_SPARSEXY | FSAVE_BINARY | FSAVE_U32 , filename.c_str());

		// keep last voltage
		lastVoltage = voltage;
	}

	// Ramp down the voltage
	cout << "Ramp down ..." << endl;
	for (float voltage = lastVoltage ; voltage >= 0. ; voltage-=1.0) {

		// start the string
		tempC = ":sour:volt:level ";
		// sprintf the voltage (float)
		sprintf(tV,"%.1f", voltage);
		// append voltage and CR
		tempC.append(tV);
		tempC.append("\r");

		cout << tempC << endl;
		n = write(fd, tempC.c_str(), tempC.size());

		usleep(100000); // 100ms

	}

	// Set keithley output to off
	cout << "Output off ..." << endl;
	tempC = ":outp off \r";
	n = write(fd, tempC.c_str(), tempC.size());

	return 0;
}

void terminate_string(char * t) {

	bool foundE = false;
	int itr = 0;
	while (!foundE) {
		if( t[itr] == 'E' ) {
			foundE = true;
			*(t+itr+4) = '\0';
		}
		itr++;
	}

}

/*
 * 'open_port()' - Open serial port 1.
 *
 * Returns the file descriptor on success or -1 on error.
 */

int open_port(const char * port) {
	// File descriptor for the port
	int fd;

	cout << "Openning port : " << port << endl;

	// open
	fd = open(port, O_RDWR | O_NOCTTY | O_NDELAY);

	// get current options for the port
	struct termios options;
	tcgetattr(fd, &options);

	// set 19200 baud
	cfsetispeed(&options, B19200);
	cfsetospeed(&options, B19200);

	// set 8N1
	options.c_cflag &= ~PARENB; // no parity bit
	options.c_cflag &= ~CSTOPB; // 1 stop bit
	options.c_cflag &= ~CSIZE;  // no bit mask for data bits
	options.c_cflag |= CS8;

	// raw output
	//options.c_oflag &= ~OPOST;

	// disable hardware flow control
	options.c_cflag &= ~CRTSCTS;

	// Set the new options for the port...
	tcsetattr(fd, TCSANOW, &options);

	if (fd == -1) {
		/*
		 * Could not open the port.
		 */
		perror("open_port: Unable to open /dev/ttyUSB0 - ");
	}
	else
		fcntl(fd, F_SETFL, 0);

	return (fd);
}
