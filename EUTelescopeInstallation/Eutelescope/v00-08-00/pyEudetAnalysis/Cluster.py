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
    
    relX = 0.
    relY = 0.
    relZ = 0.
    
    absX =0.
    absY =0.
    absZ =0.
       
    resX = 0
    resY = 0
    id = 0
    
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
        print "Cluster Total size = %d , in X = %d Y = %d , Aspect Ratio = %.3f , Total Energy (keV) = %.1f"%(self.size,self.sizeX,self.sizeY,self.aspectRatio,self.totalTOT)
        print "Position in sensor X = %.3f Y = %.3f"%(self.relX,self.relY)
   
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
        

    def GetResiduals(self,x,y) :
        self.resX = self.absX-x+npix_X*pitchX/2
        self.resY = self.absY-y+npix_Y*pitchY/2
