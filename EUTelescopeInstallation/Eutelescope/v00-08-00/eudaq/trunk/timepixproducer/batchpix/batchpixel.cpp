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

#include <string.h>
#include <dlfcn.h>
#include <iostream>
#include <string>

using namespace std;

int main() {

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
	control = mpxCtrlLoadPixelsCfg(devId, "./binary_pixel_cfg_Centroid_plusMaskedRegion.bpc", true);
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

	// Get and Set Daqs
	DACTYPE dacVals[14];
	int chipnumber = 0;
	control = mpxCtrlGetDACs(devId, dacVals, 14, chipnumber);
	cout << "Thl fine = " << dacVals[TPX_THLFINE] << endl;

	dacVals[TPX_THLFINE] = 394; // 1000e- above thl adjustment mean
	control = mpxCtrlSetDACs(devId, dacVals, 14, chipnumber);

	DACTYPE dacVals_new[14];
	control = mpxCtrlGetDACs(devId, dacVals_new, 14, chipnumber);
	cout << "Thl fine = " << dacVals_new[TPX_THLFINE] << endl;


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
	ItemInfo data1;
	datar_size = 8;
	for(voltage = 5 ; voltage <= 90 ; voltage+=1){ // works starting at 5 volts

		// write voltage
		byte * data = new byte(sizeof(double));
		data = (byte * )(&voltage);
		control = mpxCtrlSetHwInfoItem(devId, 8, data, sizeof(double));	 // 8 voltage
		if(control == 0) cout << "Set voltage OK " << endl;

		usleep(1000000);

		// read voltage ver
		data1.data = &voltage_back;
		mpxCtrlGetHwInfoItem(devId, 9, &data1, &datar_size);
		cout << "read voltage = " << voltage_back << " | voltage = " << voltage << endl;
		// build a name

		sprintf(temp,"%.1f",voltage_back);
		filename = "test__";
		filename += temp;
		filename += "/frame_";
		cout << "Start acquisition.  Write to --> " << filename << endl;
		// perform acquisition
		control = mpxCtrlPerformFrameAcq(devId, 1000, 0.005, FSAVE_SPARSEXY | FSAVE_ASCII | FSAVE_U32 , filename.c_str());

	}

	return 0;
}
