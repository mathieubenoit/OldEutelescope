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

def ComputeChargeDistance(dataSet,d=0.005,dut=6):
    AllDistances = [0.]
    AllCharges = [0.]
    
    for i,tracks in enumerate(dataSet.AllTracks) : 
        for track in tracks : 
            if track.cluster!=-11 :
                if(dataSet.AllClusters[i][track.cluster].size==2) :
                    maxTOTindex_tmp=0
                    maxTOT_tmp=dataSet.AllClusters[i][track.cluster].tot[0]
#looking for the pixel with the highest energy
                    for index,tot_tmp in enumerate(dataSet.AllClusters[i][track.cluster].tot) :
                        print "tot_tmp : "
                        print tot_tmp
                        if dataSet.AllClusters[i][track.cluster].tot[index]>maxTOT_tmp:
                            maxTOT_tmp=dataSet.AllClusters[i][track.cluster].tot[index]
                            maxTOTindex_tmp=index
     
#computing for the track positions X and Y in the pixel and the relative charge i.e. Qrel = (charge of the pixel with the highest energy)/(total charge of the cluster)
                    X = (track.trackX[track.iden.index(dut)])%pitchX
                    Y = (track.trackY[track.iden.index(dut)])%pitchY
#                     X = (dataSet.AllClusters[i][track.cluster].col[maxTOTindex_tmp]*pitchX+pitchX/2.)%pitchX
#                     Y = (dataSet.AllClusters[i][track.cluster].row[maxTOTindex_tmp]*pitchY+pitchY/2.)%pitchY
#                     X = (dataSet.AllClusters[i][track.cluster].absX)%pitchX
#                     Y = (dataSet.AllClusters[i][track.cluster].absY)%pitchY
                    Qrel = (dataSet.AllClusters[i][track.cluster].tot[maxTOTindex_tmp])/(dataSet.AllClusters[i][track.cluster].totalTOT)
#firing tracks for whom the position is in the corner of the pixel
                    if((X<=d and Y<=d) or (X>=d and Y<=d) or (X>=d and Y>=d) or (X<=d and Y>=d)) :
                        break
                    else :                    
#finding the region of the track in the pixel and computing the minimal distance between the track position and the pixel edge
                        if(Y<X and Y<(-X+pitchY)):
                            d = Y                
                        elif(Y<X and Y>=(-X+pitchY)):
                            d = pitchX - X
                        elif(Y>=X and Y<(-X+pitchY)):
                            d = X
                        elif(Y>=X and Y>=(-X+pitchY)):
                            d = pitchY - Y

#checking computations...
                    print "maxTOTindex_tmp : "
                    print maxTOTindex_tmp
                    print "dataSet.AllClusters[i][track.cluster].col[maxTOTindex_tmp] : "
                    print dataSet.AllClusters[i][track.cluster].col[maxTOTindex_tmp]   
                    print "dataSet.AllClusters[i][track.cluster].tot[maxTOTindex_tmp] : "
                    print dataSet.AllClusters[i][track.cluster].tot[maxTOTindex_tmp]
                    print "dataSet.AllClusters[i][track.cluster].totalTOT : "
                    print dataSet.AllClusters[i][track.cluster].totalTOT                    
                    print "X : "
                    print X
                    print "Y : "
                    print Y
                    print "Qrel : "
                    print Qrel
                    print "d : "
                    print d
                    
#adding points to the list of Qrel and minDistances
                    AllDistances.append(d)
                    AllCharges.append(Qrel)
#     print AllDistances
#     print AllCharges
    return AllDistances,AllCharges
    

def TrackHitProb(dataSet,nbin,dut=6):
    HitProb_1_track = TH2D("HitProb_1_track_nbin%i"%nbin,"Hit probability, cluster size 1",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_1_track.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_1_track.GetXaxis().SetTitle("Track X position within pixel [mm]")
    #HitProb_1_track.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_1_track.GetYaxis().SetTitle("Track Y position within pixel [mm]")
      
    HitProb_2_track = TH2D("HitProb_2_track_nbin%i"%nbin,"Hit probability, cluster size 2",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_2_track.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_2_track.GetXaxis().SetTitle("Track X position within pixel [mm]")
    #HitProb_2_track.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_2_track.GetYaxis().SetTitle("Track Y position within pixel [mm]")
      
    HitProb_3_track = TH2D("HitProb_3_track_nbin%i"%nbin,"Hit probability, cluster size 3",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_3_track.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_3_track.GetXaxis().SetTitle("Track X position within pixel [mm]")
    #HitProb_3_track.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_3_track.GetYaxis().SetTitle("Track Y position within pixel [mm]")
      
    HitProb_4_track = TH2D("HitProb_4_track_nbin%i"%nbin,"Hit probability, cluster size 4",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_4_track.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_4_track.GetXaxis().SetTitle("Track X position within pixel [mm]")
    #HitProb_4_track.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_4_track.GetYaxis().SetTitle("Track Y position within pixel [mm]")  
      
    for i,tracks in enumerate(dataSet.AllTracks) : 
        for track in tracks : 
            if track.cluster!=-11 :
                if(dataSet.AllClusters[i][track.cluster].size==1) : 
                    HitProb_1_track.Fill((track.trackX[track.iden.index(dut)])%pitchX,(track.trackY[track.iden.index(dut)])%pitchY) 
                elif(dataSet.AllClusters[i][track.cluster].size==2) : 
                    HitProb_2_track.Fill((track.trackX[track.iden.index(dut)])%pitchX,(track.trackY[track.iden.index(dut)])%pitchY)  
                elif(dataSet.AllClusters[i][track.cluster].size==3) : 
                    HitProb_3_track.Fill((track.trackX[track.iden.index(dut)])%pitchX,(track.trackY[track.iden.index(dut)])%pitchY)
                elif(dataSet.AllClusters[i][track.cluster].size==4) : 
                    HitProb_4_track.Fill((track.trackX[track.iden.index(dut)])%pitchX,(track.trackY[track.iden.index(dut)])%pitchY)
    
    return HitProb_1_track,HitProb_2_track,HitProb_3_track,HitProb_4_track

    # for i in range(aDataSet.p_nEntries) : 
    #     aDataSet.getEvent(i)
    #     print "Event %d"%i
    #     for j,cluster in enumerate(aDataSet.AllClusters[i]) : 
    #         print "cluster %d"%j
    #         print aDataSet.t_posX[3]
    #         if(cluster.size==1) : 
    #             HitProb_1_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY) 
    #         elif(cluster.size==2) : 
    #             HitProb_2_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY)  
    #         elif(cluster.size==3) : 
    #             HitProb_3_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY) 
    #         elif(cluster.size==4) : 
    #             HitProb_4_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY) 
                        
    # for clusters in aDataSet.AllClusters : 
    #     for cluster in clusters : 
    #         if(cluster.size==1) : 
    #             HitProb_1_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY) 
    #         elif(cluster.size==2) : 
    #             HitProb_2_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY)  
    #         elif(cluster.size==3) : 
    #             HitProb_3_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY) 
    #         elif(cluster.size==4) : 
    #             HitProb_4_track.Fill((aDataSet.t_posX[3]-npix_X*pitchX/2)%pitchX,(aDataSet.t_posY[3]-npix_Y*pitchY/2)%pitchY)  

def ClusterHitProb(dataSet,nbin,dut=6):
    HitProb_1_cluster = TH2D("HitProb_1_cluster_nbin%i"%nbin,"Hit probability, cluster size 1",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_1_cluster.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_1_cluster.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
    #HitProb_1_cluster.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_1_cluster.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")
     
    HitProb_2_cluster = TH2D("HitProb_2_cluster_nbin%i"%nbin,"Hit probability, cluster size 2",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_2_cluster.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_2_cluster.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
    #HitProb_2_cluster.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_2_cluster.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")
     
    HitProb_3_cluster = TH2D("HitProb_3_cluster_nbin%i"%nbin,"Hit probability, cluster size 3",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_3_cluster.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_3_cluster.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
    #HitProb_3_cluster.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_3_cluster.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")
     
    HitProb_4_cluster = TH2D("HitProb_4_cluster_nbin%i"%nbin,"Hit probability, cluster size 4",nbin,0.,0.055,nbin,0.,0.055)
    #HitProb_4_cluster.GetXaxis().SetRangeUser(0.,0.055)
    HitProb_4_cluster.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
    #HitProb_4_cluster.GetYaxis().SetRangeUser(0.,0.055)
    HitProb_4_cluster.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")
     
    for i,tracks in enumerate(dataSet.AllTracks) : 
        for track in tracks : 
            if track.cluster!=-11 :
#                 print 'len(dataSet.AllClusters[i]) : '
#                 print len(dataSet.AllClusters[i])
#                 print 'track.cluster : '
#                 print track.cluster
                if(dataSet.AllClusters[i][track.cluster].size==1) : 
                    HitProb_1_cluster.Fill((dataSet.AllClusters[i][track.cluster].relX)%pitchX,(dataSet.AllClusters[i][track.cluster].relY)%pitchY) 
                elif(dataSet.AllClusters[i][track.cluster].size==2) : 
                    HitProb_2_cluster.Fill((dataSet.AllClusters[i][track.cluster].relX)%pitchX,(dataSet.AllClusters[i][track.cluster].relY)%pitchY)  
                elif(dataSet.AllClusters[i][track.cluster].size==3) : 
                    HitProb_3_cluster.Fill((dataSet.AllClusters[i][track.cluster].relX)%pitchX,(dataSet.AllClusters[i][track.cluster].relY)%pitchY) 
                elif(dataSet.AllClusters[i][track.cluster].size==4) : 
                    HitProb_4_cluster.Fill((dataSet.AllClusters[i][track.cluster].relX)%pitchX,(dataSet.AllClusters[i][track.cluster].relY)%pitchY)
                
    return HitProb_1_cluster,HitProb_2_cluster,HitProb_3_cluster,HitProb_4_cluster


def TrackClusterCorrelation(dataSet,dut=6):
    
    histox = TH2D("corX","corX",(npix_X),-(npix_X)*pitchX/2.,(npix_X)*pitchX/2.,(npix_X),-(npix_X)*pitchX/2.,(npix_X)*pitchX/2.)
    histoy = TH2D("corY","corY",(npix_Y),-(npix_Y)*pitchY/2.,(npix_Y)*pitchY/2.,(npix_Y),-(npix_Y)*pitchY/2.,(npix_Y)*pitchY/2.)
    hl = [histox,histoy]
    
    for h in hl : 
        h.GetXaxis().SetTitle("Cluster Position (mm)")
        h.GetYaxis().SetTitle("Track position (mm)")
        
    for i,tracks in enumerate(dataSet.AllTracks) : 
        for track in tracks :
            for index,cluster in enumerate(dataSet.AllClusters[i]) :
                    if cluster.totalTOT<500 :
                        histox.Fill(cluster.absX,track.trackX[track.iden.index(dut)])
                        histoy.Fill(cluster.absY,track.trackY[track.iden.index(dut)])                    
    return histox,histoy


def TotalMeanFunctionX(Translations,Rotations,aDataDet,nevents,skip,dut=6):
   
    totaldist_evaluator = 0.
    n = 0
    for i,clusters in enumerate(aDataDet.AllClusters[0:nevents]) : 
        for index,cluster in enumerate(clusters) :
            if i%skip==0 :     
                for track in aDataDet.AllTracks[i] : 
                    tmp=np.dot(RotationMatrix(Rotations),[track.trackX[track.iden.index(dut)],track.trackY[track.iden.index(dut)],0])
                    tmp[0] = tmp[0] + Translations[0]
                    tmp[1] = tmp[1] 
                    distx=cluster.absX -tmp[0]
                    disty=cluster.absY -tmp[1]                 
    
                    if fabs(distx)<0.1 and fabs(disty)<0.1:
                        totaldist_evaluator+=distx 
                        n+=1
    print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Translations[0],0,fabs(totaldist_evaluator/n),n)
    return fabs(totaldist_evaluator/n)
    # return -n
    
#     totaldist_evaluator = 0.
#     n = 0
#     for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
#         for track in tracks:
# 	    if i%skip==0 : 	
# 		     for cluster in aDataDet.AllClusters[i] : 
#                 	 tmp=np.dot(RotationMatrix(Rotations),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
#                 	 tmp[0] = tmp[0] + Translations[0]
#                 	 tmp[1] = tmp[1] 
#                 	 distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2 -tmp[0]
#                 	 disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2 -tmp[1]                 
# 
# 			 if fabs(distx)<0.1 and fabs(disty)<0.1:
# 				 totaldist_evaluator+=distx 
# 				 n+=1
#     print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Translations[0],0,fabs(totaldist_evaluator/n),n)
#     return fabs(totaldist_evaluator/n)
#     # return -n

def TotalMeanFunctionY(Translations,Tx,Rotations,aDataDet,nevents,skip,dut=6):

    totaldist_evaluator = 0.
    n = 0
    for i,clusters in enumerate(aDataDet.AllClusters[0:nevents]) : 
        for index,cluster in enumerate(clusters) :
            if i%skip==0 : 
                for track in aDataDet.AllTracks[i] : 
                    tmp=np.dot(RotationMatrix(Rotations),[track.trackX[track.iden.index(dut)],track.trackY[track.iden.index(dut)],0])
                    tmp[0] = tmp[0] + Tx
                    tmp[1] = tmp[1] + Translations[0]
                    distx=cluster.absX -tmp[0]
                    disty=cluster.absY -tmp[1]                 
    
                    if fabs(distx)<0.1 and fabs(disty)<0.1:
                        totaldist_evaluator+=disty
                        n+=1
    print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Tx,Translations[0],fabs(totaldist_evaluator/n),n)
    return fabs(totaldist_evaluator/n)
    # return -n
    
#     totaldist_evaluator = 0.
#     n = 0
#     for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
#         for track in tracks:
# 	    if i%skip==0 : 
# 		    for cluster in aDataDet.AllClusters[i] : 
#                 	tmp=np.dot(RotationMatrix(Rotations),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
#                 	tmp[0] = tmp[0] + Tx
#                 	tmp[1] = tmp[1] + Translations[0]
#                 	distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2 -tmp[0]
#                 	disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2 -tmp[1]                 
# 
# 			if fabs(distx)<0.1 and fabs(disty)<0.1:
# 				totaldist_evaluator+=disty
# 				n+=1
#     print "Evaluating for Trans : %.9f %.9f  [mm] metric = %.9f  n = %i"%(Tx,Translations[0],fabs(totaldist_evaluator/n),n)
#     return fabs(totaldist_evaluator/n)
#     # return -n



def TotalRotationFunction(Rotations,Translations,aDataDet,nevents,skip=1,dut=6):

    totaldist_evaluator = 0.
    n = 0
    dist_tmp_x = []
    dist_tmp_y = []
  
    for i,clusters in enumerate(aDataDet.AllClusters[0:nevents]) : 
        for index,cluster in enumerate(clusters) :
            if i%skip==0 : 
                for track in aDataDet.AllTracks[i] : 
    
                    tmp=np.dot(RotationMatrix(Rotations),[track.trackX[track.iden.index(dut)],track.trackY[track.iden.index(dut)],0])
                    tmp[0] = tmp[0] + Translations[0]
                    tmp[1] = tmp[1] 
                    distx=cluster.absX -tmp[0]
                    disty=cluster.absY -tmp[1]                
    
    
                    if fabs(distx)<0.075 and fabs(disty)<0.075:
                        dist_tmp_x.append(distx)
                        dist_tmp_y.append(disty)
                        n+=1
    
    result=sqrt(rms(dist_tmp_x)**2 + rms(dist_tmp_y)**2)
    print "Evaluating for Rotation : %.9f %.9f %.9f [deg] Trans : %f %f  [mm] metric = %.9f  n = %i"%(Rotations[0],Rotations[1],Rotations[2],Translations[0],0,result,n)
    return result
    
#     totaldist_evaluator = 0.
#     n = 0
#     dist_tmp_x = []
#     dist_tmp_y = []
#   
#     for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
#         for track in tracks:
# 	    if i%skip==0 : 
# 		    for cluster in aDataDet.AllClusters[i] : 
# 
#                 	tmp=np.dot(RotationMatrix(Rotations),[cluster.absX,cluster.absY,0])
#                 	tmp[0] = tmp[0] + Translations[0]
#                 	tmp[1] = tmp[1] 
#                 	distx=track.trackX[track.iden.index(dut)] -tmp[0]
#                 	disty=track.trackY[track.iden.index(dut)] -tmp[1]                
# 
# 
#                     if fabs(distx)<0.075 and fabs(disty)<0.075:
#                         dist_tmp_x.append(distx)
#                         dist_tmp_y.append(disty)
#                         n+=1
# 	
#     result=sqrt(rms(dist_tmp_x)**2 + rms(dist_tmp_y)**2)
#     print "Evaluating for Rotation : %.9f %.9f %.9f [deg] Trans : %f %f  [mm] metric = %.9f  n = %i"%(Rotations[0],Rotations[1],Rotations[2],Translations[0],0,result,n)
#     return result




def TotalDistanceFunction(parameters,aDataDet,nevents,skip,dut=6):

    totaldist_evaluator = 0.
    n = 0
    dist_tmp_x = []
    dist_tmp_y = []
    for i,clusters in enumerate(aDataDet.AllClusters[0:nevents]) : 
        for index,cluster in enumerate(clusters) :
            if i%skip==0 : 
            
                for track in aDataDet.AllTracks[i] : 
                    #print len(aDataDet.AllTracks[i]),track.cluster
                    #cluster = aDataDet.AllTracks[i][track.cluster]
                    tmp=np.dot(RotationMatrix(parameters[0:3]),[track.trackX[track.iden.index(dut)],track.trackX[track.iden.index(dut)],0])
                    tmp[0] = tmp[0] + parameters[3]
                    tmp[1] = tmp[1] + parameters[4]
    
    
                    #dist=sqrt(pow(cluster.absX-tmp[0],2)+pow(cluster.absY.-tmp[1],2))        
                    distx=cluster.absX -tmp[0]
                    disty=cluster.absY -tmp[1]                
    
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
    
#     totaldist_evaluator = 0.
#     n = 0
#     dist_tmp_x = []
#     dist_tmp_y = []
#     for i,tracks in enumerate(aDataDet.AllTracks[0:nevents]) : 
#         for track in tracks:
# 	    if i%skip==0 : 
# 	    
# 		    for cluster in aDataDet.AllClusters[i] : 
#                 	#print len(aDataDet.AllClusters[i]),track.cluster
#                 	#cluster = aDataDet.AllClusters[i][track.cluster]
#                 	tmp=np.dot(RotationMatrix(parameters[0:3]),[cluster.relX-npix_X*pitchX/2,cluster.relY-npix_Y*pitchY/2,0])
#                 	tmp[0] = tmp[0] + parameters[3]
#                 	tmp[1] = tmp[1] + parameters[4]
# 
# 
# 			dist=sqrt(pow( track.trackX[track.iden.index(dut)]-npix_X*pitchX/2. -tmp[0],2)+pow( track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2. -tmp[1],2))		
# 			distx=track.trackX[track.iden.index(dut)]-npix_X*pitchX/2. -tmp[0]
#                 	disty=track.trackY[track.iden.index(dut)]-npix_Y*pitchY/2. -tmp[1]                
# 
#  			if(fabs(distx)<0.1 and fabs(disty)<0.1):
#                 		dist_tmp_x.append(distx)
#                 		dist_tmp_y.append(disty)               
# 				totaldist_evaluator+=distx
# 				n+=1
# 
#     if(n!=0):
#     	result = fabs(totaldist_evaluator/n) 
#     else :
#     	result = 1000.
#     print "Evaluating for Rotation : %f %f %f [deg] Trans : %f %f  [mm] metric = %f  n = %i"%(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],result,n)
#     return result
 
 
 
 
        
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

def ApplyAlignment(dataSet,translations,rotations,dut=6,filename="Alignement.txt") :

    print "Applying Alignment with  Rotation : %0.10f %0.10f %0.10f [deg] Trans : %0.10f %0.10f  [mm]"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1])
    
    f = open(filename,'w')
    f.write("Rotation : %f %f %f [deg] Trans : %f %f  [mm] \n"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1]))
    f.close()
    for Tracks in dataSet.AllTracks : 
        for index,track in enumerate(Tracks) :
            tmp=np.dot(RotationMatrix(rotations),[track.trackX[track.iden.index(dut)],track.trackY[track.iden.index(dut)],0])
            track.trackX[track.iden.index(dut)] = tmp[0] + translations[0]
            track.trackY[track.iden.index(dut)] = tmp[1] + translations[1]
#             track.trackZ[track.iden.index(dut)] = tmp[2] + translations[2]        

#     print "Applying Alignment with  Rotation : %0.10f %0.10f %0.10f [deg] Trans : %0.10f %0.10f  [mm]"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1])
#     
#     f = open(filename,'w')
#     f.write("Rotation : %f %f %f [deg] Trans : %f %f  [mm] \n"%(rotations[0],rotations[1],rotations[2],translations[0],translations[1]))
#     f.close()
#     for Clusters in dataSet.AllClusters : 
#         for cluster in Clusters : 
#             tmp=np.dot(RotationMatrix(rotations),[cluster.relX-npix_X*pitchX/2.,cluster.relY-npix_Y*pitchY/2.,0])
#             cluster.absX = tmp[0] + translations[0]
#             cluster.absY = tmp[1] + translations[1]
#             cluster.absZ = tmp[2] + translations[2]            
            
    
