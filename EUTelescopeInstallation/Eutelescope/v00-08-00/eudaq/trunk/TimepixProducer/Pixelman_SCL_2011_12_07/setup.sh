 export TPPROD=/home/lcd/eudaq/TimepixProducer_august2013
 export EUDAQBIN=/home/lcd/eudaq/bin

 export LD_LIBRARY_PATH=$EUDAQBIN:$LD_LIBRARY_PATH 
 #export LD_LIBRARY_PATH=/afs/cern.ch/user/m/mbenoit/workspace/EUDAQ_TP/eudaq/trunk/bin:$LD_LIBRARY_PATH 

 export LD_LIBRARY_PATH=$TPPROD/Pixelman_SCL_2011_12_07:$LD_LIBRARY_PATH
 alias makeprod="cd ..;make;cd Pixelman_SCL_2011_12_07;cp ../../bin/TimepixProducer.exe ."
 
