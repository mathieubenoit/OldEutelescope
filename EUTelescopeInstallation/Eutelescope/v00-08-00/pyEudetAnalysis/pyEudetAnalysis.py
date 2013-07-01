from ROOT import *
import ROOT
from math import fsum
from array import array 
from EudetData import *


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


aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131.root",500.0)
#aDataSet_calib = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131_calibrated.root",500.0)


histo_hot,histo_freq = aDataSet.FilterHotPixel(0.005,25000)

canhot = TCanvas()
histo_hot.Draw("colz")

canfreq = TCanvas()
canfreq.SetLogx()
canfreq.SetLogy()
histo_freq.Draw("")

for i in range(aDataSet.p_nEntries) : 
#for i in range(40000) : 


    aDataSet.ClusterEvent(i)
    aDataSet.GetTrack(i)
    aDataSet.FindMatchedCluster(i, 0.350, 0.350,6)
    if i%1000 ==0 :
        print "Event %d"%i
    #aDataSet.PrintClusters(i)    
    #aDataSet.PrintEvent(i)
    
    aDataSet.ComputeResiduals(i)


#for i in range(aDataSet_calib.p_nEntries) : 
#===============================================================================
# for i in range(10000) : 
#    aDataSet_calib.ClusterEvent(i)    
#    if i%1000 ==0 :
#        print "Event %d"%i
#    aDataSet_calib.GetTrack(i)
#    aDataSet_calib.FindMatchedCluster(i, 0.350, 0.350,6)
# 
#    aDataSet_calib.ComputeResiduals(i)
#===============================================================================
    
hx,hy = TrackClusterCorrelation(aDataSet)
#hxc,hyc = TrackClusterCorrelation(aDataSet_calib)
 
cancorx = TCanvas()
hx.Draw("colz")

cancory = TCanvas()
hy.Draw("colz")

#cancorxc = TCanvas()
#hxc.Draw("colz")
#
#cancoryc = TCanvas()
#hyc.Draw("colz")   
    
allTOT = TH1D("allTOT","Energy Spectrum, all cluster sizes",500,0,500)
TOT1 = TH1D("TOT1","Energy Spectrum, cluster size = 1",500,0,500)
TOT2 = TH1D("TOT2","Energy Spectrum, cluster size = 2",500,0,500)
TOT3 = TH1D("TOT3","Energy Spectrum, cluster size = 3",500,0,500)
TOT4 = TH1D("TOT4","Energy Spectrum, cluster size = 4",500,0,500)

resX = TH1D("resX","Unbiased residual X",500,-0.50,0.50)
resY = TH1D("resY","Unbiased residual Y",500,-0.50,0.50)

#resX_calib = TH1D("resX_calib","Unbiased residual X, calibrated",500,-0.150,0.150)
#resY_calib = TH1D("resY_calib","Unbiased residual Y, calibrated",500,-0.150,0.150)


for clusters in aDataSet.AllClusters : 
    for cluster in clusters : 
        allTOT.Fill(cluster.totalTOT) 
        if(fabs(cluster.resX)<14.25) : 
            resX.Fill(cluster.resX)
        if(fabs(cluster.resY)<14.25) : 
            resY.Fill(cluster.resY)
        if(cluster.size==1) : 
            TOT1.Fill(cluster.totalTOT) 
        if(cluster.size==2) : 
            TOT2.Fill(cluster.totalTOT) 
        if(cluster.size==3) : 
            TOT3.Fill(cluster.totalTOT)
        if(cluster.size==4) : 
            TOT4.Fill(cluster.totalTOT) 		

#for clusters in aDataSet_calib.AllClusters : 
#    for cluster in clusters : 
#        if(fabs(cluster.resX)<0.15) : 
#            resX_calib.Fill(cluster.resX+0.0058-0.0098)
#        if(fabs(cluster.resY)<0.15) : 
#            resY_calib.Fill(cluster.resY-0.0069-0.00543)

can1 = TCanvas()			
allTOT.Draw()


can2=TCanvas()
TOT1.DrawNormalized()
TOT2.DrawNormalized("same")
TOT3.DrawNormalized("same")
#TOT4.DrawNormalized("same")


can3 = TCanvas()
resX.DrawNormalized("")
#resX_calib.DrawNormalized("same")

can4 = TCanvas()
resY.DrawNormalized("")
#resY_calib.DrawNormalized("same")


aDataSet.DumpClusterTree("run131_uncalibrated_cluster.root")
#aDataSet_calib.DumpClusterTree("run131_calibrated_cluster.root")