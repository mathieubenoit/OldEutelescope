#include <iostream>


using namespace std; 


class Track {
 public:
    int cluster;
    double *trackX;
    double *trackY;
    double *chi2; 
    int event;
    int *ndof;
    int *iden;
    int *trackNum;
 
 
    Track() {
    	
	cluster=-11;
    	trackX=0;
    	trackY=0;
    	chi2 = 0; 
    	event=0;
    	ndof = 0;
    	iden = 0;
    	trackNum = 0;
    }

    void Fill( double *x, double *y,double *chi2,int event,int *ndof,int *iden,int *trackNum ) {
    
    	this->trackX=x;
    	this->trackY=y;
    	this->chi2 = chi2; 
    	this->event=event;
    	this->ndof = ndof;
    	this->iden = iden;
    	this->trackNum = trackNum;
    	this->cluster=-11;        
    }

    void Print() {
 /*       cout <<  "##### Track #####" << endl;
       for (int i=0;i<size(m_trackX);i++){
       cout << "Track X : " << m_trackX[i] << " TrackY : " << m_trackY[i] << " iden : " << m_iden[i] << " cluster :  " << m_cluster << endl; 
  */      
    //   }
    }


 };



