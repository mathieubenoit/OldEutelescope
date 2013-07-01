/*
 * TimepixProducer.cxx
 *
 *
 *      Author: Mathieu Benoit
 */

  
#include "eudaq/Producer.hh"
#include "eudaq/Logger.hh"
#include "eudaq/RawDataEvent.hh"
#include "eudaq/Timer.hh"
#include "eudaq/Utils.hh"
#include "eudaq/OptionParser.hh"
#include "eudaq/ExampleHardware.hh"
#include "eudaq/Mutex.hh"
#include "mpxmanagerapi.h"
#include "mpxhw.h"
#include <pthread.h>    /* POSIX Threads */
#include "MIMTLU.h"

#include <iostream>
#include <ostream>
#include <vector>

using namespace std;

#define DEBUGPROD

// A name to identify the raw data format of the events generated
// Modify this to something appropriate for your producer.
static const std::string EVENT_TYPE = "TimepixRaw";

int status;
int AcqPreStarted=0;
int FrameReady;
FRAMEID id;
unsigned int TLU;

MIMTLU *aMIMTLU;


// TOT . start on trigger stop on Timer
char configName[256] = "config_I10-W0015_TOT_4-06-13" ;
char AsciiconfigName[256] = "config_I10-W0015_TOT_4-06-13_ascii" ;

//TOT Start and stop on trigger
//char configName[256] = "config_I10-W0015_TOT_6-06-13_start_stop_on_trigger" ;
//char AsciiconfigName[256] = "config_I10-W0015_TOT_6-06-13_start_stop_on_trigger_ascii" ;


void * fitpix_acq ( void *ptr );


void AcquisitionPreStarted(CBPARAM /*par*/,INTPTR /*aptr*/){
	
#ifdef DEBUGPROD	
	cout << "AcquisitionPreStarted" << endl;	
#endif
	//usleep(1);
	AcqPreStarted=1;

	
	}
	
void AcquisitionStarted(CBPARAM /*par*/,INTPTR /*aptr*/)
{
#ifdef DEBUGPROD	
	cout << "triggerred" << endl; 
#endif
	//TLU = aMIMTLU->GetEvent();

}

void AcquisitionFinished(int /*stuff*/,int /*stuff2*/){
		status =1;
#ifdef DEBUGPROD	
		//cout << "acq finished" << endl;
#endif
	}

void FrameIsReady(int /*stuff*/,int /*stuff2*/){
		FrameReady =1;
#ifdef DEBUGPROD	
		cout << "Frame Ready" << endl;
#endif

	}


template <typename T>
inline void pack (std::vector< unsigned char >& dst, T& data) {
    unsigned char * src = static_cast < unsigned char* >(static_cast < void * >(&data));
    dst.insert (dst.end (), src, src + sizeof (T));
}

template <typename T>
inline void unpack (vector <unsigned char >& src, int index, T& data) {
    copy (&src[index], &src[index + sizeof (T)], &data);
}

class TimepixDevice {

public:

	TimepixDevice(){


		// Init manager
		control = -1;
		u32 flags = MGRINIT_NOEXHANDLING;
		control = mgrInitManager(flags, '\0');
		if(mgrIsRunning()){
			cout << "Manager running " << endl;
		}

		mgrRegisterCallback("mpxctrl",MPXCTRL_CB_ACQCOMPL,&AcquisitionFinished,0);
		mgrRegisterCallback("mpxmgr",MPXMGR_CB_FRAME_NEW,&FrameIsReady,0);
		mgrRegisterCallback("mpxctrl",MPXCTRL_CB_ACQPRESTART,&AcquisitionPreStarted,0);
		mgrRegisterCallback("mpxctrl",MPXCTRL_CB_ACQSTART,&AcquisitionStarted,0);


		// Find device
		count = 0;
		
		
		control = mpxCtrlGetFirstMpx(&devId, &count);
		cout << "found : " << count << " | devId : " << devId << endl;
		numberOfChips=0;
		numberOfRows=0;


		//Get Info on device
		int info = mpxCtrlGetMedipixInfo(devId,&numberOfChips,&numberOfRows,chipBoardID,ifaceName);
		if(info==0) cout << "Number of chips : " << numberOfChips << " Number of rows : " <<  numberOfRows << " chipBoard ID : " <<  chipBoardID << " Interface Name : " << ifaceName <<  endl;
                
		else cout << "board not found !! " << endl;

 
		// Load binary pixels config
		//char configName[256] = "default.bpc" ;
		//char configName[256] = "config_I10-W0015_TOT_4-06-13" ;
		//char configName[256] = "config_I10-W0015_TOA48MHz_4-06-13" ;

		control = mpxCtrlLoadPixelsCfg(devId, configName , true);
		cout << "Load pixels config : " << configName << endl;
		//control << endl;


		//mpxCtrlLoadMpxCfg(devId,"default_ascii");
		mpxCtrlLoadMpxCfg(devId,AsciiconfigName);
		cout << "Load Ascii pixels config : " << AsciiconfigName << endl;

		//mpxCtrlLoadMpxCfg(devId,"config_I10-W0015_TOA48MHz_4-06-13_ascii");


		// Get number of parameters in the Hw Info list
		hwInfoCount = 0;
		control = mpxCtrlGetHwInfoCount(devId, &hwInfoCount);
		cout << "count : " << hwInfoCount << endl;


		// Set bias voltage
		double voltage = 80.0;
		byte triggmode = 2;

		byte * data = new byte(sizeof(double));//(byte)voltage;
		byte * data2 = new byte(sizeof(byte));//(byte)trig;

		data = (byte * )(&voltage);
		data2 = (byte * )(&triggmode);

		//control = mpxCtrlSetHwInfoItem(devId, 8, data, sizeof(double));	 // 8 voltage
		//control = mpxCtrlSetHwInfoItem(devId, 20, &triggmode, 1);
		
		
		usleep(1000000);

		// Read bias voltage and bias voltage verification
		ItemInfo data_hv;
		int datar_size = 0;
		byte trgg_back;
		data_hv.data = &trgg_back;

		mpxCtrlGetHwInfoItem(devId, 20, &data_hv, &datar_size);
		cout << "data size  : " << datar_size << endl;
		cout << "array size : " << data_hv.count << endl;
		cout << "flags      : " << data_hv.flags << endl;
		cout << "name       : " << data_hv.name << endl;
		cout << "descr      : " << data_hv.descr << endl;
		cout << "type       : " << data_hv.type << endl;
		cout << "data       : " << trgg_back << endl;

//		ItemInfo data_hv;
		datar_size = 8;
		double voltage_back;
		data_hv.data = &voltage_back;

		// 18 signal delay u16
		// 12 Freq
		// 8 HV
		// 9 HV ver
		for ( int i = 8; i < 10 ; i++ ) {

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

		//control =mpxCtrlGetAcqMode(devId, &mode);
		//cout << "Acq mode before = " << mode << endl;
		control = mpxCtrlSetAcqMode(devId,ACQMODE_HWTRIGSTART_TIMERSTOP );
		// check mode
		//control =mpxCtrlGetAcqMode(devId, &mode);
		//cout << "Acq mode after = " << mode << endl;
 



		// Data type Set
		mgrSetFrameType(0,TYPE_U32);

		//cout << "Test acquisition" << endl;
		byte *buf=new byte[MATRIX_SIZE];
		//this->PerformAcquisition("test");
		delete buf;





	}




	int  ReadFrame(char * Filename, char* buffer){



			ifstream in(Filename,ios::binary|ios::ate);
			long size = in.tellg();
			in.seekg(0,ios::beg);

			in.read(buffer,size);
			in.close();



			return 0;

	}

	int SetTHL(int THL){

		// Get and Set Daqs
		DACTYPE dacVals[14];
		int chipnumber = 0;

		dacVals[TPX_THLFINE] = THL; // 1000e- above thl adjustment mean
		control = mpxCtrlSetDACs(devId, dacVals, 14, chipnumber);
		cout << "[TimepixProducer] Setting THL Fine to " << THL << endl;

		DACTYPE dacVals_new[14];
		control = mpxCtrlGetDACs(devId, dacVals_new, 14, chipnumber);
		cout << "[TimepixProducer] THL Fine Readout = " << dacVals_new[TPX_THLFINE] << endl;

		control = mpxCtrlRefreshDACs(devId);
		return control; 

	}
	int SetIkrum(int IKrum){

		// Get and Set Daqs
		DACTYPE dacVals[14];
		int chipnumber = 0;

		dacVals[TPX_IKRUM] = IKrum; // 1000e- above thl adjustment mean
		control = mpxCtrlSetDACs(devId, dacVals, 14, chipnumber);
		cout << "[TimepixProducer] Setting Ikrum to " << IKrum << endl;

		DACTYPE dacVals_new[14];
		control = mpxCtrlGetDACs(devId, dacVals_new, 14, chipnumber);
		cout << "[TimepixProducer] IKrum Readout = " << dacVals_new[TPX_IKRUM] << endl;

		control = mpxCtrlRefreshDACs(devId);
		return control;

	}


	int ReadDACs(){


		DACTYPE dacVals_readout[14];
		int chipnumber = 0;

		control = mpxCtrlGetDACs(devId, dacVals_readout, 14, chipnumber);
		cout << "[TimepixProducer] IKrum Readout = " << dacVals_readout[TPX_IKRUM] << endl;
		cout << "[TimepixProducer] DISC Readout = " << dacVals_readout[TPX_DISC] << endl;
		cout << "[TimepixProducer] PREAMP Readout = " << dacVals_readout[TPX_PREAMP] << endl;
		cout << "[TimepixProducer] BUFFA Readout = " << dacVals_readout[TPX_BUFFA] << endl;
		cout << "[TimepixProducer] BUFFB Readout = " << dacVals_readout[TPX_BUFFB] << endl;
		cout << "[TimepixProducer] HIST Readout = " << dacVals_readout[TPX_HIST] << endl;
		cout << "[TimepixProducer] THLFINE Readout = " << dacVals_readout[TPX_THLFINE] << endl;
		cout << "[TimepixProducer] THLCOARSE Readout = " << dacVals_readout[TPX_THLCOARSE] << endl;
		cout << "[TimepixProducer] VCAS Readout = " << dacVals_readout[TPX_VCAS] << endl;
		cout << "[TimepixProducer] FBK Readout = " << dacVals_readout[TPX_FBK] << endl;
		cout << "[TimepixProducer] GND Readout = " << dacVals_readout[TPX_GND] << endl;
		cout << "[TimepixProducer] THS Readout = " << dacVals_readout[TPX_THS] << endl;
		cout << "[TimepixProducer] BIASLVDS Readout = " << dacVals_readout[TPX_BIASLVDS] << endl;
		cout << "[TimepixProducer] REFLVDS Readout = " << dacVals_readout[TPX_REFLVDS] << endl;

		return 0;
	}


	int PerformAcquisition(char *output){

		//cout << "[timepixProducer] Starting acquisition to file " << output << endl;
		control = mpxCtrlPerformFrameAcq(devId, 1,acqTime, FSAVE_BINARY |FSAVE_U32 ,output);

		//mpxCtrlGetFrame32(devId,buffer, MATRIX_SIZE, u32 frameNumber);
		return control;

	}

	int GetFrameData(byte *buffer){

		control=mpxCtrlGetFrameID(devId,0,&FrameID);
		control=mgrGetFrameData(id,buffer, &size , TYPE_DOUBLE);
		return control;
	}
	int  GetFrameData2(char * Filename, char* buffer){



			ifstream in(Filename,ios::binary|ios::ate);
			long size = in.tellg();
			in.seekg(0,ios::beg);

			in.read(buffer,size);
			in.close();



			return 0;

	}

	int  GetFrameDatadAscii(char * Filename, u32* buffer){



			ifstream in(Filename);

			u32 tot;
			int i=0;
			while(!in.eof()){
				in >> tot;
				buffer[i]=tot;
				cout << tot << endl;

				i++;
			}

			in.close();



			return 0;

	}
	u32 GetBufferSize(){return size;}

	int Abort (){
		control = mpxCtrlAbortOperation(devId);
		return control;
	}

   int SetAcqTime(double time){
	   acqTime=time;
   	   return 1;
   }

private:
		int control; // Control int for verifying success of operation
		DEVID devId; // Timepix Device ID
		int count; // Number of chip connected to FitPix
		int numberOfChips;
		int numberOfRows;
		char chipBoardID[MPX_MAX_CHBID];
		char ifaceName[MPX_MAX_IFACENAME];
		double acqTime ;
		bool acqFinished;

		int hwInfoCount;
		int mode;
		DACTYPE dacVals[14];
		int chipnumber;
		u32 size;
		FRAMEID FrameID;
};



// Declare a new class that inherits from eudaq::Producer
class TimepixProducer : public eudaq::Producer {
public:

  // The constructor must call the eudaq::Producer constructor with the name
  // and the runcontrol connection string, and initialize any member variables.
  TimepixProducer(const std::string & name, const std::string & runcontrol)
    : eudaq::Producer(name, runcontrol),
      m_run(0), m_ev(0), stopping(false), done(false) {

	  aTimepix = new TimepixDevice();

	  buffer = new char[4*MATRIX_SIZE];

	  output = new char[1000];

	  sprintf(output,"/home/lcd/eudaq/data/Run%d_%d",m_run,m_ev);
	  //output = "/home/mbenoit/workspace/eudaq/data/Run";
	  running =false;
	  
	  aMIMTLU= new MIMTLU();
	  int mimtlu_status = aMIMTLU->Connect(const_cast<char *>("192.168.1.10"),const_cast<char *>("7"));
	  if(mimtlu_status!=1)	   SetStatus(eudaq::Status::LVL_ERROR, "MIMTLU Not Running !!");



  }

  // This gets called whenever the DAQ is configured
  virtual void OnConfigure(const eudaq::Configuration & config) {
    std::cout << "Configuring: " << config.Name() << std::endl;

    // Do any configuration of the hardware here
    // Configuration file values are accessible as config.Get(name, default)
//    THL = config.Get("THL", 0);
//    aTimepix->SetTHL(THL);


    acqTime = config.Get("AcquisitionTime_us", 0);
    aTimepix->SetAcqTime(acqTime*1.0e-6);

    cout << "[TimepixProducer] Setting Acquisition time to : " << acqTime*1.e-6 << "s" << endl;


//    IKrum = config.Get("IKrum", 0);
//    aTimepix->SetIkrum(IKrum);

    //aTimepix->ReadDACs();

    // At the end, set the status that will be displayed in the Run Control.
    SetStatus(eudaq::Status::LVL_OK, "Configured (" + config.Name() + ")");
  }

  // This gets called whenever a new run is started
  // It receives the new run number as a parameter
  virtual void OnStartRun(unsigned param) {
    m_run = param;
    m_ev = 1;
    std::cout << "Start Run: " << m_run << std::endl;

    // It must send a BORE to the Data Collector
    eudaq::RawDataEvent bore(eudaq::RawDataEvent::BORE(EVENT_TYPE, m_run));
    // You can set tags on the BORE that will be saved in the data file
    // and can be used later to help decoding
    bore.SetTag("EXAMPLE", eudaq::to_string(m_exampleparam));
    // Send the event to the Data Collector
    SendEvent(bore);

    // At the end, set the status that will be displayed in the Run Control.
    SetStatus(eudaq::Status::LVL_OK, "Running");
    //eudaq::mSleep(5000);



    running = true;
  }

  // This gets called whenever a run is stopped
  virtual void OnStopRun() {
    std::cout << "Stopping Run" << std::endl;

    running = false;
   // aTimepix->Abort();

    SetStatus(eudaq::Status::LVL_OK, "Stopped");

    // Set a flag to signal to the polling loop that the run is over
//    stopping = true;
//
//    // wait until all events have been read out from the hardware
//    while (stopping) {
//      eudaq::mSleep(20);
//    }

    // Send an EORE after all the real events have been sent
    // You can also set tags on it (as with the BORE) if necessary
    SendEvent(eudaq::RawDataEvent::EORE("Test", m_run, ++m_ev));

    cout << "[TimepixProducer] Sent EORE " << endl;
 
    //




    system("cp /home/lcd/eudaq/timepixproducer_mb/ramdisk/* ../data");
    system("rm -fr /home/lcd/eudaq/timepixproducer_mb/ramdisk/*");
  }

  // This gets called when the Run Control is terminating,
  // we should also exit.
  virtual void OnTerminate() {
    std::cout << "Terminating..." << std::endl;
    running = false;
    done = true;
    eudaq::mSleep(1000);
  }

  // This is just an example, adapt it to your hardware
  void ReadoutLoop() {
    // Loop until Run Control tells us to terminate
    
    while (!done) {
    	if(running){

    	//sprintf(output,"../data/Run%d_%d",m_run,m_ev);
	sprintf(output,"/home/lcd/eudaq/timepixproducer_mb/ramdisk/Run%d_%d",m_run,m_ev);
    	
	//pthread_mutex_lock(&m_producer_mutex);
    	status=0;
	AcqPreStarted=0;
    	FrameReady=0;
	//cout << "starting new frame" << endl;
    	
	//aMIMTLU->Arm();
	
	
	//Multithreading 
	pthread_t thread1;  /* thread variables */
	pthread_create (&thread1, NULL,  fitpix_acq, (void *) this);
	
	
	    
	

     	while(AcqPreStarted!=1){
				//cout << status << endl;
	    		eudaq::mSleep(0.01);
	    	} 
		cout << "after loop" <<  endl;

aMIMTLU->Arm();
		//cout << "[timepixProducer] Finished acquisition to file " << output <<  endl;

		while(FrameReady!=1){
				//cout << status << endl;
	    		eudaq::mSleep(0.01);
	    	} 
pthread_join(thread1, NULL);

	TLU = aMIMTLU->GetEvent();
/*	if((m_ev%(128*256))-TLU!=0) {
	    
	  // SetStatus(eudaq::Status::LVL_ERROR, "Mismatch");
	   cout << "TLU: " << TLU << " " << "event counter : " << m_ev << endl;	 
	}*/
	
	if(TLU==0) {
	    
	  // SetStatus(eudaq::Status::LVL_ERROR, "Mismatch");
	   cout << "TLU: " << TLU << " " << "event counter : " << m_ev << endl;	 
	}

    	//u32 *bufferAscii = new u32[MATRIX_SIZE];
	//control=aTimepix->GetFrameDatadAscii(output,bufferAscii);
	control=aTimepix->GetFrameData2(output,buffer);
	
	//buffer=(char*)bufferAscii;
    	//pthread_mutex_unlock(&m_producer_mutex);

    	//pthread_mutex_lock(&m_producer_mutex);
    	//status=aTimepix->ReadFrame(output,buffer);
    	//pthread_mutex_unlock(&m_producer_mutex);

    	unsigned int Data[MATRIX_SIZE];

    	for(int i =0;i<MATRIX_SIZE;i++){

    		memcpy(&Data[i],buffer+i*4,4);

    		}
        int pos =0;

        std::vector<unsigned char> bufferOut;
	std::vector<unsigned char> bufferTLU;
	pack(bufferTLU,TLU);
        for(unsigned int i=0;i<256;i++){
           		for(unsigned int j=0;j<256;j++){

           			if(Data[pos]!=0){

           				//cout << "[Data] Evt : " << m_ev << " " << i << " " << j << " " << Data[pos] << endl;
           				pack(bufferOut,i);
           				pack(bufferOut,j);
           				pack(bufferOut,Data[pos]);
           				//pack(bufferOut,i);
           			}

           				//pack(bufferOut,i);
           				// pack(bufferOut,j);
           				//pack(bufferOut,m_ev);
           			pos++;

           		}

           		}

    	if(m_ev%100==0 | m_ev<100) cout << "event #" << m_ev << endl;
	if(m_ev%1000==0 ) {
			
			    //system("cp /home/lcd/eudaq/timepixproducer_mb/ramdisk/* ../data");
    			    system("rm -fr /home/lcd/eudaq/timepixproducer_mb/ramdisk/*");

			}

//    if (!hardware.EventsPending()) {
//        // No events are pending, so check if the run is stopping
//        if (stopping) {
//          // if so, signal that there are no events left
//          stopping = false;
//        }
//        // Now sleep for a bit, to prevent chewing up all the CPU
//        eudaq::mSleep(20);
//        // Then restart the loop
//        continue;
//      }

      // If we get here, there must be data to read out
      // Create a RawDataEvent to contain the event data to be sent
      eudaq::RawDataEvent ev(EVENT_TYPE, m_run, m_ev);

//      for (unsigned plane = 0; plane < hardware.NumSensors(); ++plane) {
//        // Read out a block of raw data from the hardware
//        std::vector<unsigned char> buffer = hardware.ReadSensor(plane);
//        // Each data block has an ID that is used for ordering the planes later
//        // If there are multiple sensors, they should be numbered incrementally
//
//        // Add the block of raw data to the event
//        ev.AddBlock(plane, buffer);
//      }
//      std::vector<unsigned char> bufferV;
//      for(int i =0; i<MATRIX_SIZE;i++){
//
//    	  bufferV.push_back(buffer[i]);
//
//      }
      ev.AddBlock(0, bufferOut);
      ev.AddBlock(1,bufferTLU);
      // Send the event to the Data Collector
      SendEvent(ev);
      // Now increment the event number
      m_ev++;
    	}
    }
  }

void runfitpix()
{
cout << "before run"<<endl;
	control=aTimepix->PerformAcquisition(output);
cout << "after run"<<endl;
}

private:
  // This is just a dummy class representing the hardware
  // It here basically that the example code will compile
  // but it also generates example raw data to help illustrate the decoder
  eudaq::ExampleHardware hardware;
  unsigned m_run, m_ev, m_exampleparam;
  int THL;
  int IKrum;
  bool stopping, done;
  TimepixDevice *aTimepix;
  char *buffer;
  char* output;
  bool running;
  double acqTime;
  pthread_mutex_t m_producer_mutex;
  int control;

};

// The main function that will create a Producer instance and run it
int main(int /*argc*/, const char ** argv) {
  // You can use the OptionParser to get command-line arguments
  // then they will automatically be described in the help (-h) option
  eudaq::OptionParser op("EUDAQ Example Producer", "1.0",
                         "Just an example, modify it to suit your own needs");
  eudaq::Option<std::string> rctrl(op, "r", "runcontrol",
                                   "tcp://localhost:44000", "address",
                                   "The address of the RunControl.");
  eudaq::Option<std::string> level(op, "l", "log-level", "NONE", "level",
                                   "The minimum level for displaying log messages locally");
  eudaq::Option<std::string> name (op, "n", "name", "Example", "string",
                                   "The name of this Producer");
  try {
    // This will look through the command-line arguments and set the options
    op.Parse(argv);
    // Set the Log level for displaying messages based on command-line
    EUDAQ_LOG_LEVEL(level.Value());
    // Create a producer
    TimepixProducer producer(name.Value(), rctrl.Value());
    // And set it running...
    producer.ReadoutLoop();
    // When the readout loop terminates, it is time to go
    std::cout << "Quitting" << std::endl;
  } catch (...) {
    // This does some basic error handling of common exceptions
    return op.HandleMainException();
  }
  return 0;
}

MIMTLU::MIMTLU() {
	// TODO Auto-generated constructor stub

}



int MIMTLU::Connect(char* IP,char* port){

	memset(&host_info, 0, sizeof host_info);
	host_info.ai_family = AF_UNSPEC;     // IP version not specified. Can be both.
	host_info.ai_socktype = SOCK_STREAM; // Use SOCK_STREAM for TCP or SOCK_DGRAM for UDP.


	// Address
	status = getaddrinfo(IP,port, &host_info, &host_info_list);
	if (status != 0)
		{
		cout << "[MIMTLU] getaddrinfo error" << gai_strerror(status) << endl;
		return -1;
		};

	// Socket
	socketfd = socket(host_info_list->ai_family, host_info_list->ai_socktype,
			host_info_list->ai_protocol);

	if (socketfd == -1) {
				std::cout << "[MIMTLU] Socket error " << endl;
				return -2;
	};

	// Connection
	status = connect(socketfd, host_info_list->ai_addr, host_info_list->ai_addrlen);
	if (status == -1)  {
		std::cout << "connect error " << gai_strerror(status) << " " << host_info.ai_flags << endl;
		return -3;
	}
	else {
		std::cout << "[MIMTLU] connect established " << endl;
		return 1;

	}




}


int MIMTLU::Arm(){

#ifdef DEBUGPROD	
	std::cout << "ARM"<<std::endl;
#endif
        memset(msg,0,1024);
	sprintf(msg,"ARM");
	len = sizeof(msg);
	bytes_sent = send(socketfd,msg, 8, 0);
	
//	incoming_data_buffer= 0;
	bytes_recieved = recv(socketfd, incoming_data_buffer,8, 0);

//std::cout << incoming_data_buffer<<std::endl;

	// If no data arrives, the program will just wait here until some data arrives.
	if (bytes_recieved == 0) {
		std::cout << "host shut down." << std::endl ;
		return -100;
	}
	else if (bytes_recieved == -1){
		std::cout << "recieve error!" << std::endl ;
		return -200;
	}
	else{
	//std::cout << incoming_data_buffer<<std::endl;
		return 0;
	}

}

int MIMTLU::GetEvent(){

        memset(msg,0,1024);
#ifdef DEBUGPROD		
	std::cout << "READ"<<std::endl;
#endif
	sprintf(msg,"READ");
	len = sizeof(msg);
	bytes_sent = send(socketfd,msg, 8, 0);

	//incoming_data_buffer= 0;
	bytes_recieved = recv(socketfd, &incoming_data_buffer,8, 0);
	// If no data arrives, the program will just wait here until some data arrives.

#ifdef DEBUGPROD		
	std::cout << "buffer : " << incoming_data_buffer<<std::endl;
#endif
	
	if (bytes_recieved == 0) {
		std::cout << "host shut down." << std::endl ;
		return -100;
	}
	else if (bytes_recieved == -1){
		std::cout << "recieve error!" << std::endl ;
		return -200;
	}
	else{
		sscanf(incoming_data_buffer,"%x",&tluevtnr);
		//std::cout << "read "<<tluevtnr<<std::endl;
		
		return tluevtnr;
	}
	
	
}


void * fitpix_acq ( void *ptr )
{
    TimepixProducer *tp=(TimepixProducer *) ptr;            
    tp->runfitpix();  
    pthread_exit(0); /* exit */
} /* print_message_function ( void *ptr ) */