#include <iostream>


using namespace std; 


class Track {
 public:
    int m_cluster;
    double *m_trackX;
    double *m_trackY;
    double *m_chi2; 
    int m_event;
    int *m_ndof;
    int *m_iden;
    int *m_trackNum;
 
 
    Track() {
    	
	m_cluster=-11;
    	m_trackX=0;
    	m_trackY=0;
    	m_chi2 = 0; 
    	m_event=0;
    	m_ndof = 0;
    	m_iden = 0;
    	m_trackNum = 0;
    }

    void Fill( double *x, double *y,double *chi2,int event,int *ndof,int *iden,int *trackNum ) {
    
    	m_trackX=x;
    	m_trackY=y;
    	m_chi2 = chi2; 
    	m_event=event;
    	m_ndof = ndof;
    	m_iden = iden;
    	m_trackNum = trackNum;
    	m_cluster=-11;        
    }

    void Print() {
 /*       cout <<  "##### Track #####" << endl;
       for (int i=0;i<size(m_trackX);i++){
       cout << "Track X : " << m_trackX[i] << " TrackY : " << m_trackY[i] << " iden : " << m_iden[i] << " cluster :  " << m_cluster << endl; 
  */      
    //   }
    }


 };
