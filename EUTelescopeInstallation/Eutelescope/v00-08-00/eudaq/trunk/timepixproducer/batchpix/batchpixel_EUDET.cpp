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
#include <time.h>
#include <fstream>
#include <sstream>
//#include "TH2D.h"
//#include "TApplication.h"
//#include "TCanvas.h"
//#include "TStopwatch.h"
#include <stdlib.h>
#include <limits.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <map>


using namespace std;


char *int2bin(unsigned n, char *buf=NULL)
{
    #define BITS (sizeof(n) * CHAR_BIT)

    static char static_buf[BITS + 1];
    int i;

    if (buf == NULL)
        buf = static_buf;

    for (i = BITS - 1; i >= 0; --i) {
        buf[i] = (n & 1) ? '1' : '0';
        n >>= 1;
    }

    buf[BITS] = '\0';
    return buf;

    #undef BITS
}




int64_t timespecDiff(struct timespec *timeA_p, struct timespec *timeB_p)
{
  return ((timeA_p->tv_sec * 1000000000) + timeA_p->tv_nsec) -
           ((timeB_p->tv_sec * 1000000000) + timeB_p->tv_nsec);
}


map<int,map<int, int> >  ReadFrameMethod1(char * Filename){

		ifstream in(Filename,ios::binary);

		unsigned int Data[3];
		
		map<int,map<int, int> > myData;

		while (!in.eof()){


			in.read((char*)Data,sizeof(Data));
			myData[Data[0]][Data[1]]=Data[2];
			cout << "Data: " << Data[0] << " " << Data[1] << " " << Data[2] << endl;	


		}
		
		
		
		in.close();
		
		return myData;


}


int  ReadFrameMethod2(char * Filename, char* buffer){

		
				
		ifstream in(Filename,ios::binary|ios::ate);
		long size = in.tellg();
		in.seekg(0,ios::beg);
		
		in.read(buffer,size);										
		in.close();
		
	
				
		return 0;

}

int  ReadFrameMethodAscii(char * Filename, double* buffer){



		ifstream in(Filename);

		u32 tot;
		int i=0;
		while(!in.eof()){
			in >> tot;
			buffer[i]=tot;
			i++;
		}

		in.close();



		return 0;

}

int DecodeData(char *buffer) {

	int index=0;
	unsigned int Data[MATRIX_SIZE];
	
	
	for(int i =0;i<MATRIX_SIZE;i++){
	
		memcpy(&Data[i],buffer+i*4,4);
		}
	
	
	
	
	for(int i=0;i<256;i++){
		for(int j=0;j<256;j++){
	
		int x,y,tot;
		
		x=i;
		y=j;
		tot=Data[index];
		
		//cout << Data[i] << endl;
		
		if(Data[index]!=0)
			cout << x << " " << y << " " << tot << endl;
	
		index++;
	}}
	
	
	return 0;
	
	

}





int main() {

	//TApplication theApp("App",0,0);

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
	int numberOfChips=0;
	int numberOfRows=0;
	char chipBoardID[MPX_MAX_CHBID];
	char ifaceName[MPX_MAX_IFACENAME];
	
	
	//Get Info on device
	int info = mpxCtrlGetMedipixInfo(devId,&numberOfChips,&numberOfRows,chipBoardID,ifaceName);
	if(info==0) cout << "Number of chips : " << numberOfChips << " Number of rows : " <<  numberOfRows << " chipBoard ID : " <<  chipBoardID << " Interface Name : " << ifaceName <<  endl;
	else cout << "board not found !! " << endl;
	
	
	// Load binary pixels config
	char configName[256] = "configs/bpc_07.09.2012.bpc" ;
	control = mpxCtrlLoadPixelsCfg(devId, configName , true);
	cout << "Load pixels config : " << configName << endl;
	//control << endl;


	// Get number of parameters in the Hw Info list
	int hwInfoCount = 0;
	control = mpxCtrlGetHwInfoCount(devId, &hwInfoCount);
	cout << "count : " << hwInfoCount << endl;

	
	// check mode
	int mode;
	control = mpxCtrlGetAcqMode(devId, &mode);
	cout << "Acq mode = " << mode << endl;

	// Get and Set Daqs
	DACTYPE dacVals[14];
	int chipnumber = 0;
	control = mpxCtrlGetDACs(devId, dacVals, 14, chipnumber);
	cout << "Thl fine = " << dacVals[TPX_THLFINE] << endl;

	dacVals[TPX_THLFINE] = 450; // 1000e- above thl adjustment mean
	control = mpxCtrlSetDACs(devId, dacVals, 14, chipnumber);

	DACTYPE dacVals_new[14];
	control = mpxCtrlGetDACs(devId, dacVals_new, 14, chipnumber);
	cout << "Thl fine = " << dacVals_new[TPX_THLFINE] << endl;
	
	
	// Data type Set
	mgrSetFrameType(1,TYPE_U32);
	
	

	//clock_t start = clock();
	
	
	char *buffer = new char[MATRIX_SIZE*4];
	
	char output[] = "data/test";
	
	
	for (int s =0 ; s< 100; s++){ 
	//TStopwatch timer;
	
	
	//timer.Start();
	
	for (int i =0 ; i< 1; i++){  
	
		control = mpxCtrlPerformFrameAcq(devId, 100, 0.001, FSAVE_BINARY |FSAVE_U32 ,output);
		
// 		u32 frameFilled=0;
// 		while(frameFilled<100){
// 			mpxCtrlGetAcqInfo(devId, NULL, NULL, NULL, &frameFilled);
// 			//cout << "Frame filled" << frameFilled << endl;
// 		}
// 		
		//ReadFrameMethod1("data/test");
		ReadFrameMethod2(output,buffer);
		
		//DecodeData(buffer);
		
		
		//if(i%10==0)printf("Acquisition Frequency : %.8f Hz\n", (double)i/(((double)clock() - start) / (CLOCKS_PER_SEC)));		
	
	}
	
	//timer.Stop();
	
	//printf("time for 100 acq. = %f \n",timer.RealTime());
	//printf("Acquisition Frequency : %.8f Hz\n",100.0/timer.RealTime());
	
	
	}	
		
	//printf("Time elapsed: %.8f\n", ((double)clock() - start) / (CLOCKS_PER_SEC*1000));
	
		
	//theApp.Run();
	
	return 0;
	
	
	
	}
