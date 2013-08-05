'''
author: Anne-Laure pequegnot 
'''

from math import fsum
from Constant import *
from ROOT import TMath
class Cluster:
    
    col = []
    row = []
    tot = []
    sizeX = 0
    sizeY = 0
    size  = 0 
    totalTOT =0
    aspectRatio = 0

# local coordinates    
    relX = 0.
    relY = 0.
    relZ = 0.
    
# telescope coordinates    
    absX =-10000.
    absY =-10000.
    absZ =-10000.
       
    resX = -10000.
    resY = -10000.
    id = 0
    
    # track number
    tracknum = -1
    
    def __init__(self):
        self.sizeX = 0
        self.sizeY = 0
        self.size  = 0 
        self.col = []
        self.row = []
        self.tot = []  
         
    def addPixel(self,col,row,tot):
        self.col.append(col)
        self.row.append(row)
        self.tot.append(tot)
  
    def Print(self):
        for i in range(len(self.col)):
            print "x:%d y%d tot:%.3f"%(self.col[i],self.row[i],self.tot[i])
        print "Cluster Total size = %d , in X = %d Y = %d , Aspect Ratio = %.3f , Total Energy (keV) = %.1f ID = %i"%(self.size,self.sizeX,self.sizeY,self.aspectRatio,self.totalTOT,self.id)
        print "Position in sensor X = %.3f Y = %.3f"%(self.absX,self.absY)
   
    def Statistics(self) :     
        self.totalTOT=fsum(self.tot)
        self.size=len(self.col)
        self.sizeX=max(self.col)-min(self.col)+1
        self.sizeY=max(self.row)-min(self.row)+1    
        self.aspectRatio=float(self.sizeY)/self.sizeX

    def GetQWeightedCentroid(self) :         
        self.relX=0.
        self.relY=0.
        for index,tot_tmp in enumerate(self.tot) :
            self.relX+=(self.col[index]*pitchX)*tot_tmp    
            self.relY+=(self.row[index]*pitchY)*tot_tmp    
        self.relX/=self.totalTOT
        self.relY/=self.totalTOT
        
        self.absX=self.relX + pitchX/2.
        self.absY=self.relY + pitchY/2.
        self.absZ=0
        
    def GetDigitalCentroid(self) :         
        self.relX=0.
        self.relY=0.
        for index,col_tmp in enumerate(self.col) :
            self.relX+=(self.col[index]*pitchX)    
            self.relY+=(self.row[index]*pitchY)    
        self.relX/=len(self.col)
        self.relY/=len(self.row)
        
        self.absX=self.relX + pitchX/2.
        self.absY=self.relY + pitchY/2.
        self.absZ=0
    
    def GetMaxTOTCentroid(self) :
        maxTOTindex_tmp=0
        maxTOT_tmp=self.tot[0]
        for index,tot_tmp in enumerate(self.tot) :
            if self.tot[index]>maxTOT_tmp:
                maxTOT_tmp=self.tot[index]
                maxTOTindex_tmp=index
        self.relX=self.col[maxTOTindex_tmp]*pitchX
        self.relY=self.row[maxTOTindex_tmp]*pitchY
        
        self.absX=self.relX + pitchX/2.
        self.absY=self.relY + pitchY/2.
        self.absZ=0


    def GetEtaCorrectedQWeightedCentroid(self,sigma=0.003) :
#     def GetEtaCorrectedQWeightedCentroid(self) :
        maxTOTindex_tmp=0
        minTOTindex_tmp = 0
        maxTOT_tmp=self.tot[0]
        
        self.relX=-1000
        self.relY=-1000
        self.absX=-1000
        self.absY=-1000
        #self.GetQWeightedCentroid()
        for index,tot_tmp in enumerate(self.tot) :
            if self.tot[index]>maxTOT_tmp:
                maxTOT_tmp=self.tot[index]
                maxTOTindex_tmp=index
            if(maxTOTindex_tmp==1)  :
                minTOTindex_tmp =0
            else :
                minTOTindex_tmp = 1    
            if(self.size==2) :      
#computing the relative charge i.e. Qrel = (charge of the pixel with the highest energy)/(total charge of the cluster)
                Qrel = (self.tot[maxTOTindex_tmp])/(self.totalTOT)
#                 self.Print()
#                 print "TMath.ErfInverse(2.*Qrel-1.) : %f"%(float(TMath.ErfInverse(2.*Qrel-1.)))
#                 print "sigma : %f"%(float(sigma))
#                 print sigma
#                 print "sigma*TMath.ErfInverse(2.*Qrel-1.) : %f"%(float(sigma)*TMath.ErfInverse(2.*Qrel-1.))
#                 print 'self.sizeX : %i'%self.sizeX
#                 print 'self.sizeY : %i'%self.sizeY
#                 print 'maxTOTindex_tmp : %i'%maxTOTindex_tmp
#                 print 'self.row[maxTOTindex_tmp]*pitchY : %f'%(float(self.row[maxTOTindex_tmp])*pitchY)
#                 print 'self.col[maxTOTindex_tmp]*pitchY : %f'%(float(self.col[maxTOTindex_tmp])*pitchY)
#distinguishing the 2 cases 'cluster size 2x1' and 'cluster size 1x2'
                if(self.sizeX==2 and self.sizeY==1) :
                #cluster size 2x1
                    if(self.col[maxTOTindex_tmp]>self.col[minTOTindex_tmp]) :
                    #neighbor on the left side
                        self.relX = self.col[maxTOTindex_tmp]*pitchX + sigma*TMath.ErfInverse(2.*Qrel-1.) 
                        self.relY = self.row[maxTOTindex_tmp]*pitchY +pitchY/2.                     
                    elif(self.col[maxTOTindex_tmp]<self.col[minTOTindex_tmp]) :
                    #neighbor on the right side
                        self.relX = (self.col[maxTOTindex_tmp]+1.)*pitchX - sigma*TMath.ErfInverse(2.*Qrel-1.)   
                        self.relY = self.row[maxTOTindex_tmp]*pitchY +pitchY/2. 
#                     print "relX : %f"%float(self.relX)
#                     print "relY : %f"%float(self.relY)                    
                elif(self.sizeX==1 and self.sizeY==2) :
                #cluster size 1x2
                    if(self.row[maxTOTindex_tmp]>self.row[minTOTindex_tmp]) :
                    #neighbor on the bottom side
                        self.relX = self.col[maxTOTindex_tmp]*pitchX + pitchX/2.
                        self.relY = self.row[maxTOTindex_tmp]*pitchY + sigma*TMath.ErfInverse(2.*Qrel-1.)                        
                    elif(self.row[maxTOTindex_tmp]<self.row[minTOTindex_tmp]) :
                    #neighbor on the top side
                        self.relX = self.col[maxTOTindex_tmp]*pitchX + pitchX/2.
                        self.relY = (self.row[maxTOTindex_tmp]+1.)*pitchY - sigma*TMath.ErfInverse(2.*Qrel-1.) 
#                     print "relX : %f"%float(self.relX)
#                     print "relY : %f"%float(self.relY)

                self.absX=self.relX 
                self.absY=self.relY 
                self.absZ=0

                

# def GetEtaCorrectedQWeightedCentroid(self,dataSet,dut=6) :
#     for i,tracks in enumerate(dataSet.AllTracks) : 
#         for track in tracks : 
#             if track.cluster!=-11 :
#                 if(dataSet.AllClusters[i][track.cluster].size==2) :
#                     maxTOTindex_tmp=0
#                     maxTOT_tmp=dataSet.AllClusters[i][track.cluster].tot[0]
# #looking for the pixel with the highest energy
#                     for index,tot_tmp in enumerate(dataSet.AllClusters[i][track.cluster].tot) :
# #                         print "tot_tmp : "
# #                         print tot_tmp
#                         if dataSet.AllClusters[i][track.cluster].tot[index]>maxTOT_tmp:
#                             maxTOT_tmp=dataSet.AllClusters[i][track.cluster].tot[index]
#                             maxTOTindex_tmp=index
#       
# #computing the relative charge i.e. Qrel = (charge of the pixel with the highest energy)/(total charge of the cluster)
#                     Qrel = (dataSet.AllClusters[i][track.cluster].tot[maxTOTindex_tmp])/(dataSet.AllClusters[i][track.cluster].totalTOT)
# #distinguishing the 2 cases 'cluster size 2x1' and 'cluster size 1x2'
#                     if(dataSet.AllClusters[i][track.cluster].sizeX==2) :
#                     #cluster size 2x1
#                         if(maxTOTindex_tmp==1) :
#                         #neighbor on the left side
#                             self.absX = maxTOTindex_tmp*pitchX + sigma*ErfInverse(2*Qrel-1) 
#                             self.absY=dataSet.AllClusters[i][track.cluster].row[maxTOTindex_tmp]*pitchY + pitchY/2.                      
#                         elif(maxTOTindex_tmp==0) :
#                         #neighbor on the right side
#                             self.absX = (maxTOTindex_tmp+1)*pitchX - sigma*ErfInverse(2*Qrel-1)   
#                             self.absY=dataSet.AllClusters[i][track.cluster].row[maxTOTindex_tmp]*pitchY + pitchY/2.                      
#                     elif(dataSet.AllClusters[i][track.cluster].sizeX==1) :
#                     #cluster size 1x2
#                         if(maxTOTindex_tmp==1) :
#                         #neighbor on the bottom side
#                             self.absX=dataSet.AllClusters[i][track.cluster].col[maxTOTindex_tmp]*pitchX + pitchX/2.
#                             self.absY = maxTOTindex_tmp*pitchY + sigma*ErfInverse(2*Qrel-1)                        
#                         elif(maxTOTindex_tmp==0) :
#                         #neighbor on the top side
#                             self.absX=dataSet.AllClusters[i][track.cluster].col[maxTOTindex_tmp]*pitchX + pitchX/2.
#                             self.absY = (maxTOTindex_tmp+1)*pitchY - sigma*ErfInverse(2*Qrel-1) 
#                 else :
#                     self.absX = 0
#                     self.absY = 0


    def GetResiduals(self,x,y) :
        self.resX = self.absX-(x)
        self.resY = self.absY-(y)
