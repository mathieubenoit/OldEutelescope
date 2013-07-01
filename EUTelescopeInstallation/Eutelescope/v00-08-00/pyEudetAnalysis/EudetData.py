from ROOT import *
import ROOT
from math import fsum
from array import array 
from Cluster import *
from Track import  *
from Constant import *

   
class EudetData:
    """A container for TBTrack Data """

    tbtrack_file = 0 
    pixelTree = ROOT.TTree()
    TrackTree = ROOT.TTree()
 
    EnergyCut = 0.
    
    AllClusters = []
    AllTracks = []
    
    p_nEntries = 0
    t_nEntries = 0   
    entry = 0
    #Track Data Holders 
    
    t_nTrackParams = 0
    t_euEv= 0
    t_posX = 0
    t_posY= 0
    t_dxdz= 0
    t_dydz= 0
    t_iden= 0
    t_trackNum= 0
    t_chi2= 0
    t_ndof = 0
    
    #Pixel Data holders
    p_nHits= 0 
    p_col= 0
    p_row= 0
    p_tot= 0
    p_lv1= 0
    p_chip= 0
    p_iden= 0
    p_euEv = 0
    
    #hotpixel firing matrix
    #hit_map = [[0]*npix_Y]*npix_X
    #frequency_map = [[0.0]*npix_Y]*npix_X
    
    hit_map =[[0 for x in xrange(npix_X)] for x in xrange(npix_Y)] 
    frequency_map = [[0 for x in xrange(npix_X)] for x in xrange(npix_Y)] 
    hotpixels = []
    
    def __init__(self,filename,ECut):
        
        self.tbtrack_file = TFile(filename)
        self.TrackTree = self.tbtrack_file.Get("eutracks")
        self.pixelTree = self.tbtrack_file.Get("zspix")
 
        self.p_nEntries = self.pixelTree.GetEntries()       
        self.t_nEntries = self.TrackTree.GetEntries()
        self.EnergyCut=ECut
        self.frequency_map = [[0.0]*npix_Y]*npix_X
        for i in range(len(self.hit_map)):
            for j in range(len(self.hit_map[0])):
                self.hit_map[i][j]=0
        
    def FilterHotPixel(self,threshold,Nevents=-1):
        
        nevent_tmp =0
        n_max = 0 
        
#        last =0 
#        now =0
        
#        counter_tmp=0
       
        histo_frequency = TH1D("freq","Firing Frequency",10000,0,1)
        histo_hotpixel = TH2D("hot","hot pixel map",256,0,255,256,0,255)
        
        if Nevents>self.p_nEntries or Nevents==-1:
            n_max = self.p_nEntries
        else : 
            n_max = Nevents
        
        
        for ii in range(n_max) :            
            self.getEvent(ii)
            if ii%1000==0 : 
                print " [Hot Pixel Finder] Parsing event %i"%ii
            for jj in range(len(self.p_row)) :
                 
#                last = self.hit_map[129][20]                                   
                
                self.hit_map[self.p_col[jj]][self.p_row[jj]]+=1.
                
#                now = self.hit_map[129][20]     
                
#                if last != now :
#                    counter_tmp+=1
#                    print "adding %i %i , counter = %i %i"%(self.p_col[jj],self.p_row[jj],counter_tmp,self.hit_map[self.p_col[jj]][self.p_row[jj]])    
                    
            nevent_tmp+=1
        
     
        
        for ii in range(npix_X):
            for jj in range(npix_Y) :
                
#                if ii==129 and jj==20 : 
#                    print "[DEDUG !!!!!!!!!] %f nevents : %i"%(self.hit_map[ii][jj],nevent_tmp)
                self.frequency_map[ii][jj]=self.hit_map[ii][jj]*(1.0/float(nevent_tmp))
#                if ii==129 and jj==20 : 
#                    print "[DEDUG !!!!!!!!!] %f nevents : %i"%(self.frequency_map[ii][jj],nevent_tmp)                
                histo_hotpixel.Fill(ii,jj,self.frequency_map[ii][jj])
                
                #if(self.frequency_map[ii][jj]>1):
                    #print ii,jj,self.frequency_map[ii][jj]
               
                histo_frequency.Fill(self.frequency_map[ii][jj])
                if(self.frequency_map[ii][jj]>threshold):
                    #print "hotpixel %i %i"%(ii,jj)
                    self.hotpixels.append([ii,jj])
        
        print "##### Hot Pixel Report #####"
        print " %i Hot pixel found at  : "%(len(self.hotpixels))
        print self.hotpixels
        print "############################"
        return histo_hotpixel,histo_frequency
        
    
    def getEvent(self,i):
        
        self.entry = self.TrackTree.GetEntry(i)
        
        self.t_nTrackParams = self.TrackTree.nTrackParams
        self.t_euEv= self.TrackTree.euEvt
        self.t_posX = self.TrackTree.xPos
        self.t_posY= self.TrackTree.yPos
        self.t_dxdz= self.TrackTree.dxdz
        self.t_dydz= self.TrackTree.dydz
        self.t_iden= self.TrackTree.iden
        self.t_trackNum= self.TrackTree.trackNum
        self.t_chi2= self.TrackTree.chi2
        self.t_ndof = self.TrackTree.ndof

        
        
        self.entry = self.pixelTree.GetEntry(i)       

        self.p_nHits= self.pixelTree.nPixHits
        self.p_col= self.pixelTree.col
        self.p_row= self.pixelTree.row
        self.p_tot= self.pixelTree.tot
        self.p_lv1= self.pixelTree.lv1
        self.p_chip= self.pixelTree.chip
        self.p_iden= self.pixelTree.iden
        self.p_euEv = self.pixelTree.euEvt
  
    def DumpClusterTree(self,filename):
        
        outfile = TFile(filename,'recreate')
        
        clusterTree = TTree('clusters','Timepix cluster tree')
       
        maxn = 500
        col = array( 'i', maxn*[ 0 ] )
        row = array( 'i', maxn*[ 0 ] )
        tot = array( 'f', maxn*[ 0. ] )
        sizeX = array( 'i', [ 0 ] )
        sizeY = array( 'i', [ 0 ] )
        size  = array( 'i', [ 0 ] ) 
        totalTOT =array( 'f', [ 0. ] )
        aspectRatio = array( 'f', [ 0. ] )
        relX = array( 'f', [ 0. ] )
        relY = array( 'f', [ 0. ] ) 
        resX = array( 'f', [ 0. ] )
        resY = array( 'f', [ 0. ] )           
        
        clusterTree.Branch( 'size', size, 'size/I' )     
        clusterTree.Branch( 'sizeX', sizeX, 'sizeX/I' )     
        clusterTree.Branch( 'sizeY', sizeY, 'sizeY/I' )     
        clusterTree.Branch( 'totalTOT', totalTOT, 'totalTOT/F' )             
        clusterTree.Branch( 'aspectRatio', aspectRatio, 'aspectRatio/F' ) 
        clusterTree.Branch( 'relX', relX, 'relX/F' ) 
        clusterTree.Branch( 'relY', relY, 'relY/F' ) 
        clusterTree.Branch( 'resX', resX, 'resX/F' ) 
        clusterTree.Branch( 'resY', resY, 'resY/F' )          
        clusterTree.Branch( 'col', col, 'col[size]/I' )
        clusterTree.Branch( 'row', row, 'row[size]/I' )     
        clusterTree.Branch( 'tot', tot, 'tot[size]/F' )  
        
        
        for clusters in self.AllClusters :
            for cluster in clusters :
                #cluster.Print()
                
                for i in range(len(cluster.col)) : 
                    col[i]=cluster.col[i]
                for i in range(len(cluster.row)) : 
                    #print "acessing %d in array length %d"%(i,len(cluster.row))
                    row[i]=cluster.row[i]
                for i in range(len(cluster.tot)) : 
                    tot[i]=cluster.tot[i]               
                sizeX[0]=cluster.sizeX
                sizeY[0]=cluster.sizeY
                size[0]=cluster.size
                totalTOT[0]=cluster.totalTOT
                aspectRatio[0]=cluster.aspectRatio
                relX[0]=cluster.relX
                relY[0]=cluster.relY
                resX[0]=cluster.resX
                resY[0]=cluster.resY
                clusterTree.Fill()
        outfile.Write()
        outfile.Close()
        
        
        
    
    def ComputeResiduals(self,i) :     
        self.getEvent(i)
        for cluster in self.AllClusters[i] : 
            cluster.GetResiduals(self.t_posX[3],self.t_posY[3])

    
    def PrintResiduals(self,i) : 
        print "###################### Event : %d ######################"%i
        self.getEvent(i)
        for cluster in self.AllClusters[i] : 
            cluster.GetResiduals(self.t_posX[3],self.t_posY[3])
            print "resX = %f resY = %f"%(cluster.resX,cluster.resY)
        print "#######################################################" 

    def PrintEvent(self,i):
        self.getEvent(i)
        print "###################### Event : %d ######################"%i
        outstr =""
        print "posX = %f posY = %f"%(self.t_posX[3],self.t_posY[3])


#    for j in self.t_posX : 
#            outstr+="%.3f "%j
#        print "posX = %s"%outstr        
#        outstr =""
#        for j in self.t_posY : 
#            outstr+="%.3f "%j
#        print "posY = %s"%outstr 
        #=======================================================================
        # outstr =""       
        # for j in self.t_dxdz : 
        #    outstr+="%.6e "%j
        # print "dxdz = %s"%outstr         
        # outstr =""        
        # for j in self.t_dydz : 
        #    outstr+="%.6e "%j
        # print "dydz = %s"%outstr 
        #=======================================================================
        print "#######################################################" 

     
    def GetTrack(self,i) : 
    
        self.getEvent(i)
        posX_tmp = []
        posY_tmp = []
        dxdz_tmp = []
        dydz_tmp = []
        iden_tmp = []
        chi2_tmp = []
        ndof_tmp = []
        trackNum_tmp = []
        nTrackParams_tmp = 0
        
        
        tracks = []
        
        #--------------------- self.t_nTrackParams = self.TrackTree.nTrackParams
        #------------------------------------- self.t_euEv= self.TrackTree.euEvt
        #------------------------------------- self.t_posX = self.TrackTree.xPos
        #-------------------------------------- self.t_posY= self.TrackTree.yPos
        #-------------------------------------- self.t_dxdz= self.TrackTree.dxdz
        #-------------------------------------- self.t_dydz= self.TrackTree.dydz
        #-------------------------------------- self.t_iden= self.TrackTree.iden
        #------------------------------ self.t_trackNum= self.TrackTree.trackNum
        #-------------------------------------- self.t_chi2= self.TrackTree.chi2
        #------------------------------------- self.t_ndof = self.TrackTree.ndof
        
        for data in self.t_posX : 
            posX_tmp.append(data)              
        for data in self.t_posY : 
            posY_tmp.append(data) 
        for data in self.t_iden : 
            iden_tmp.append(data)
        for data in self.t_dxdz : 
            dxdz_tmp.append(data)              
        for data in self.t_dydz : 
            dydz_tmp.append(data)          
        for data in self.t_chi2 : 
            chi2_tmp.append(data)
        for data in self.t_ndof : 
            ndof_tmp.append(data) 
        for data in self.t_trackNum : 
            trackNum_tmp.append(data) 
        
        nTrackParams_tmp=self.t_nTrackParams               
        for i in range(max(trackNum_tmp)+1) :
            aTrack = Track()
            ndata = nTrackParams_tmp/(max(trackNum_tmp)+1)
            #print "nTrackParam : %i len(trackNum %i)"%(nTrackParams_tmp,max(trackNum_tmp)+1)
            aTrack.trackX = posX_tmp[i*ndata:i*ndata+ndata]
            aTrack.trackY = posY_tmp[i*ndata:i*ndata+ndata]
            aTrack.iden = iden_tmp[i*ndata:i*ndata+ndata]
            aTrack.chi2 = chi2_tmp[i*ndata:i*ndata+ndata]
            aTrack.trackNum = trackNum_tmp[i*ndata:i*ndata+ndata]
            aTrack.ndof = ndof_tmp[i*ndata:i*ndata+ndata]
            aTrack.dxdz = dxdz_tmp[i*ndata:i*ndata+ndata]
            aTrack.dydz = dydz_tmp[i*ndata:i*ndata+ndata]
            tracks.append(aTrack)
            #print aTrack.iden 
        self.AllTracks.append(tracks)
 
        
 
 
    #---------------------------------------------------------------- trackX=[]
    #----------------------------------------------------------------- trackY=[]
    #------------------------------------------------------------------- chi2=0.
    #------------------------------------------------------------------- event=0
    #-------------------------------------------------------------------- ndof=0
    #------------------------------------------------------------------- iden=[]
    #--------------------------------------------------------------- trackNum=[]
    #----------------------------------------------------------------- cluster=0
        
    def FindMatchedCluster(self,i,r_max_X,r_max_Y,dut) :  

        clusters_tmp = self.AllClusters[i]
        for track in self.AllTracks[i] :
            for index,cluster in enumerate(clusters_tmp) :
                cluster.GetResiduals(track.trackX[track.iden.index(dut)],track.trackY[track.iden.index(dut)])
                if(fabs(cluster.resX)<r_max_X and (fabs(cluster.resY))<r_max_Y) :
                    track.cluster=cluster.id
                    #print "Found a match"
                    #print "resX : %f resY : %f"%(cluster.resX,cluster.resY)
                    #cluster.Print()
                    #track.Print()
                    clusters_tmp.pop(index)
                    break
                else : 
                    track.cluster=-1
            
            
        
        
              
    def ClusterEvent(self,i):
        
        self.getEvent(i) 
        
        row_tmp = []
        col_tmp = []       
        tot_tmp = []
        
        clusterid=0
        
        for index in self.p_row:          
            row_tmp.append(index)
        for index in self.p_col: 
            col_tmp.append(index)        
        for index in self.p_tot: 
            tot_tmp.append(index)
       
        hpindex=0
        while(hpindex<len(row_tmp)) : 
            if([col_tmp[hpindex],row_tmp[hpindex]] in self.hotpixels):
                #print "Removing hot pixel x: %i y:%i"%(col_tmp[hpindex],row_tmp[hpindex])
                col_tmp.pop(hpindex)
                row_tmp.pop(hpindex)
                tot_tmp.pop(hpindex)
            else :
                hpindex+=1 
    

        
        clusters = []
        while(len(row_tmp)!=0) :
            
            cluster = Cluster() 
            cluster.addPixel(col_tmp[0], row_tmp[0], tot_tmp[0])
            #print "[DEBUG] adding pixel col=%d row=%d as seed"%(col_tmp[0],row_tmp[0])
            row_tmp.pop(0)
            col_tmp.pop(0)
            tot_tmp.pop(0)
            while(self.addNeighbor(cluster, col_tmp, row_tmp, tot_tmp)>0):
                pass

        
            cluster.Statistics()
            cluster.GetQWeightedCentroid()
            cluster.id=clusterid
            clusters.append(cluster)
            clusterid+=1
            cluster=0
        
        self.AllClusters.insert(i,clusters)
        clusters=0
        



    def addNeighbor(self,cluster,col,row,tot):
        counter =0
        i=0
        j=0
        
        len_col=len(col)
        len_clu_col=len(cluster.col)      
        while(i<len_col):
            j=0
            while(j<len_clu_col):
                
        #for i in xrange(len(col)):
        #    for j in range(len(cluster.col)) :
               
            # print "i:%d j:%d len(i):%d len(j):%d"%(i,j,len(col),len(cluster.col))
                
                
                
                if(fabs(col[i]-cluster.col[j])>1) :
                    j+=1
                    continue
                
                if(fabs(row[i]-cluster.row[j])>1) :
                    j+=1
                    continue
                
                cluster.addPixel(col[i],row[i],tot[i])

            #print "[DEBUG] after adding pixel col=%d row=%d to existing cluster as neighbor to x=%d y=%d "%(col[i],row[i],cluster.col[j],cluster.row[j])
 
                col.pop(i)
                row.pop(i)
                tot.pop(i)
                counter+=1
                i+=-1  
                len_col=len(col)
                len_clu_col=len(cluster.col)                   
                break
            i+=1
        return counter
    
    def PrintClusters(self,i):
        print "########## Event %d ##########"%i
        for j,c in enumerate(self.AllClusters[i]):
            if(c.totalTOT<self.EnergyCut):
                print "##### Cluster %d #####"%j
                c.Print()
      
