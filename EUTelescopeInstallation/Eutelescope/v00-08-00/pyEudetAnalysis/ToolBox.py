import numpy as np
from scipy.optimize import minimize
from ROOT import *
import ROOT
from math import *
from array import array 
from EudetData import *
from Constant import *

def RotationMatrix(theta):
    tx,ty,tz = theta
    tx = 2*pi*tx/360.
    ty = 2*pi*ty/360. 
    tz = 2*pi*tz/360.
    Rx = np.array([[1,0,0], [0, cos(tx), -sin(tx)], [0, sin(tx), cos(tx)]])
    Ry = np.array([[cos(ty), 0, -sin(ty)], [0, 1, 0], [sin(ty), 0, cos(ty)]])
    Rz = np.array([[cos(tz), -sin(tz), 0], [sin(tz), cos(tz), 0], [0,0,1]])

    return np.dot(Rx, np.dot(Ry, Rz))


def rms(x):
    r"""Compute root mean square."""

    x = np.asanyarray(x)
    rms = np.sqrt(np.sum(x ** 2) / x.size)

    return rms

def TrackClusterCorrelation(dataSet):
    
    histox = TH2D("corX","corX",256,0,256*0.055,256,0,256*0.055)
    histoy = TH2D("corY","corY",256,0,256*0.055,256,0,256*0.055)
    hl = [histox,histoy]
    
    for h in hl : 
        h.GetXaxis().SetTitle("Cluster Position (mm)")
        h.GetYaxis().SetTitle("Track position (mm)")
        
    for i,tracks in enumerate(dataSet.AllTracks) : 
        for track in tracks :
            for cluster in dataSet.AllClusters[i] : 
                    if cluster.totalTOT<500 :
                        histox.Fill(cluster.relX,track.trackX[3])
                        histoy.Fill(cluster.relY,track.trackY[3])                    
    return histox,histoy


def TotalMeanFunctionX(Translations,Rotations,aDataDet,nevents,skip,dut=6):
    
    totaldist_evaluator = 0.
    n = 0
    for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
        for track in tracks:
	    if i%skip==0 : 	
		     for cluster in aDataDet.AllClusters[i] : 
                	 tmp=np.dot(RotationMatrix(Rotations),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
                	 tmp[0] = tmp[0] + Translations[0]
                	 tmp[1] = tmp[1] 
                	 distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2 -tmp[0]
                	 disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2 -tmp[1]                 

			 if fabs(distx)<0.1 and fabs(disty)<0.1:
				 totaldist_evaluator+=distx 
				 n+=1
    print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Translations[0],0,fabs(totaldist_evaluator/n),n)
    return fabs(totaldist_evaluator/n)
    # return -n

def TotalMeanFunctionY(Translations,Tx,Rotations,aDataDet,nevents,skip,dut=6):
    
    totaldist_evaluator = 0.
    n = 0
    for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
        for track in tracks:
	    if i%skip==0 : 
		    for cluster in aDataDet.AllClusters[i] : 
                	tmp=np.dot(RotationMatrix(Rotations),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
                	tmp[0] = tmp[0] + Tx
                	tmp[1] = tmp[1] + Translations[0]
                	distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2 -tmp[0]
                	disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2 -tmp[1]                 

			if fabs(distx)<0.1 and fabs(disty)<0.1:
				totaldist_evaluator+=disty
				n+=1
    print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Tx,Translations[0],fabs(totaldist_evaluator/n),n)
    return fabs(totaldist_evaluator/n)
    # return -n



def TotalRotationFunction(Rotations,Translations,aDataDet,nevents,skip,dut=6):
    
    totaldist_evaluator = 0.
    n = 0
    dist_tmp_x = []
    dist_tmp_y = []
  
    for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
        for track in tracks:
	    if i%skip==0 : 
		    for cluster in aDataDet.AllClusters[i] : 

                	tmp=np.dot(RotationMatrix(Rotations),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
                	tmp[0] = tmp[0] + Translations[0]
                	tmp[1] = tmp[1] 
                	distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2 -tmp[0]
                	disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2 -tmp[1]                


			if fabs(distx)<0.075 and fabs(disty)<0.075:
				dist_tmp_x.append(distx)
				dist_tmp_y.append(disty)
				n+=1
	
    result=sqrt(rms(dist_tmp_x)**2 + rms(dist_tmp_y)**2)
    print "Evaluating for Rotation : %.9f %.9f %.9f [deg] Trans : %f %f  [mm] metric = %.9f  n = %i"%(Rotations[0],Rotations[1],Rotations[2],Translations[0],0,result,n)
    return result




def TotalDistanceFunction(parameters,aDataDet,nevents,skip,dut=6):
    
    totaldist_evaluator = 0.
    n = 0
    dist_tmp_x = []
    dist_tmp_y = []
    for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
        for track in tracks:
	    if i%skip==0 : 
	    
		    for cluster in aDataDet.AllClusters[i] : 
                	#print len(aDataDet.AllClusters[i]),track.cluster
                	#cluster = aDataDet.AllClusters[i][track.cluster]
                	tmp=np.dot(RotationMatrix(parameters[0:3]),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
                	tmp[0] = tmp[0] + parameters[3]
                	tmp[1] = tmp[1] + parameters[4]


			dist=sqrt(pow( track.trackX[track.iden.index(dut)]-npix_X*pitchX/2. -tmp[0],2)+pow( track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2. -tmp[1],2))		
			distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2. -tmp[0]
                	disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2. -tmp[1]                

 			if(fabs(distx)<0.1 and fabs(disty)<0.1):
                		dist_tmp_x.append(distx)
                		dist_tmp_y.append(disty)               
				totaldist_evaluator+=distx
				n+=1

    if(n!=0):
    	result = fabs(totaldist_evaluator/n) 
    else :
    	result = 1000.
    print "Evaluating for Rotation : %f %f %f [deg] Trans : %f %f  [mm] metric = %f  n = %i"%(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],result,n)
    return result
 
 
 
 
        
def PerformAlignement(aDataSet, boundary) :
    x0 = np.array([0.,0.,0.,0.,0])
    res = minimize(TotalDistanceFunction,x0,[aDataSet,3000],method='Nelder-Mead',options={'disp': True})
    return res.x[0:3],res.x[3:]
    
    
def Perform3StepAlignment(aDataSet,boundary,nevent,skip) : 
    x_tx = np.array([0.])
    x_ty = np.array([0.])
    xr= np.array([0.,0.,0.])
    resr = minimize(TotalRotationFunction,xr,[x_tx,aDataSet,nevent,skip],method='BFGS',options={'disp': True})    
    rest = minimize(TotalMeanFunctionX,x_tx,[resr.x,aDataSet,nevent,skip],method='Nelder-Mead',options={'xtol': 1e-5,'disp': True}) 
    rest2 = minimize(TotalMeanFunctionY,x_ty,[rest.x[0],resr.x,aDataSet,nevent,skip],method='Nelder-Mead',options={'xtol': 1e-5,'disp': True}) 
      
    return resr.x ,[rest.x[0],rest2.x[0],0]

def ApplyAlignment(dataSet,translations,rotations,filename="Alignement.txt") :
    
    print "Applying Alignment with  Rotation : %0.10f %0.10f %0.10f [deg] Trans : %0.10f %0.10f  [mm]"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1])
    
    f = open(filename,'w')
    f.write("Rotation : %f %f %f [deg] Trans : %f %f  [mm]"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1]))
    f.close()
    for Clusters in dataSet.AllClusters : 
        for cluster in Clusters : 
            tmp=np.dot(RotationMatrix(rotations),[cluster.relX-npix_X*pitchX/2.,cluster.relY-npix_Y*pitchY/2.,0])
            cluster.absX = tmp[0] + translations[0]
            cluster.absY = tmp[1] + translations[1]
            cluster.absZ = tmp[2] + translations[2]            
            
    
