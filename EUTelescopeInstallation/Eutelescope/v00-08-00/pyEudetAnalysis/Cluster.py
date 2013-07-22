'''
author: Anne-Laure pequegnot 
'''

from math import fsum
from Constant import *
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
            self.relX+=(self.col[index]*pitchX+pitchX/2)*tot_tmp    
            self.relY+=(self.row[index]*pitchY+pitchY/2)*tot_tmp    
        self.relX/=self.totalTOT
        self.relY/=self.totalTOT
        
        self.absX=self.relX
        self.absY=self.relY
        self.absZ=0
        
    def GetDigitalCentroid(self) :         
        self.relX=0.
        self.relY=0.
        for index,col_tmp in enumerate(self.col) :
            self.relX+=(self.col[index]*pitchX+pitchX/2)    
            self.relY+=(self.row[index]*pitchY+pitchY/2)    
        self.relX/=len(self.col)
        self.relY/=len(self.row)
        
        self.absX=self.relX
        self.absY=self.relY
        self.absZ=0
    
    def GetMaxTOTCentroid(self) :
        maxTOTindex_tmp=0
        maxTOT_tmp=self.tot[0]
        for index,tot_tmp in enumerate(self.tot) :
            if self.tot[index]>maxTOT_tmp:
                maxTOT_tmp=self.tot[index]
                maxTOTindex_tmp=index
        self.relX=self.col[maxTOTindex_tmp]*pitchX+pitchX/2
        self.relY=self.row[maxTOTindex_tmp]*pitchY+pitchY/2
        
        self.absX=self.relX
        self.absY=self.relY
        self.absZ=0
        
#     def GetEtaCorrectedQWeightedCentroid(self) :
#         # study with clusterSize = 2 first
#         if self.size==2:
#             # search for pixel with higher energy
#             maxTOTindex_tmp=0
#             maxTOT_tmp=self.tot[0]
#             for index,tot_tmp in enumerate(self.tot) :
#                 if self.tot[index]>maxTOT_tmp:
#                     maxTOT_tmp=self.tot[index]
#                     maxTOTindex_tmp=index
            
        

    def GetResiduals(self,x,y) :
        self.resX = self.absX-(x)
        self.resY = self.absY-(y)
