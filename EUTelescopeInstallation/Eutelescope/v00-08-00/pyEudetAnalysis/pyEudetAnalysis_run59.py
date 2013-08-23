'''
Created on Aug 23, 2013

@author: apequegn
'''
from ROOT import *
import ROOT
from ROOT import gStyle
from ROOT import TMath
from math import fsum
from array import array 
from EudetData import *
from ToolBox import *

###############################################################################################################################
#
#                        landau * gauss fit tools
#
###############################################################################################################################
# first compile the code in ROOT using ACLIC: (testLangauFit.C)
# .L File.C+

# Start pyROOT and load the library (.so) file:
from ROOT import gSystem
gSystem.Load('testLangauFit_C.so')
# gSystem.Load('/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/testLangauFit_C.so')

# Now the function should be available in the ROOT namespace
from ROOT import langaufun, langaufit, langaupro

###############################################################################################################################

PlotPath = "/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots"

# global n_sizeX2sizeY2


def h1_style(h, optstat=0) :
    h.SetStats(optstat)   
    h.SetLabelFont(42,"X")
    h.SetLabelFont(42,"Y")
    h.SetLabelOffset(0.005,"X")
    h.SetLabelOffset(0.005,"Y")
    h.SetLabelSize(0.045,"X")
    h.SetLabelSize(0.045,"Y")
    h.SetTitleOffset(1.15,"X")
    h.SetTitleOffset(1.15,"Y")
    h.SetTitleSize(0.04,"X")
    h.SetTitleSize(0.04,"Y")
    #h.SetTitle(0)
    h.SetTitleFont(42, "XYZ")

def TGraph_style (h) :
    h.GetXaxis().SetLabelOffset(0.005)
    h.GetXaxis().SetLabelFont(42)
    h.GetXaxis().SetLabelSize(0.055)
    h.GetXaxis().SetTitleOffset(1.15)
    h.GetXaxis().SetTitleSize(0.04)
    h.GetXaxis().SetTitleFont(42)
#     h.GetYaxis().SetRangeUser(0.,1.)
    h.GetYaxis().SetLabelOffset(0.005)
    h.GetYaxis().SetLabelFont(42)
    h.GetYaxis().SetLabelSize(0.045)   
    h.GetYaxis().SetTitleOffset(1.2)
    h.GetYaxis().SetTitleFont(42)
    h.GetYaxis().SetTitleSize(0.04)   



gStyle.SetOptStat("nemruoi")
gStyle.SetOptFit(1111)

method_name = "QWeighted"
# method_name = "DigitalCentroid"
# method_name = "maxTOT"
# method_name = "EtaCorrection"


#aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000062.root",500.0)

aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_August2013_results/tbtrack/tbtrackrun000059.root",500.0,2)
# aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131.root",500.0,2)

# aDataSet.PrintTBranchElement()

trackX_vs_trackY_plan3 = TH2D("trackX_vs_trackY_plan3","track_posX[3] wrt track_posY[3]",300,-20.,20.,300,-20.,20.)
# trackX_vs_trackY_plan3.GetXaxis().SetRangeUser(-0.,14.08)
trackX_vs_trackY_plan3.GetXaxis().SetTitle("Track X position within pixel [mm]")
# trackX_vs_trackY_plan3.GetYaxis().SetRangeUser(-0.,14.08)
trackX_vs_trackY_plan3.GetYaxis().SetTitle("Track Y position within pixel [mm]")

trackX_vs_trackY_plan0 = TH2D("trackX_vs_trackY_plan0","track_posX[0] wrt track_posY[0]",300,-20.,20.,300,-20.,20.)
# trackX_vs_trackY_plan0.GetXaxis().SetRangeUser(-0.,14.08)
trackX_vs_trackY_plan0.GetXaxis().SetTitle("Track X position within pixel [mm]")
# trackX_vs_trackY_plan0.GetYaxis().SetRangeUser(-0.,14.08)
trackX_vs_trackY_plan0.GetYaxis().SetTitle("Track Y position within pixel [mm]")

h1_style(trackX_vs_trackY_plan3)
h1_style(trackX_vs_trackY_plan0)

# Filter Hot Pixels
# histo_hot,histo_freq = aDataSet.FilterHotPixel(0.005,25000)
histo_hot,histo_freq = aDataSet.FilterHotPixel(0.00025,25000)

canhot = TCanvas()
histo_hot.Draw("colz")
  
canfreq = TCanvas()
canfreq.SetLogx()
canfreq.SetLogy()
histo_freq.Draw("")

n_matched = 0
for i in range(aDataSet.p_nEntries) : 
# for i in range(10000) : 

    aDataSet.ClusterEvent(i,method_name)
    aDataSet.GetTrack(i)
    aDataSet.FindMatchedCluster(i, 0.350, 0.350,6)
#     aDataSet.FindMatchedCluster(i, 2., 2.,6)
    if i%1000 ==0 :
        print "Event %d"%i
    #aDataSet.PrintClusters(i)    
    #aDataSet.PrintEvent(i)
    
    n_matched+=aDataSet.ComputeResiduals(i)
    
    aDataSet.getEvent(i)
    trackX_vs_trackY_plan3.Fill(aDataSet.t_posX[3],aDataSet.t_posY[3])
    trackX_vs_trackY_plan0.Fill(aDataSet.t_posX[0],aDataSet.t_posY[0])

print "Found %i matched track-cluster binome"%n_matched
# print "number of clusters with sixe 2 sizeX2 and sizeY2 : %f"%n_sizeX2sizeY2 
 
n_tracks_in = ComputeDetectorAcceptance(aDataSet)
print "Found %i tracks in the detector acceptance"%n_tracks_in

if n_tracks_in!=0 :
    print "detector efficiency = %f"%float((1.*n_matched)/(1.*n_tracks_in))
    
hClusterSizeCounter,hClusterSizeCounter_percent = CountPixelSize(aDataSet)
h1_style(hClusterSizeCounter)
h1_style(hClusterSizeCounter_percent)

cClusterSizeCounter = TCanvas()
cClusterSizeCounter.cd()
hClusterSizeCounter.Draw()
cClusterSizeCounter.SetLogy()

cClusterSizeCounter_percent = TCanvas()
cClusterSizeCounter_percent.cd()
# cClusterSizeCounter_percent.SetLogy()
hClusterSizeCounter_percent.Draw()


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
    
#resr,rest = PerformAlignement(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]])

#decomment to perform the alignment in 3 steps
resr,rest = Perform2StepAlignment(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]],aDataSet.p_nEntries,20)
ApplyAlignment(aDataSet,rest,resr)

# ApplyAlignment(aDataSet,[-0.0439218750, -0.0463671875 , 0.],[0.0000000000, 0.0000000000, 0])

# for i in range(10000) : 
for i in range(aDataSet.p_nEntries) :
    aDataSet.ComputeResiduals(i)
        
hx,hy = TrackClusterCorrelation(aDataSet)
#hxc,hyc = TrackClusterCorrelation(aDataSet_calib)

if (method_name == "EtaCorrection") :
#     ressigmachargeX, ressigmachargeY = FindSigmaMin(aDataSet,10000,1)
    ressigmachargeX, ressigmachargeY = FindSigmaMin(aDataSet,aDataSet.p_nEntries,20)
    print "ressigmachargeX : %f"%float(ressigmachargeX)
    print "ressigmachargeY : %f"%float(ressigmachargeY)
    
    ApplyEtaCorrection(aDataSet,ressigmachargeX,ressigmachargeY)

# for j,tracks in enumerate(aDataSet.AllTracks) : 
#     for track in tracks : 
#         if track.cluster!=-11 and len(dataSet.AllClusters[j])!=0 :     
#             aCluster = dataSet.AllClusters[j][track.cluster]
#             if(dataSet.AllClusters[j][track.cluster].size==2) : 
#                 dataSet.AllClusters[j][track.cluster].GetEtaCorrectedQWeightedCentroid(ressigmachargeX)          
#     aDataSet.FindMatchedCluster(j, 0.350, 0.350,6)
#     aDataSet.ComputeResiduals(j)
 
h1_style(hx,1)
h1_style(hy,1) 

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
TOT1.SetLineColor(1)
TOT2 = TH1D("TOT2","Energy Spectrum, cluster size = 2",500,0,500)
TOT2.SetLineColor(2)
TOT3 = TH1D("TOT3","Energy Spectrum, cluster size = 3",500,0,500)
TOT3.SetLineColor(3)
TOT4 = TH1D("TOT4","Energy Spectrum, cluster size = 4",500,0,500)
TOT4.SetLineColor(4)
 
resX = TH1D("resX","Unbiased residual X",600,-0.150,0.150)
resY = TH1D("resY","Unbiased residual Y",600,-0.150,0.150)
resX.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX.GetYaxis().SetTitle("Number of hits")
resY.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY.GetYaxis().SetTitle("Number of hits")
 
 
relX_vs_relY = TH2D("relX_vs_relY","Hit probability in local coordinates",300,0.,15.,300,0.,15.)
relX_vs_relY.GetXaxis().SetRangeUser(-0.,14.08)
relX_vs_relY.GetXaxis().SetTitle("Cluster relX position within pixel [mm]")
relX_vs_relY.GetYaxis().SetRangeUser(-0.,14.08)
relX_vs_relY.GetYaxis().SetTitle("Cluster relY position within pixel [mm]")

HitProb_1_cluster_binning1m,HitProb_2_cluster_binning1m,HitProb_3_cluster_binning1m,HitProb_4_cluster_binning1m = ClusterHitProb(aDataSet,55,6)
HitProb_1_cluster_binning2m,HitProb_2_cluster_binning2m,HitProb_3_cluster_binning2m,HitProb_4_cluster_binning2m = ClusterHitProb(aDataSet,28,6)

HitProb_1_correlationX,HitProb_2_correlationX,HitProb_3_correlationX,HitProb_4_correlationX = HitProbCorrelationX(aDataSet,55,6)
HitProb_1_correlationY,HitProb_2_correlationY,HitProb_3_correlationY,HitProb_4_correlationY = HitProbCorrelationY(aDataSet,55,6)


  

h1_style(allTOT,1) 
h1_style(TOT1,1) 
h1_style(TOT2,1) 
h1_style(TOT3,1) 
h1_style(TOT4,1) 
h1_style(resX,1) 
h1_style(resY,1)
h1_style(HitProb_1_cluster_binning1m)
h1_style(HitProb_2_cluster_binning1m)
h1_style(HitProb_3_cluster_binning1m)
h1_style(HitProb_4_cluster_binning1m)
h1_style(HitProb_1_cluster_binning2m)
h1_style(HitProb_2_cluster_binning2m)
h1_style(HitProb_3_cluster_binning2m)
h1_style(HitProb_4_cluster_binning2m)
h1_style(relX_vs_relY)

h1_style(HitProb_1_correlationX)
h1_style(HitProb_2_correlationX)
h1_style(HitProb_3_correlationX)
h1_style(HitProb_4_correlationX)
h1_style(HitProb_1_correlationY)
h1_style(HitProb_2_correlationY)
h1_style(HitProb_3_correlationY)
h1_style(HitProb_4_correlationY)

distance = 4 #microns
print "Compute charge distance..."
print distance*0.001
AllDistances,AllCharges = ComputeChargeDistance(aDataSet,distance*0.001)
graph1 = TGraph(len(AllDistances))
QrelWrtMindistance = TH2D("QrelWrtMindistance","Relative charge as a function of the minimal distance to the pixel edge",110,0,0.0275,100,0.5,1)
for i,point in enumerate(AllDistances) :
    #print point
    graph1.SetPoint(i,AllDistances[i],AllCharges[i])
    QrelWrtMindistance.Fill(AllDistances[i],AllCharges[i])
canEtaCorr = TCanvas()
graph1.Draw("ap")
graph1.GetXaxis().SetTitle("minimal distance (mm)")
graph1.GetYaxis().SetTitle("relative charge")
TGraph_style(graph1)

canEtaCorr2 = TCanvas()
QrelWrtMindistance.Draw("colz")
QrelWrtMindistance.GetXaxis().SetTitle("minimal distance (mm)")
QrelWrtMindistance.GetYaxis().SetTitle("relative charge")
h1_style(QrelWrtMindistance)
 
#resX_calib = TH1D("resX_calib","Unbiased residual X, calibrated",500,-0.150,0.150)
#resY_calib = TH1D("resY_calib","Unbiased residual Y, calibrated",500,-0.150,0.150)
 
resX_cs = []
resY_cs = []

resX_s2x2y2 = TH1D("resX_s2x2y2","Unbiased residual X, cluster size = 2, sizeX = 2 and sizeY = 2",300,-0.150,0.150)
resY_s2x2y2 = TH1D("resY_s2x2y2","Unbiased residual Y, cluster size = 2, sizeX = 2 and sizeY = 2",300,-0.150,0.150)
resX_s2x2y2.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX_s2x2y2.GetYaxis().SetTitle("Number of hits")
resY_s2x2y2.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY_s2x2y2.GetYaxis().SetTitle("Number of hits")

resX_s2x2y1 = TH1D("resX_s2x2y1","Unbiased residual X, cluster size = 2, sizeX = 2 and sizeY = 1",300,-0.150,0.150)
resY_s2x2y1 = TH1D("resY_s2x2y1","Unbiased residual Y, cluster size = 2, sizeX = 2 and sizeY = 1",300,-0.150,0.150)
resX_s2x2y1.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX_s2x2y1.GetYaxis().SetTitle("Number of hits")
resY_s2x2y1.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY_s2x2y1.GetYaxis().SetTitle("Number of hits")

resX_s2x1y2 = TH1D("resX_s2x1y2","Unbiased residual X, cluster size = 2, sizeX = 1 and sizeY = 2",300,-0.150,0.150)
resY_s2x1y2 = TH1D("resY_s2x1y2","Unbiased residual Y, cluster size = 2, sizeX = 1 and sizeY = 2",300,-0.150,0.150)
resX_s2x1y2.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX_s2x1y2.GetYaxis().SetTitle("Number of hits")
resY_s2x1y2.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY_s2x1y2.GetYaxis().SetTitle("Number of hits")

resX_s4x2y2 = TH1D("resX_s4x2y2","Unbiased residual X, cluster size = 4, sizeX = 2 and sizeY = 2",300,-0.150,0.150)
resY_s4x2y2 = TH1D("resY_s4x2y2","Unbiased residual Y, cluster size = 4, sizeX = 2 and sizeY = 2",300,-0.150,0.150)
resX_s4x2y2.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX_s4x2y2.GetYaxis().SetTitle("Number of hits")
resY_s4x2y2.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY_s4x2y2.GetYaxis().SetTitle("Number of hits")

n_cs = 3
 
for i in range(1,n_cs+2) : #n_cs+2 excluded
    tmpx = TH1D("resX_%i"%i,"Unbiased residual X, cluster size X = %i"%i,300,-0.150,0.150)
    tmpy = TH1D("resY_%i"%i,"Unbiased residual Y, cluster size Y = %i"%i,300,-0.150,0.150)
    tmpx.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
    tmpx.GetYaxis().SetTitle("Number of hits")
    tmpy.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
    tmpy.GetYaxis().SetTitle("Number of hits")
    tmpx.SetLineColor(i)
    tmpy.SetLineColor(i)
    tmpx.Sumw2()
    tmpy.Sumw2()   
    resX_cs.append(tmpx)
    resY_cs.append(tmpy)

hClusterSizeXvsSizeY = TH2D("hClusterSizeXvsSizeY","cluster sizes Y as a function of cluster sizes X",4,1,5,4,1,5)
hClusterSizeXvsSizeY.GetXaxis().SetTitle("Cluster size X")
hClusterSizeXvsSizeY.GetYaxis().SetTitle("Cluster size Y")
hClusterSizeX = TH1D("hClusterSizeX","cluster sizes X distribution",4,1,5)
hClusterSizeX.GetXaxis().SetTitle("Cluster size X")
hClusterSizeY = TH1D("hClusterSizeY","cluster sizes Y distribution",4,1,5)
hClusterSizeY.GetXaxis().SetTitle("Cluster size Y")
hClusterSize = TH1D("hClusterSize","cluster sizes distribution",4,1,5)
hClusterSize.GetXaxis().SetTitle("Cluster size")
h1_style(hClusterSizeX) 
h1_style(hClusterSizeY) 
h1_style(hClusterSize)
h1_style(hClusterSizeXvsSizeY)

if method_name == "EtaCorrection" :
#cluster size for the eta correction method
    for j,clusters in enumerate(aDataSet.AllClusters) : 
        for i,cluster in enumerate(clusters) :
            if len(aDataSet.AllClusters[j])!=0 : 
                aCluster = aDataSet.AllClusters[j][i]    
                hClusterSizeX.Fill(aCluster.sizeX)
                hClusterSizeY.Fill(aCluster.sizeY)
                hClusterSize.Fill(aCluster.size)
                hClusterSizeXvsSizeY.Fill(aCluster.sizeX,aCluster.sizeY)
                
    for j,tracks in enumerate(aDataSet.AllTracks) : 
        for track in tracks : 
            if track.cluster!=-11 and len(aDataSet.AllClusters[j])!=0 :     
                aCluster = aDataSet.AllClusters[j][track.cluster]
                allTOT.Fill(aCluster.totalTOT) 
                relX_vs_relY.Fill(aCluster.relX,aCluster.relY)
                #print aCluster.tracknum
                resX.Fill(aCluster.resX) 
                resY.Fill(aCluster.resY)
                if(aCluster.size==2 and (aCluster.sizeX==2 and aCluster.sizeY==2)) :
                    resX_s2x2y2.Fill(aCluster.resX) 
                    resY_s2x2y2.Fill(aCluster.resY)
                elif(aCluster.size==2 and (aCluster.sizeX==2 and aCluster.sizeY==1)) :
                    resX_s2x2y1.Fill(aCluster.resX) 
                    resY_s2x2y1.Fill(aCluster.resY)                   
                elif(aCluster.size==2 and (aCluster.sizeX==1 and aCluster.sizeY==2)) :
                    resX_s2x1y2.Fill(aCluster.resX) 
                    resY_s2x1y2.Fill(aCluster.resY)
                elif(aCluster.size==4 and (aCluster.sizeX==2 and aCluster.sizeY==2)) :
                    resX_s4x2y2.Fill(aCluster.resX) 
                    resY_s4x2y2.Fill(aCluster.resY)
                          
                for i in range(1,n_cs+2) :
                    if(aCluster.sizeX==i) : 
                        resX_cs[i-1].Fill(aCluster.resX) 
                    if(aCluster.sizeY==i) : 
                        resY_cs[i-1].Fill(aCluster.resY)             
                if(aCluster.size==1) : 
                    TOT1.Fill(aCluster.totalTOT) 
                if(aCluster.size==2) : 
                    TOT2.Fill(aCluster.totalTOT) 
                if(aCluster.size==3) : 
                    TOT3.Fill(aCluster.totalTOT)
                if(aCluster.size==4) : 
                    TOT4.Fill(aCluster.totalTOT)   
else :
    for j,tracks in enumerate(aDataSet.AllTracks) : 
        for track in tracks : 
            if track.cluster!=-11 and len(aDataSet.AllClusters[j])!=0 :     
                aCluster = aDataSet.AllClusters[j][track.cluster]
                allTOT.Fill(aCluster.totalTOT) 
                relX_vs_relY.Fill(aCluster.relX,aCluster.relY)
                #print aCluster.tracknum
                resX.Fill(aCluster.resX) 
                resY.Fill(aCluster.resY)
                hClusterSizeX.Fill(aCluster.sizeX)
                hClusterSizeY.Fill(aCluster.sizeY)
                hClusterSize.Fill(aCluster.size)
                hClusterSizeXvsSizeY.Fill(aCluster.sizeX,aCluster.sizeY)
                if(aCluster.size==2 and (aCluster.sizeX==2 and aCluster.sizeY==2)) :
                    resX_s2x2y2.Fill(aCluster.resX) 
                    resY_s2x2y2.Fill(aCluster.resY)
                elif(aCluster.size==2 and (aCluster.sizeX==2 and aCluster.sizeY==1)) :
                    resX_s2x2y1.Fill(aCluster.resX) 
                    resY_s2x2y1.Fill(aCluster.resY)                   
                elif(aCluster.size==2 and (aCluster.sizeX==1 and aCluster.sizeY==2)) :
                    resX_s2x1y2.Fill(aCluster.resX) 
                    resY_s2x1y2.Fill(aCluster.resY)
                elif(aCluster.size==4 and (aCluster.sizeX==2 and aCluster.sizeY==2)) :
                    resX_s4x2y2.Fill(aCluster.resX) 
                    resY_s4x2y2.Fill(aCluster.resY)
                    
                for i in range(1,n_cs+2) :
                    if(aCluster.sizeX==i) : 
                        resX_cs[i-1].Fill(aCluster.resX) 
                    if(aCluster.sizeY==i) : 
                        resY_cs[i-1].Fill(aCluster.resY)             
                if(aCluster.size==1) : 
                    TOT1.Fill(aCluster.totalTOT) 
                if(aCluster.size==2) : 
                    TOT2.Fill(aCluster.totalTOT) 
                if(aCluster.size==3) : 
                    TOT3.Fill(aCluster.totalTOT)
                if(aCluster.size==4) : 
                    TOT4.Fill(aCluster.totalTOT)     
     
# for clusters in aDataSet.AllClusters : 
#     for cluster in clusters : 
#         allTOT.Fill(cluster.totalTOT) 
#         relX_vs_relY.Fill(cluster.relX,cluster.relY)
#         #print cluster.tracknum
#         if(fabs(cluster.resX)<0.150 and fabs(cluster.resY)<0.150) : 
#             resX.Fill(cluster.resX) 
#             resY.Fill(cluster.resY) 
# 	for i in range(1,n_cs+1) :
#         	if(fabs(cluster.resX)<0.150 and cluster.resY<0.150 and cluster.sizeX==i) : 
#         	    resX_cs[i-1].Fill(cluster.resX) 
#         	if(fabs(cluster.resX)<0.150 and cluster.resY<0.150 and cluster.sizeY==i) : 
# 		    resY_cs[i-1].Fill(cluster.resY)	     	
#         if(cluster.size==1) : 
#             TOT1.Fill(cluster.totalTOT) 
#         if(cluster.size==2) : 
#             TOT2.Fill(cluster.totalTOT) 
#         if(cluster.size==3) : 
#             TOT3.Fill(cluster.totalTOT)
#         if(cluster.size==4) : 
#             TOT4.Fill(cluster.totalTOT) 		
 
#for clusters in aDataSet_calib.AllClusters : 
#    for cluster in clusters : 
#        if(fabs(cluster.resX)<0.15) : 
#            resX_calib.Fill(cluster.resX+0.0058-0.0098)
#        if(fabs(cluster.resY)<0.15) : 
#            resY_calib.Fill(cluster.resY-0.0069-0.00543)

canvas_resX_s2x2y2 = TCanvas()
resX_s2x2y2.Draw()
resX_s2x2y2.Fit("gaus","R","",-0.03,0.03)
canvas_resY_s2x2y2 = TCanvas()
resY_s2x2y2.Draw()
resY_s2x2y2.Fit("gaus","R","",-0.03,0.03)

canvas_resX_s2x2y1 = TCanvas()
resX_s2x2y1.Draw()
resX_s2x2y1.Fit("gaus","R","",-0.03,0.03)
canvas_resY_s2x2y1 = TCanvas()
resY_s2x2y1.Draw()
resY_s2x2y1.Fit("gaus","R","",-0.03,0.03)

canvas_resX_s2x1y2 = TCanvas()
resX_s2x1y2.Draw()
resX_s2x1y2.Fit("gaus","R","",-0.03,0.03)
canvas_resY_s2x1y2 = TCanvas()
resY_s2x1y2.Draw()
resY_s2x1y2.Fit("gaus","R","",-0.03,0.03)

canvas_resX_s4x2y2 = TCanvas()
resX_s4x2y2.Draw()
resX_s4x2y2.Fit("gaus","R","",-0.03,0.03)
canvas_resY_s4x2y2 = TCanvas()
resY_s4x2y2.Draw()
resY_s4x2y2.Fit("gaus","R","",-0.03,0.03)
 
can1 = TCanvas()			
allTOT.Draw()

###############################################################################################################################
#
#                        landau * gauss fit, allTOT
#
################################################################################################################################ 
 
# #langaufit(allTOT,fr_allTOT,sv_allTOT,pllo_allTOT,plhi_allTOT,fp_allTOT,fpe_allTOT,chisqr_allTOT,ndf_allTOT)
# #
# # allTOT : his               histogram to fit
# # fr_allTOT : fitrange       lo and hi boundaries of fit range
# # sv_allTOT : startvalues    reasonable start values for the fit
# # pllo_allTOT : parlimitslo  lower parameter limits
# # plhi_allTOT : parlimitshi  upper parameter limits
# # fp_allTOT : fitparams      returns the final fit parameters
# # fpe_allTOT : fiterrors     returns the final fit errors
#  
#  
# fr_allTOT = array('d',[0.2*TOT2.GetMean(),3.0*TOT2.GetMean()])
# sv_allTOT = array('d',[1.8,20.0,50000.0,3.0]) 
# pllo_allTOT = array('d',[0.5,5.0,1.0,0.4])
# plhi_allTOT = array('d',[5.0,50.0,1000000.0,5.0]) 
# fp_allTOT = array('d',[0.]) 
# fpe_allTOT = array('d',[0.]) 
#  
# chisqr_allTOT = array('d',[0.])
# ndf_allTOT = array('i',[0])
# allTOTPeak = ROOT.Double(0.) 
# allTOTFWHM = ROOT.Double(0.) 
#  
#  
# fitallTOT = langaufit(allTOT,fr_allTOT,sv_allTOT,pllo_allTOT,plhi_allTOT,fp_allTOT,fpe_allTOT,chisqr_allTOT,ndf_allTOT)
# langaupro(fp_allTOT,allTOTPeak,allTOTFWHM)
#  
# print"Fitting done\nPlotting results...\n"
#  
#  
# canvasTest_allTOT = TCanvas()
# canvasTest_allTOT.cd()
# allTOT.Draw()
# fitallTOT.Draw("lsame")
# canvasTest_allTOT.Update()

###############################################################################################################################


###############################################################################################################################
#
#                        landau * gauss fit, TOT2 
#
################################################################################################################################ 

# #langaufit(TOT2,fr_TOT2,sv_TOT2,pllo_TOT2,plhi_TOT2,fp_TOT2,fpe_TOT2,chisqr_TOT2,ndf_TOT2)
# #
# # TOT2 : his               histogram to fit
# # fr_TOT2 : fitrange       lo and hi boundaries of fit range
# # sv_TOT2 : startvalues    reasonable start values for the fit
# # pllo_TOT2 : parlimitslo  lower parameter limits
# # plhi_TOT2 : parlimitshi  upper parameter limits
# # fp_TOT2 : fitparams      returns the final fit parameters
# # fpe_TOT2 : fiterrors     returns the final fit errors
#  
# fr_TOT2 = array('d',[0.2*TOT2.GetMean(),3.0*TOT2.GetMean()])
# sv_TOT2 = array('d',[1.8,20.0,50000.0,3.0]) 
# pllo_TOT2 = array('d',[0.5,5.0,1.0,0.4])
# plhi_TOT2 = array('d',[5.0,50.0,1000000.0,5.0]) 
# fp_TOT2 = array('d',[0.]) 
# fpe_TOT2 = array('d',[0.]) 
#  
# chisqr_TOT2 = array('d',[0.])
# ndf_TOT2 = array('i',[0])
# TOT2Peak = ROOT.Double(0.) 
# TOT2FWHM = ROOT.Double(0.) 
#  
#  
# fitTOT2 = langaufit(TOT2,fr_TOT2,sv_TOT2,pllo_TOT2,plhi_TOT2,fp_TOT2,fpe_TOT2,chisqr_TOT2,ndf_TOT2)
# langaupro(fp_TOT2,TOT2Peak,TOT2FWHM)
#  
# print"Fitting done\nPlotting results...\n"
#  
#  
# canvasTest_TOT2 = TCanvas()
# canvasTest_TOT2.cd()
# TOT2.Draw()
# fitTOT2.Draw("lsame")
# canvasTest_TOT2.Update()


###############################################################################################################################

###############################################################################################################################
#
#                        landau * gauss fit, TOT4 
#
###############################################################################################################################

# #langaufit(TOT4,fr_TOT4,sv_TOT4,pllo_TOT4,plhi_TOT4,fp_TOT4,fpe_TOT4,chisqr_TOT4,ndf_TOT4)
# #
# # TOT4 : his               histogram to fit
# # fr_TOT4 : fitrange       lo and hi boundaries of fit range
# # sv_TOT4 : startvalues    reasonable start values for the fit
# # pllo_TOT4 : parlimitslo  lower parameter limits
# # plhi_TOT4 : parlimitshi  upper parameter limits
# # fp_TOT4 : fitparams      returns the final fit parameters
# # fpe_TOT4 : fiterrors     returns the final fit errors
#   
# fr_TOT4 = array('d',[0.2*TOT4.GetMean(),3.0*TOT4.GetMean()])
# sv_TOT4 = array('d',[1.8,20.0,50000.0,3.0]) 
# pllo_TOT4 = array('d',[0.5,5.0,1.0,0.4])
# plhi_TOT4 = array('d',[5.0,50.0,1000000.0,5.0]) 
# fp_TOT4 = array('d',[0.]) 
# fpe_TOT4 = array('d',[0.]) 
#   
# chisqr_TOT4 = array('d',[0.])
# ndf_TOT4 = array('i',[0])
# TOT4Peak = ROOT.Double(0.) 
# TOT4FWHM = ROOT.Double(0.) 
#   
#   
# fitTOT4 = langaufit(TOT4,fr_TOT4,sv_TOT4,pllo_TOT4,plhi_TOT4,fp_TOT4,fpe_TOT4,chisqr_TOT4,ndf_TOT4)
# langaupro(fp_TOT4,TOT4Peak,TOT4FWHM)
#   
# print"Fitting done\nPlotting results...\n"
#   
#   
# canvasTest_TOT4 = TCanvas()
# canvasTest_TOT4.cd()
# TOT4.Draw()
# fitTOT4.Draw("lsame")
# canvasTest_TOT4.Update()

###############################################################################################################################

if ((TOT1.Integral()!=0 and TOT2.Integral()!=0) and (TOT3.Integral()!=0 and TOT4.Integral()!=0)) : 
    TOT1.Scale(1./(TOT1.Integral())) 
    TOT2.Scale(1./(TOT2.Integral()))
    TOT3.Scale(1./(TOT3.Integral()))
    TOT4.Scale(1./(TOT4.Integral()))

can2=TCanvas()
can2.cd()
TOT1.Draw()
TOT2.Draw("sames")
TOT3.Draw("sames")
TOT4.Draw("sames")
gPad.Update()
st_TOT1 = TOT1.GetListOfFunctions().FindObject("stats")
st_TOT1.SetX1NDC(0.690)
st_TOT1.SetY1NDC(0.623)
st_TOT1.SetX2NDC(0.838) 
st_TOT1.SetY2NDC(0.879) 
st_TOT1.SetOptStat(111111)
# gPad.Update()
st_TOT2 = TOT2.GetListOfFunctions().FindObject("stats")
st_TOT2.SetX1NDC(0.846)
st_TOT2.SetY1NDC(0.623)
st_TOT2.SetX2NDC(0.984) 
st_TOT2.SetY2NDC(0.879)
st_TOT2.SetOptStat(111111)
# gPad.Update()
st_TOT3 = TOT3.GetListOfFunctions().FindObject("stats")
st_TOT3.SetX1NDC(0.690)
st_TOT3.SetY1NDC(0.360)
st_TOT3.SetX2NDC(0.838) 
st_TOT3.SetY2NDC(0.616)
st_TOT3.SetOptStat(111111)
# gPad.Update()
st_TOT4 = TOT4.GetListOfFunctions().FindObject("stats")
st_TOT4.SetX1NDC(0.846)
st_TOT4.SetY1NDC(0.360)
st_TOT4.SetX2NDC(0.984) 
st_TOT4.SetY2NDC(0.616)
st_TOT4.SetOptStat(111111)
leg2 = TLegend(0.48,0.69,0.68,0.88)
leg2.SetBorderSize(0)
leg2.AddEntry(TOT1,"cluster size 1","l")
leg2.AddEntry(TOT2,"cluster size 2","l")
leg2.AddEntry(TOT3,"cluster size 3","l")
leg2.AddEntry(TOT4,"cluster size 4","l")
leg2.SetFillColor(0)
leg2.SetFillStyle(0)
leg2.Draw("SAME")
gPad.Update()

 
can3 = TCanvas()
resX.Draw("")
resX.Fit("gaus","R","",-0.03,0.03)
 
#resX_calib.DrawNormalized("same")
 
can4 = TCanvas()
resY.Draw("")
resY.Fit("gaus","R","",-0.03,0.03)
#resY_calib.DrawNormalized("same")
 
can5 = TCanvas() 
for i in range(1,n_cs+2) : 
    h1_style(resX_cs[i-1],1)
    if(resX_cs[i-1].Integral()!=0) :
        resX_cs[i-1].Scale(1./(resX_cs[i-1].Integral()))
    if i==1 :         
        resX_cs[i-1].Draw("")
    else : 
        resX_cs[i-1].Draw("sames")
gPad.Update()
st_resX_cs0 = resX_cs[0].FindObject("stats")
st_resX_cs0.SetX1NDC(0.690)
st_resX_cs0.SetY1NDC(0.623)
st_resX_cs0.SetX2NDC(0.838) 
st_resX_cs0.SetY2NDC(0.879) 
st_resX_cs0.SetOptStat(111111)
st_resX_cs1 = resX_cs[1].FindObject("stats")
st_resX_cs1.SetX1NDC(0.846)
st_resX_cs1.SetY1NDC(0.623)
st_resX_cs1.SetX2NDC(0.984) 
st_resX_cs1.SetY2NDC(0.879)
st_resX_cs1.SetOptStat(111111)
st_resX_cs2 = resX_cs[2].FindObject("stats")
st_resX_cs2.SetX1NDC(0.690)
st_resX_cs2.SetY1NDC(0.360)
st_resX_cs2.SetX2NDC(0.838) 
st_resX_cs2.SetY2NDC(0.616)
st_resX_cs2.SetOptStat(111111)
st_resX_cs3 = resX_cs[3].FindObject("stats")
st_resX_cs3.SetX1NDC(0.846)
st_resX_cs3.SetY1NDC(0.360)
st_resX_cs3.SetX2NDC(0.984) 
st_resX_cs3.SetY2NDC(0.616)
st_resX_cs3.SetOptStat(111111)
leg5 = TLegend(0.13,0.69,0.33,0.88)
leg5.SetBorderSize(0)
leg5.AddEntry(resX_cs[0],"cluster size 1","l")
leg5.AddEntry(resX_cs[1],"cluster size 2","l")
leg5.AddEntry(resX_cs[2],"cluster size 3","l")
leg5.AddEntry(resX_cs[3],"cluster size 4","l")
leg5.SetFillColor(0)
leg5.SetFillStyle(0)
leg5.Draw("SAME")
gPad.Update()
 
can6 = TCanvas()
 
for i in range(1,n_cs+2) :
    h1_style(resY_cs[i-1],1)
    if(resY_cs[i-1].Integral()!=0) :
        resY_cs[i-1].Scale(1./(resY_cs[i-1].Integral())) 
    if i==1 :        
        resY_cs[i-1].Draw("")
    else : 
        resY_cs[i-1].Draw("sames")
gPad.Update()
st_resY_cs0 = resY_cs[0].FindObject("stats")
st_resY_cs0.SetX1NDC(0.690)
st_resY_cs0.SetY1NDC(0.623)
st_resY_cs0.SetX2NDC(0.838) 
st_resY_cs0.SetY2NDC(0.879) 
st_resY_cs0.SetOptStat(111111)
st_resY_cs1 = resY_cs[1].FindObject("stats")
st_resY_cs1.SetX1NDC(0.846)
st_resY_cs1.SetY1NDC(0.623)
st_resY_cs1.SetX2NDC(0.984) 
st_resY_cs1.SetY2NDC(0.879)
st_resY_cs1.SetOptStat(111111)
st_resY_cs2 = resY_cs[2].FindObject("stats")
st_resY_cs2.SetX1NDC(0.690)
st_resY_cs2.SetY1NDC(0.360)
st_resY_cs2.SetX2NDC(0.838) 
st_resY_cs2.SetY2NDC(0.616)
st_resY_cs2.SetOptStat(111111)
st_resY_cs3 = resY_cs[3].FindObject("stats")
st_resY_cs3.SetX1NDC(0.846)
st_resY_cs3.SetY1NDC(0.360)
st_resY_cs3.SetX2NDC(0.984) 
st_resY_cs3.SetY2NDC(0.616)
st_resY_cs3.SetOptStat(111111)
leg6 = TLegend(0.13,0.69,0.33,0.88)
leg6.SetBorderSize(0)
leg6.AddEntry(resY_cs[0],"cluster size 1","l")
leg6.AddEntry(resY_cs[1],"cluster size 2","l")
leg6.AddEntry(resY_cs[2],"cluster size 3","l")
leg6.AddEntry(resY_cs[3],"cluster size 4","l")
leg6.SetFillColor(0)
leg6.SetFillStyle(0)
leg6.Draw("SAME")
gPad.Update()


can7 = TCanvas()
can7.cd()
HitProb_1_cluster_binning1m.Draw("colz")
 
can8 = TCanvas()
can8.cd()
HitProb_2_cluster_binning1m.Draw("colz")
 
can9 = TCanvas()
can9.cd()
HitProb_3_cluster_binning1m.Draw("colz")
 
can10 = TCanvas()
can10.cd()
HitProb_4_cluster_binning1m.Draw("colz")

can7bis = TCanvas()
can7bis.cd()
HitProb_1_cluster_binning2m.Draw("colz")
 
can8bis = TCanvas()
can8bis.cd()
HitProb_2_cluster_binning2m.Draw("colz")
 
can9bis = TCanvas()
can9bis.cd()
HitProb_3_cluster_binning2m.Draw("colz")
 
can10bis = TCanvas()
can10bis.cd()
HitProb_4_cluster_binning2m.Draw("colz")
 
can11 = TCanvas()
can11.cd()
relX_vs_relY.Draw("colz")
 
#inverting rotation and translation to have local coordinates
  
# ApplyAlignment(aDataSet,[0.0154687500 , 0.0205156250 , 0.],[0.0000000000, 0.0000000000, -0.0719150199])  
     
   
HitProb_1_track_binning1m,HitProb_2_track_binning1m,HitProb_3_track_binning1m,HitProb_4_track_binning1m = TrackHitProb(aDataSet,55,6)
HitProb_1_track_binning2m,HitProb_2_track_binning2m,HitProb_3_track_binning2m,HitProb_4_track_binning2m = TrackHitProb(aDataSet,28,6)

h1_style(HitProb_1_track_binning1m)
h1_style(HitProb_2_track_binning1m)
h1_style(HitProb_3_track_binning1m)
h1_style(HitProb_4_track_binning1m)
h1_style(HitProb_1_track_binning2m)
h1_style(HitProb_2_track_binning2m)
h1_style(HitProb_3_track_binning2m)
h1_style(HitProb_4_track_binning2m)
   
             
can12 = TCanvas()
can12.cd()
HitProb_1_track_binning1m.Draw("colz")
  
can13 = TCanvas()
can13.cd()
HitProb_2_track_binning1m.Draw("colz")

can14 = TCanvas()
can14.cd()
HitProb_3_track_binning1m.Draw("colz")
  
can15 = TCanvas()
can15.cd()
HitProb_4_track_binning1m.Draw("colz")

can12bis = TCanvas()
can12bis.cd()
HitProb_1_track_binning2m.Draw("colz")
  
can13bis = TCanvas()
can13bis.cd()
HitProb_2_track_binning2m.Draw("colz")
  
can14bis = TCanvas()
can14bis.cd()
HitProb_3_track_binning2m.Draw("colz")
  
can15bis = TCanvas()
can15bis.cd()
HitProb_4_track_binning2m.Draw("colz")
 
can16 = TCanvas()
can16.cd()
trackX_vs_trackY_plan3.Draw("colz")
 
can17 = TCanvas()
can17.cd()
trackX_vs_trackY_plan0.Draw("colz")

can18 = TCanvas()
can18.cd()
hClusterSizeX.Draw()

can19 = TCanvas()
can19.cd()
hClusterSizeY.Draw()

can20 = TCanvas()
can20.cd()
hClusterSize.Draw()

can21 = TCanvas()
can21.cd()
hClusterSizeXvsSizeY.Draw("colz")

can22 = TCanvas()
can22.cd()
HitProb_1_correlationX.Draw("colz")
  
can23 = TCanvas()
can23.cd()
HitProb_2_correlationX.Draw("colz")

can24 = TCanvas()
can24.cd()
HitProb_3_correlationX.Draw("colz")
  
can25 = TCanvas()
can25.cd()
HitProb_4_correlationX.Draw("colz")

can26 = TCanvas()
can26.cd()
HitProb_1_correlationY.Draw("colz")
  
can27 = TCanvas()
can27.cd()
HitProb_2_correlationY.Draw("colz")

can28 = TCanvas()
can28.cd()
HitProb_3_correlationY.Draw("colz")
  
can29 = TCanvas()
can29.cd()
HitProb_4_correlationY.Draw("colz")


if method_name == "QWeighted" :
#     out = TFile("%s/QWeighted/output_rootfile_QWeighted_firingFreq001_run000131.root"%PlotPath, "recreate")
    out = TFile("%s/run59/QWeighted/output_rootfile_QWeighted_firingFreq001_run000131_distance%i.root"%(PlotPath,distance), "recreate")
    canhot.SaveAs("%s/run59/QWeighted/histo_hot_QWeighted.pdf"%PlotPath)
    canfreq.SaveAs("%s/run59/QWeighted/histo_freq_QWeighted.pdf"%PlotPath)
    cancorx.SaveAs("%s/run59/QWeighted/corx_QWeighted.pdf"%PlotPath)
    cancory.SaveAs("%s/run59/QWeighted/cory_QWeighted.pdf"%PlotPath)
    can1.SaveAs("%s/run59/QWeighted/allTOT_QWeighted.pdf"%PlotPath)
    can2.SaveAs("%s/run59/QWeighted/TOTnormalized_QWeighted.pdf"%PlotPath)
    can3.SaveAs("%s/run59/QWeighted/resX_QWeighted.pdf"%PlotPath)
    can4.SaveAs("%s/run59/QWeighted/resY_QWeighted.pdf"%PlotPath)
    can5.SaveAs("%s/run59/QWeighted/resX_cs_QWeighted.pdf"%PlotPath)
    can6.SaveAs("%s/run59/QWeighted/resY_cs_QWeighted.pdf"%PlotPath)
    can7.SaveAs("%s/run59/QWeighted/HitProb_1_cluster_binning1m_QWeighted.pdf"%PlotPath)
    can8.SaveAs("%s/run59/QWeighted/HitProb_2_cluster_binning1m_QWeighted.pdf"%PlotPath)
    can9.SaveAs("%s/run59/QWeighted/HitProb_3_cluster_binning1m_QWeighted.pdf"%PlotPath)
    can10.SaveAs("%s/run59/QWeighted/HitProb_4_cluster_binning1m_QWeighted.pdf"%PlotPath)
    can7bis.SaveAs("%s/run59/QWeighted/HitProb_1_cluster_binning2m_QWeighted.pdf"%PlotPath)
    can8bis.SaveAs("%s/run59/QWeighted/HitProb_2_cluster_binning2m_QWeighted.pdf"%PlotPath)
    can9bis.SaveAs("%s/run59/QWeighted/HitProb_3_cluster_binning2m_QWeighted.pdf"%PlotPath)
    can10bis.SaveAs("%s/run59/QWeighted/HitProb_4_cluster_binning2m_QWeighted.pdf"%PlotPath)
    can11.SaveAs("%s/run59/QWeighted/relX_vs_relY_QWeighted.pdf"%PlotPath)
    can12.SaveAs("%s/run59/QWeighted/HitProb_1_track_binning1m_QWeighted.pdf"%PlotPath)
    can13.SaveAs("%s/run59/QWeighted/HitProb_2_track_binning1m_QWeighted.pdf"%PlotPath)
    can14.SaveAs("%s/run59/QWeighted/HitProb_3_track_binning1m_QWeighted.pdf"%PlotPath)
    can15.SaveAs("%s/run59/QWeighted/HitProb_4_track_binning1m_QWeighted.pdf"%PlotPath)
    can12bis.SaveAs("%s/run59/QWeighted/HitProb_1_track_binning2m_QWeighted.pdf"%PlotPath)
    can13bis.SaveAs("%s/run59/QWeighted/HitProb_2_track_binning2m_QWeighted.pdf"%PlotPath)
    can14bis.SaveAs("%s/run59/QWeighted/HitProb_3_track_binning2m_QWeighted.pdf"%PlotPath)
    can15bis.SaveAs("%s/run59/QWeighted/HitProb_4_track_binning2m_QWeighted.pdf"%PlotPath)    
    can16.SaveAs("%s/run59/QWeighted/trackX_vs_trackY_plan3_QWeighted.pdf"%PlotPath)
    can17.SaveAs("%s/run59/QWeighted/trackX_vs_trackY_plan0_QWeighted.pdf"%PlotPath)
    can18.SaveAs("%s/run59/QWeighted/ClusterSizeX_QWeighted.pdf"%PlotPath)
    can19.SaveAs("%s/run59/QWeighted/ClusterSizeY_QWeighted.pdf"%PlotPath)
    can20.SaveAs("%s/run59/QWeighted/ClusterSize_QWeighted.pdf"%PlotPath)
    can21.SaveAs("%s/run59/QWeighted/ClusterSizeXvsSizeY_QWeighted.pdf"%PlotPath)
    can22.SaveAs("%s/run59/QWeighted/HitProb_1_correlationX_QWeighted.pdf"%PlotPath)
    can23.SaveAs("%s/run59/QWeighted/HitProb_2_correlationX_QWeighted.pdf"%PlotPath)
    can24.SaveAs("%s/run59/QWeighted/HitProb_3_correlationX_QWeighted.pdf"%PlotPath)
    can25.SaveAs("%s/run59/QWeighted/HitProb_4_correlationX_QWeighted.pdf"%PlotPath)
    can26.SaveAs("%s/run59/QWeighted/HitProb_1_correlationY_QWeighted.pdf"%PlotPath)
    can27.SaveAs("%s/run59/QWeighted/HitProb_2_correlationY_QWeighted.pdf"%PlotPath)
    can28.SaveAs("%s/run59/QWeighted/HitProb_3_correlationY_QWeighted.pdf"%PlotPath)
    can29.SaveAs("%s/run59/QWeighted/HitProb_4_correlationY_QWeighted.pdf"%PlotPath)
    canEtaCorr.SaveAs("%s/run59/QWeighted/Eta_QWeighted.pdf"%PlotPath)
    canEtaCorr2.SaveAs("%s/run59/QWeighted/Eta_hist_QWeighted.pdf"%PlotPath)
    cClusterSizeCounter.SaveAs("%s/run59/QWeighted/ClusterSizeCounter.pdf"%PlotPath)
    cClusterSizeCounter_percent.SaveAs("%s/run59/QWeighted/ClusterSizeCounter_percent.pdf"%PlotPath)
    canvas_resX_s2x2y2.SaveAs("%s/run59/QWeighted/resX_s2x2y2.pdf"%PlotPath)
    canvas_resY_s2x2y2.SaveAs("%s/run59/QWeighted/resY_s2x2y2.pdf"%PlotPath)
    canvas_resX_s2x2y1.SaveAs("%s/run59/QWeighted/resX_s2x2y1.pdf"%PlotPath)
    canvas_resY_s2x2y1.SaveAs("%s/run59/QWeighted/resY_s2x2y1.pdf"%PlotPath)
    canvas_resX_s2x1y2.SaveAs("%s/run59/QWeighted/resX_s2x1y2.pdf"%PlotPath)
    canvas_resY_s2x1y2.SaveAs("%s/run59/QWeighted/resY_s2x1y2.pdf"%PlotPath)
    canvas_resX_s4x2y2.SaveAs("%s/run59/QWeighted/resX_s4x2y2.pdf"%PlotPath)
    canvas_resY_s4x2y2.SaveAs("%s/run59/QWeighted/resY_s4x2y2.pdf"%PlotPath) 
    canvasTest_allTOT.SaveAs("%s/run59/QWeighted/allTOT_landaugausFit.pdf"%PlotPath)
    canvasTest_TOT2.SaveAs("%s/run59/QWeighted/TOT2_landaugausFit.pdf"%PlotPath)
    canvasTest_TOT4.SaveAs("%s/run59/QWeighted/TOT4_landaugausFit.pdf"%PlotPath)
 
elif method_name == "DigitalCentroid" :
    #out = TFile("%s/DigitalCentroid/output_rootfile_DigitalCentroid_firingFreq001_run000131.root"%PlotPath, "recreate")
    out = TFile("%s/run59/DigitalCentroid/output_rootfile_DigitalCentroid_firingFreq001_run000131_distance%i.root"%(PlotPath,distance), "recreate")
    canhot.SaveAs("%s/run59/DigitalCentroid/histo_hot_DigitalCentroid.pdf"%PlotPath)
    canfreq.SaveAs("%s/run59/DigitalCentroid/histo_freq_DigitalCentroid.pdf"%PlotPath)
    cancorx.SaveAs("%s/run59/DigitalCentroid/corx_DigitalCentroid.pdf"%PlotPath)
    cancory.SaveAs("%s/run59/DigitalCentroid/cory_DigitalCentroid.pdf"%PlotPath)
    can1.SaveAs("%s/run59/DigitalCentroid/allTOT_DigitalCentroid.pdf"%PlotPath)
    can2.SaveAs("%s/run59/DigitalCentroid/TOTnormalized_DigitalCentroid.pdf"%PlotPath)
    can3.SaveAs("%s/run59/DigitalCentroid/resX_DigitalCentroid.pdf"%PlotPath)
    can4.SaveAs("%s/run59/DigitalCentroid/resY_DigitalCentroid.pdf"%PlotPath)
    can5.SaveAs("%s/run59/DigitalCentroid/resX_cs_DigitalCentroid.pdf"%PlotPath)
    can6.SaveAs("%s/run59/DigitalCentroid/resY_cs_DigitalCentroid.pdf"%PlotPath)
    can7.SaveAs("%/run59s/DigitalCentroid/HitProb_1_cluster_binning1m_DigitalCentroid.pdf"%PlotPath)
    can8.SaveAs("%s/run59/DigitalCentroid/HitProb_2_cluster_binning1m_DigitalCentroid.pdf"%PlotPath)
    can9.SaveAs("%s/run59/DigitalCentroid/HitProb_3_cluster_binning1m_DigitalCentroid.pdf"%PlotPath)
    can10.SaveAs("%s/run59/DigitalCentroid/HitProb_4_cluster_binning1m_DigitalCentroid.pdf"%PlotPath)
    can7bis.SaveAs("%s/run59/DigitalCentroid/HitProb_1_cluster_binning2m_DigitalCentroid.pdf"%PlotPath)
    can8bis.SaveAs("%s/run59/DigitalCentroid/HitProb_2_cluster_binning2m_DigitalCentroid.pdf"%PlotPath)
    can9bis.SaveAs("%s/run59/DigitalCentroid/HitProb_3_cluster_binning2m_DigitalCentroid.pdf"%PlotPath)
    can10bis.SaveAs("%s/run59/DigitalCentroid/HitProb_4_cluster_binning2m_DigitalCentroid.pdf"%PlotPath)
    can11.SaveAs("%s/run59/DigitalCentroid/relX_vs_relY_DigitalCentroid.pdf"%PlotPath)
    can12.SaveAs("%s/run59/DigitalCentroid/HitProb_1_track_binning1m_DigitalCentroid.pdf"%PlotPath)
    can13.SaveAs("%s/run59/DigitalCentroid/HitProb_2_track_binning1m_DigitalCentroid.pdf"%PlotPath)
    can14.SaveAs("%s/run59/DigitalCentroid/HitProb_3_track_binning1m_DigitalCentroid.pdf"%PlotPath)
    can15.SaveAs("%s/run59/DigitalCentroid/HitProb_4_track_binning1m_DigitalCentroid.pdf"%PlotPath)
    can12bis.SaveAs("%s/run59/DigitalCentroid/HitProb_1_track_binning2m_DigitalCentroid.pdf"%PlotPath)
    can13bis.SaveAs("%s/run59/DigitalCentroid/HitProb_2_track_binning2m_DigitalCentroid.pdf"%PlotPath)
    can14bis.SaveAs("%s/run59/DigitalCentroid/HitProb_3_track_binning2m_DigitalCentroid.pdf"%PlotPath)
    can15bis.SaveAs("%s/run59/DigitalCentroid/HitProb_4_track_binning2m_DigitalCentroid.pdf"%PlotPath)    
    can16.SaveAs("%s/run59/DigitalCentroid/trackX_vs_trackY_plan3_DigitalCentroid.pdf"%PlotPath)
    can17.SaveAs("%s/run59/DigitalCentroid/trackX_vs_trackY_plan0_DigitalCentroid.pdf"%PlotPath)
    can18.SaveAs("%s/run59/DigitalCentroid/ClusterSizeX_DigitalCentroid.pdf"%PlotPath)
    can19.SaveAs("%s/run59/DigitalCentroid/ClusterSizeY_DigitalCentroid.pdf"%PlotPath)
    can20.SaveAs("%s/run59/DigitalCentroid/ClusterSize_DigitalCentroid.pdf"%PlotPath)
    can21.SaveAs("%s/run59/DigitalCentroid/ClusterSizeXvsSizeY_DigitalCentroid.pdf"%PlotPath)
    can22.SaveAs("%s/run59/DigitalCentroid/HitProb_1_correlationX_DigitalCentroid.pdf"%PlotPath)
    can23.SaveAs("%s/run59/DigitalCentroid/HitProb_2_correlationX_DigitalCentroid.pdf"%PlotPath)
    can24.SaveAs("%s/run59/DigitalCentroid/HitProb_3_correlationX_DigitalCentroid.pdf"%PlotPath)
    can25.SaveAs("%s/run59/DigitalCentroid/HitProb_4_correlationX_DigitalCentroid.pdf"%PlotPath)
    can26.SaveAs("%s/run59/DigitalCentroid/HitProb_1_correlationY_DigitalCentroid.pdf"%PlotPath)
    can27.SaveAs("%s/run59/DigitalCentroid/HitProb_2_correlationY_DigitalCentroid.pdf"%PlotPath)
    can28.SaveAs("%s/run59/DigitalCentroid/HitProb_3_correlationY_DigitalCentroid.pdf"%PlotPath)
    can29.SaveAs("%s/run59/DigitalCentroid/HitProb_4_correlationY_DigitalCentroid.pdf"%PlotPath)
    canEtaCorr.SaveAs("%s/run59/DigitalCentroid/Eta_DigitalCentroid.pdf"%PlotPath)
    canEtaCorr2.SaveAs("%s/run59/DigitalCentroid/Eta_hist_DigitalCentroid.pdf"%PlotPath)
    cClusterSizeCounter.SaveAs("%s/run59/DigitalCentroid/ClusterSizeCounter.pdf"%PlotPath)
    cClusterSizeCounter_percent.SaveAs("%s/run59/DigitalCentroid/ClusterSizeCounter_percent.pdf"%PlotPath)
    canvas_resX_s2x2y2.SaveAs("%s/run59/DigitalCentroid/resX_s2x2y2.pdf"%PlotPath)
    canvas_resY_s2x2y2.SaveAs("%s/run59/DigitalCentroid/resY_s2x2y2.pdf"%PlotPath)
    canvas_resX_s2x2y1.SaveAs("%s/run59/DigitalCentroid/resX_s2x2y1.pdf"%PlotPath)
    canvas_resY_s2x2y1.SaveAs("%s/run59/DigitalCentroid/resY_s2x2y1.pdf"%PlotPath)
    canvas_resX_s2x1y2.SaveAs("%s/run59/DigitalCentroid/resX_s2x1y2.pdf"%PlotPath)
    canvas_resY_s2x1y2.SaveAs("%s/run59/DigitalCentroid/resY_s2x1y2.pdf"%PlotPath)
    canvas_resX_s4x2y2.SaveAs("%s/run59/DigitalCentroid/resX_s4x2y2.pdf"%PlotPath)
    canvas_resY_s4x2y2.SaveAs("%s/run59/DigitalCentroid/resY_s4x2y2.pdf"%PlotPath) 
    canvasTest_allTOT.SaveAs("%s/run59/DigitalCentroid/allTOT_landaugausFit.pdf"%PlotPath)
    canvasTest_TOT2.SaveAs("%s/run59/DigitalCentroid/TOT2_landaugausFit.pdf"%PlotPath)
    canvasTest_TOT4.SaveAs("%s/run59/DigitalCentroid/TOT4_landaugausFit.pdf"%PlotPath)

         
elif method_name == "maxTOT" : 
    #out = TFile("%s/run59/run59/maxTOT/output_rootfile_maxTOT_firingFreq001_run000131.root"%PlotPath, "recreate")
    out = TFile("%s/run59/maxTOT/output_rootfile_maxTOT_firingFreq001_run000131_distance%i.root"%(PlotPath,distance), "recreate")
    canhot.SaveAs("%s/run59/maxTOT/histo_hot_maxTOT.pdf"%PlotPath)
    canfreq.SaveAs("%s/run59/maxTOT/histo_freq_maxTOT.pdf"%PlotPath)
    cancorx.SaveAs("%s/run59/maxTOT/corx_maxTOT.pdf"%PlotPath)
    cancory.SaveAs("%s/run59/maxTOT/cory_maxTOT.pdf"%PlotPath)
    can1.SaveAs("%s/run59/maxTOT/allTOT_maxTOT.pdf"%PlotPath)
    can2.SaveAs("%s/run59/maxTOT/TOTnormalized_maxTOT.pdf"%PlotPath)
    can3.SaveAs("%s/run59/maxTOT/resX_maxTOT.pdf"%PlotPath)
    can4.SaveAs("%s/run59/maxTOT/resY_maxTOT.pdf"%PlotPath)
    can5.SaveAs("%s/run59/maxTOT/resX_cs_maxTOT.pdf"%PlotPath)
    can6.SaveAs("%s/run59/maxTOT/resY_cs_maxTOT.pdf"%PlotPath)
    can7.SaveAs("%s/run59/maxTOT/HitProb_1_cluster_binning1m_maxTOT.pdf"%PlotPath)
    can8.SaveAs("%s/run59/maxTOT/HitProb_2_cluster_binning1m_maxTOT.pdf"%PlotPath)
    can9.SaveAs("%s/run59/maxTOT/HitProb_3_cluster_binning1m_maxTOT.pdf"%PlotPath)
    can10.SaveAs("%s/run59/maxTOT/HitProb_4_cluster_binning1m_maxTOT.pdf"%PlotPath)
    can7bis.SaveAs("%s/run59/maxTOT/HitProb_1_cluster_binning2m_maxTOT.pdf"%PlotPath)
    can8bis.SaveAs("%s/run59/maxTOT/HitProb_2_cluster_binning2m_maxTOT.pdf"%PlotPath)
    can9bis.SaveAs("%s/run59/maxTOT/HitProb_3_cluster_binning2m_maxTOT.pdf"%PlotPath)
    can10bis.SaveAs("%s/run59/maxTOT/HitProb_4_cluster_binning2m_maxTOT.pdf"%PlotPath)
    can11.SaveAs("%s/run59/maxTOT/relX_vs_relY_maxTOT.pdf"%PlotPath)
    can12.SaveAs("%s/run59/maxTOT/HitProb_1_track_binning1m_maxTOT.pdf"%PlotPath)
    can13.SaveAs("%s/run59/maxTOT/HitProb_2_track_binning1m_maxTOT.pdf"%PlotPath)
    can14.SaveAs("%s/run59/maxTOT/HitProb_3_track_binning1m_maxTOT.pdf"%PlotPath)
    can15.SaveAs("%s/run59/maxTOT/HitProb_4_track_binning1m_maxTOT.pdf"%PlotPath)
    can12bis.SaveAs("%s/run59/maxTOT/HitProb_1_track_binning2m_maxTOT.pdf"%PlotPath)
    can13bis.SaveAs("%s/run59/maxTOT/HitProb_2_track_binning2m_maxTOT.pdf"%PlotPath)
    can14bis.SaveAs("%s/run59/maxTOT/HitProb_3_track_binning2m_maxTOT.pdf"%PlotPath)
    can15bis.SaveAs("%s/run59/maxTOT/HitProb_4_track_binning2m_maxTOT.pdf"%PlotPath)    
    can16.SaveAs("%s/run59/maxTOT/trackX_vs_trackY_plan3_maxTOT.pdf"%PlotPath)
    can17.SaveAs("%s/run59/maxTOT/trackX_vs_trackY_plan0_maxTOT.pdf"%PlotPath)
    can18.SaveAs("%s/run59/maxTOT/ClusterSizeX_maxTOT.pdf"%PlotPath)
    can19.SaveAs("%s/run59/maxTOT/ClusterSizeY_maxTOT.pdf"%PlotPath)
    can20.SaveAs("%s/run59/maxTOT/ClusterSize_maxTOT.pdf"%PlotPath)
    can21.SaveAs("%s/run59/maxTOT/ClusterSizeXvsSizeY_maxTOT.pdf"%PlotPath)
    can22.SaveAs("%s/run59/maxTOT/HitProb_1_correlationX_maxTOT.pdf"%PlotPath)
    can23.SaveAs("%s/run59/maxTOT/HitProb_2_correlationX_maxTOT.pdf"%PlotPath)
    can24.SaveAs("%s/run59/maxTOT/HitProb_3_correlationX_maxTOT.pdf"%PlotPath)
    can25.SaveAs("%s/run59/maxTOT/HitProb_4_correlationX_maxTOT.pdf"%PlotPath)
    can26.SaveAs("%s/run59/maxTOT/HitProb_1_correlationY_maxTOT.pdf"%PlotPath)
    can27.SaveAs("%s/run59/maxTOT/HitProb_2_correlationY_maxTOT.pdf"%PlotPath)
    can28.SaveAs("%s/run59/maxTOT/HitProb_3_correlationY_maxTOT.pdf"%PlotPath)
    can29.SaveAs("%s/run59/maxTOT/HitProb_4_correlationY_maxTOT.pdf"%PlotPath)
    canEtaCorr.SaveAs("%s/run59/maxTOT/Eta_maxTOT.pdf"%PlotPath)
    canEtaCorr2.SaveAs("%s/run59/maxTOT/Eta_hist_maxTOT.pdf"%PlotPath)
    cClusterSizeCounter.SaveAs("%s/run59/maxTOT/ClusterSizeCounter.pdf"%PlotPath)
    cClusterSizeCounter_percent.SaveAs("%s/run59/maxTOT/ClusterSizeCounter_percent.pdf"%PlotPath)
    canvas_resX_s2x2y2.SaveAs("%s/run59/maxTOT/resX_s2x2y2.pdf"%PlotPath)
    canvas_resY_s2x2y2.SaveAs("%s/run59/maxTOT/resY_s2x2y2.pdf"%PlotPath)
    canvas_resX_s2x2y1.SaveAs("%s/run59/maxTOT/resX_s2x2y1.pdf"%PlotPath)
    canvas_resY_s2x2y1.SaveAs("%s/run59/maxTOT/resY_s2x2y1.pdf"%PlotPath)
    canvas_resX_s2x1y2.SaveAs("%s/run59/maxTOT/resX_s2x1y2.pdf"%PlotPath)
    canvas_resY_s2x1y2.SaveAs("%s/run59/maxTOT/resY_s2x1y2.pdf"%PlotPath)
    canvas_resX_s4x2y2.SaveAs("%s/run59/maxTOT/resX_s4x2y2.pdf"%PlotPath)
    canvas_resY_s4x2y2.SaveAs("%s/run59/maxTOT/resY_s4x2y2.pdf"%PlotPath)
    canvasTest_allTOT.SaveAs("%s/run59/maxTOT/allTOT_landaugausFit.pdf"%PlotPath) 
    canvasTest_TOT2.SaveAs("%s/run59/maxTOT/TOT2_landaugausFit.pdf"%PlotPath)
    canvasTest_TOT4.SaveAs("%s/run59/maxTOT/TOT4_landaugausFit.pdf"%PlotPath)
    
elif method_name == "EtaCorrection" : 
    out = TFile("%s/run59/EtaCorrection/output_rootfile_EtaCorrection_firingFreq001_run000131_distance%i.root"%(PlotPath,distance), "recreate")
#     out = TFile("%s/run59/EtaCorrection/output_rootfile_EtaCorrection_firingFreq001_run000131_distance%i_sigma%i.root"%(PlotPath,distance,sigma*1000), "recreate")
    canhot.SaveAs("%s/run59/EtaCorrection/histo_hot_EtaCorrection.pdf"%PlotPath)
    canfreq.SaveAs("%s/run59/EtaCorrection/histo_freq_EtaCorrection.pdf"%PlotPath)
    cancorx.SaveAs("%s/run59/EtaCorrection/corx_EtaCorrection.pdf"%PlotPath)
    cancory.SaveAs("%s/run59/EtaCorrection/cory_EtaCorrection.pdf"%PlotPath)
    can1.SaveAs("%s/run59/EtaCorrection/allTOT_EtaCorrection.pdf"%PlotPath)
    can2.SaveAs("%s/run59/EtaCorrection/TOTnormalized_EtaCorrection.pdf"%PlotPath)
    can3.SaveAs("%s/run59/EtaCorrection/resX_EtaCorrection.pdf"%PlotPath)
    can4.SaveAs("%s/run59/EtaCorrection/resY_EtaCorrection.pdf"%PlotPath)
    can5.SaveAs("%s/run59/EtaCorrection/resX_cs_EtaCorrection.pdf"%PlotPath)
    can6.SaveAs("%s/run59/EtaCorrection/resY_cs_EtaCorrection.pdf"%PlotPath)
    can7.SaveAs("%s/run59/EtaCorrection/HitProb_1_cluster_binning1m_EtaCorrection.pdf"%PlotPath)
    can8.SaveAs("%s/run59/EtaCorrection/HitProb_2_cluster_binning1m_EtaCorrection.pdf"%PlotPath)
    can9.SaveAs("%s/run59/EtaCorrection/HitProb_3_cluster_binning1m_EtaCorrection.pdf"%PlotPath)
    can10.SaveAs("%s/run59/EtaCorrection/HitProb_4_cluster_binning1m_EtaCorrection.pdf"%PlotPath)
    can7bis.SaveAs("%s/run59/EtaCorrection/HitProb_1_cluster_binning2m_EtaCorrection.pdf"%PlotPath)
    can8bis.SaveAs("%s/run59/EtaCorrection/HitProb_2_cluster_binning2m_EtaCorrection.pdf"%PlotPath)
    can9bis.SaveAs("%s/run59/EtaCorrection/HitProb_3_cluster_binning2m_EtaCorrection.pdf"%PlotPath)
    can10bis.SaveAs("%s/run59/EtaCorrection/HitProb_4_cluster_binning2m_EtaCorrection.pdf"%PlotPath)
    can11.SaveAs("%s/run59/EtaCorrection/relX_vs_relY_EtaCorrection.pdf"%PlotPath)
    can12.SaveAs("%s/run59/EtaCorrection/HitProb_1_track_binning1m_EtaCorrection.pdf"%PlotPath)
    can13.SaveAs("%s/run59/EtaCorrection/HitProb_2_track_binning1m_EtaCorrection.pdf"%PlotPath)
    can14.SaveAs("%s/run59/EtaCorrection/HitProb_3_track_binning1m_EtaCorrection.pdf"%PlotPath)
    can15.SaveAs("%s/run59/EtaCorrection/HitProb_4_track_binning1m_EtaCorrection.pdf"%PlotPath)
    can12bis.SaveAs("%s/run59/EtaCorrection/HitProb_1_track_binning2m_EtaCorrection.pdf"%PlotPath)
    can13bis.SaveAs("%s/run59/EtaCorrection/HitProb_2_track_binning2m_EtaCorrection.pdf"%PlotPath)
    can14bis.SaveAs("%s/run59/EtaCorrection/HitProb_3_track_binning2m_EtaCorrection.pdf"%PlotPath)
    can15bis.SaveAs("%s/run59/EtaCorrection/HitProb_4_track_binning2m_EtaCorrection.pdf"%PlotPath)    
    can16.SaveAs("%s/run59/EtaCorrection/trackX_vs_trackY_plan3_EtaCorrection.pdf"%PlotPath)
    can17.SaveAs("%s/run59/EtaCorrection/trackX_vs_trackY_plan0_EtaCorrection.pdf"%PlotPath)
    can18.SaveAs("%s/run59/EtaCorrection/ClusterSizeX_EtaCorrection.pdf"%PlotPath)
    can19.SaveAs("%s/run59/EtaCorrection/ClusterSizeY_EtaCorrection.pdf"%PlotPath)
    can20.SaveAs("%s/run59/EtaCorrection/ClusterSize_EtaCorrection.pdf"%PlotPath)
    can21.SaveAs("%s/run59/EtaCorrection/ClusterSizeXvsSizeY_EtaCorrection.pdf"%PlotPath)
    can22.SaveAs("%s/run59/EtaCorrection/HitProb_1_correlationX_EtaCorrection.pdf"%PlotPath)
    can23.SaveAs("%s/run59/EtaCorrection/HitProb_2_correlationX_EtaCorrection.pdf"%PlotPath)
    can24.SaveAs("%s/run59/EtaCorrection/HitProb_3_correlationX_EtaCorrection.pdf"%PlotPath)
    can25.SaveAs("%s/run59/EtaCorrection/HitProb_4_correlationX_EtaCorrection.pdf"%PlotPath)
    can26.SaveAs("%s/run59/EtaCorrection/HitProb_1_correlationY_EtaCorrection.pdf"%PlotPath)
    can27.SaveAs("%s/run59/EtaCorrection/HitProb_2_correlationY_EtaCorrection.pdf"%PlotPath)
    can28.SaveAs("%s/run59/EtaCorrection/HitProb_3_correlationY_EtaCorrection.pdf"%PlotPath)
    can29.SaveAs("%s/run59/EtaCorrection/HitProb_4_correlationY_EtaCorrection.pdf"%PlotPath)
    canEtaCorr.SaveAs("%s/run59/EtaCorrection/Eta_EtaCorrection.pdf"%PlotPath)
    canEtaCorr2.SaveAs("%s/run59/EtaCorrection/Eta_hist_EtaCorrection.pdf"%PlotPath)
    cClusterSizeCounter.SaveAs("%s/run59/EtaCorrection/ClusterSizeCounter.pdf"%PlotPath)
    cClusterSizeCounter_percent.SaveAs("%s/run59/EtaCorrection/ClusterSizeCounter_percent.pdf"%PlotPath)
    canvas_resX_s2x2y2.SaveAs("%s/run59/EtaCorrection/resX_s2x2y2.pdf"%PlotPath)
    canvas_resY_s2x2y2.SaveAs("%s/run59/EtaCorrection/resY_s2x2y2.pdf"%PlotPath)
    canvas_resX_s2x2y1.SaveAs("%s/run59/EtaCorrection/resX_s2x2y1.pdf"%PlotPath)
    canvas_resY_s2x2y1.SaveAs("%s/run59/EtaCorrection/resY_s2x2y1.pdf"%PlotPath)
    canvas_resX_s2x1y2.SaveAs("%s/run59/EtaCorrection/resX_s2x1y2.pdf"%PlotPath)
    canvas_resY_s2x1y2.SaveAs("%s/run59/EtaCorrection/resY_s2x1y2.pdf"%PlotPath)
    canvas_resX_s4x2y2.SaveAs("%s/run59/EtaCorrection/resX_s4x2y2.pdf"%PlotPath)
    canvas_resY_s4x2y2.SaveAs("%s/run59/EtaCorrection/resY_s4x2y2.pdf"%PlotPath)
#     canvasTest_allTOT.SaveAs("%s/run59/EtaCorrection/allTOT_landaugausFit.pdf"%PlotPath)
#     canvasTest_TOT2.SaveAs("%s/run59/EtaCorrection/TOT2_landaugausFit.pdf"%PlotPath)
#     canvasTest_TOT4.SaveAs("%s/run59/EtaCorrection/TOT4_landaugausFit.pdf"%PlotPath)

can_resX_cs_0 = TCanvas()
resX_cs[0].Draw()
r0 = resX_cs[0].Fit("gaus","","") 
    
can_resY_cs_0 = TCanvas()
resY_cs[0].Draw()
r0 = resY_cs[0].Fit("gaus","","") 
       
can_resX_cs_1 = TCanvas()
resX_cs[1].Draw()
r0 = resX_cs[1].Fit("gaus","","") 
       
can_resY_cs_1 = TCanvas()
resY_cs[1].Draw()
r0 = resY_cs[1].Fit("gaus","","") 
       
           
if method_name == "EtaCorrection" : 
    can_resX_cs_1.SaveAs("%s/run59/EtaCorrection/resX_cs_1_fit_EtaCorrection.pdf"%PlotPath)
    can_resY_cs_1.SaveAs("%s/run59/EtaCorrection/resY_cs_1_fit_EtaCorrection.pdf"%PlotPath)
    can_resX_cs_0.SaveAs("%s/run59/EtaCorrection/resX_cs_0_fit_EtaCorrection.pdf"%PlotPath)
    can_resY_cs_0.SaveAs("%s/run59/EtaCorrection/resY_cs_0_fit_EtaCorrection.pdf"%PlotPath)
elif method_name == "QWeighted" : 
    can_resX_cs_1.SaveAs("%s/run59/QWeighted/resX_cs_1_fit_QWeighted.pdf"%PlotPath)
    can_resY_cs_1.SaveAs("%s/run59/QWeighted/resY_cs_1_fit_QWeighted.pdf"%PlotPath)
    can_resX_cs_0.SaveAs("%s/run59/QWeighted/resX_cs_0_fit_QWeighted.pdf"%PlotPath)
    can_resY_cs_0.SaveAs("%s/run59/QWeighted/resY_cs_0_fit_QWeighted.pdf"%PlotPath)
elif method_name == "DigitalCentroid" : 
    can_resX_cs_1.SaveAs("%s/run59/DigitalCentroid/resX_cs_1_fit_DigitalCentroid.pdf"%PlotPath)
    can_resY_cs_1.SaveAs("%s/run59/DigitalCentroid/resY_cs_1_fit_DigitalCentroid.pdf"%PlotPath)
    can_resX_cs_0.SaveAs("%s/run59/DigitalCentroid/resX_cs_0_fit_DigitalCentroid.pdf"%PlotPath)
    can_resY_cs_0.SaveAs("%s/run59/DigitalCentroid/resY_cs_0_fit_DigitalCentroid.pdf"%PlotPath)
elif method_name == "maxTOT" : 
    can_resX_cs_1.SaveAs("%s/run59/maxTOT/resX_cs_1_fit_maxTOT.pdf"%PlotPath)
    can_resY_cs_1.SaveAs("%s/run59/maxTOT/resY_cs_1_fit_maxTOT.pdf"%PlotPath)
    can_resX_cs_0.SaveAs("%s/run59/maxTOT/resX_cs_0_fit_maxTOT.pdf"%PlotPath)
    can_resY_cs_0.SaveAs("%s/run59/maxTOT/resY_cs_0_fit_maxTOT.pdf"%PlotPath)


# print 'test1'
#  
# g1 = TF1("m1","gaus",-0.025,pitchX/sqrt(12))
# g2 = TF1("m2","gaus",0.025,pitchX/sqrt(12))
#       
# can_resX_cs_0 = TCanvas()
# resX_cs[0].Draw()
# r0 = resX_cs[0].Fit("gaus","","",-0.05,0.05) 
#  
# print 'test2'
#       
# can_resX_cs_1 = TCanvas()
# resX_cs[1].Draw()
# r1 = resX_cs[1].Fit(g1,"S","",-0.03,0.0)
# r1bis = resX_cs[1].Fit(g2,"S+","",0.0,0.030)
# fitResult_resX_cs_1 = TPaveText(0.13,0.69,0.33,0.88,"NDC")
# fitResult_resX_cs_1.AddText("mean 1 : %f"%(r1.Parameter(1)))
# fitResult_resX_cs_1.AddText("sigma 1 : %f"%(r1.Parameter(2)))
# fitResult_resX_cs_1.AddLine(.0,.5,1.,.5)
# fitResult_resX_cs_1.AddText("mean 2 : %f"%(r1bis.Parameter(1)))
# fitResult_resX_cs_1.AddText("sigma 2 : %f"%(r1bis.Parameter(2)))
# fitResult_resX_cs_1.Draw("same")
# 
# print 'test3'
#       
# can_resX_cs_2 = TCanvas()
# resX_cs[2].Draw()
# r2 = resX_cs[2].Fit(g1,"S","",-0.05,0.0)
# r2bis = resX_cs[2].Fit(g2,"S+","",0.0,0.050)
# # r2 = resX_cs[2].Fit(g1,"RS")
# # r2bis = resX_cs[2].Fit(g2,"RS+")
# fitResult_resX_cs_2 = TPaveText(0.13,0.69,0.33,0.88,"NDC")
# fitResult_resX_cs_2.AddText("mean 1 : %f"%(r2.Parameter(1)))
# fitResult_resX_cs_2.AddText("sigma 1 : %f"%(r2.Parameter(2)))
# fitResult_resX_cs_2.AddLine(.0,.5,1.,.5)
# fitResult_resX_cs_2.AddText("mean 2 : %f"%(r2bis.Parameter(1)))
# fitResult_resX_cs_2.AddText("sigma 2 : %f"%(r2bis.Parameter(2)))
# fitResult_resX_cs_2.Draw("same")
# 
# print 'test4'
#       
# can_resY_cs_0 = TCanvas()
# resY_cs[0].Draw()
# r0 = resY_cs[0].Fit("gaus","","",-0.05,0.05) 
#       
# can_resY_cs_1 = TCanvas()
# resY_cs[1].Draw()
# r1 = resY_cs[1].Fit(g1,"S","",-0.05,0.0)
# r1bis = resY_cs[1].Fit(g2,"S+","",0.0,0.050)
# # r1 = resY_cs[1].Fit(g1,"RS")
# # r1bis = resY_cs[1].Fit(g2,"RS+")
# fitResult_resY_cs_1 = TPaveText(0.13,0.69,0.33,0.88,"NDC")
# fitResult_resY_cs_1.AddText("mean 1 : %f"%(r1.Parameter(1)))
# fitResult_resY_cs_1.AddText("sigma 1 : %f"%(r1.Parameter(2)))
# fitResult_resY_cs_1.AddLine(.0,.5,1.,.5)
# fitResult_resY_cs_1.AddText("mean 2 : %f"%(r1bis.Parameter(1)))
# fitResult_resY_cs_1.AddText("sigma 2 : %f"%(r1bis.Parameter(2)))
# fitResult_resY_cs_1.Draw("same")
#       
# can_resY_cs_2 = TCanvas()
# resY_cs[2].Draw()
# r2 = resY_cs[2].Fit(g1,"RS")
# r2bis = resY_cs[2].Fit(g2,"RS+")
# fitResult_resY_cs_2 = TPaveText(0.13,0.69,0.33,0.88,"NDC")
# fitResult_resY_cs_2.AddText("mean 1 : %f"%(r2.Parameter(1)))
# fitResult_resY_cs_2.AddText("sigma 1 : %f"%(r2.Parameter(2)))
# fitResult_resY_cs_2.AddLine(.0,.5,1.,.5)
# fitResult_resY_cs_2.AddText("mean 2 : %f"%(r2bis.Parameter(1)))
# fitResult_resY_cs_2.AddText("sigma 2 : %f"%(r2bis.Parameter(2)))
# fitResult_resY_cs_2.Draw("same")
#       
#       
# if method_name == "QWeighted" :
#     can_resX_cs_0.SaveAs("%s/run59/QWeighted/resX_cs_0_fit_QWeighted.pdf"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/run59/QWeighted/resX_cs_1_fit_QWeighted.pdf"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/run59/QWeighted/resX_cs_2_fit_QWeighted.pdf"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/run59/QWeighted/resY_cs_0_fit_QWeighted.pdf"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/run59/QWeighted/resY_cs_1_fit_QWeighted.pdf"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/run59/QWeighted/resY_cs_2_fit_QWeighted.pdf"%PlotPath)
#        
# elif method_name == "DigitalCentroid" :
#     can_resX_cs_0.SaveAs("%s/run59/DigitalCentroid/resX_cs_0_fit_DigitalCentroid.pdf"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/run59/DigitalCentroid/resX_cs_1_fit_DigitalCentroid.pdf"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/run59/DigitalCentroid/resX_cs_2_fit_DigitalCentroid.pdf"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/run59/DigitalCentroid/resY_cs_0_fit_DigitalCentroid.pdf"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/run59/DigitalCentroid/resY_cs_1_fit_DigitalCentroid.pdf"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/run59/DigitalCentroid/resY_cs_2_fit_DigitalCentroid.pdf"%PlotPath)
#            
# elif method_name == "maxTOT" : 
#     can_resX_cs_0.SaveAs("%s/run59/maxTOT/resX_cs_0_fit_maxTOT.pdf"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/run59/maxTOT/resX_cs_1_fit_maxTOT.pdf"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/run59/maxTOT/resX_cs_2_fit_maxTOT.pdf"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/run59/maxTOT/resY_cs_0_fit_maxTOT.pdf"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/run59/maxTOT/resY_cs_1_fit_maxTOT.pdf"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/run59/maxTOT/resY_cs_2_fit_maxTOT.pdf"%PlotPath)
#           
# elif method_name == "EtaCorrection" : 
#     can_resX_cs_0.SaveAs("%s/run59/EtaCorrection/resX_cs_0_fit_EtaCorrection.pdf"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/run59/EtaCorrection/resX_cs_1_fit_EtaCorrection.pdf"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/run59/EtaCorrection/resX_cs_2_fit_EtaCorrection.pdf"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/run59/EtaCorrection/resY_cs_0_fit_EtaCorrection.pdf"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/run59/EtaCorrection/resY_cs_1_fit_EtaCorrection.pdf"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/run59/EtaCorrection/resY_cs_2_fit_EtaCorrection.pdf"%PlotPath)
     
out.cd()
hx.Write()
hy.Write()
histo_hot.Write()
histo_freq.Write()
trackX_vs_trackY_plan3.Write()
trackX_vs_trackY_plan0.Write()
allTOT.Write
relX_vs_relY.Write()
TOT1.Write()
TOT2.Write()
TOT3.Write()
TOT4.Write()
resX.Write()
resY.Write()
HitProb_1_cluster_binning1m.Write()
HitProb_2_cluster_binning1m.Write()
HitProb_3_cluster_binning1m.Write()
HitProb_4_cluster_binning1m.Write()
HitProb_1_track_binning1m.Write()
HitProb_2_track_binning1m.Write()
HitProb_3_track_binning1m.Write()
HitProb_4_track_binning1m.Write()
HitProb_1_cluster_binning2m.Write()
HitProb_2_cluster_binning2m.Write()
HitProb_3_cluster_binning2m.Write()
HitProb_4_cluster_binning2m.Write()
HitProb_1_track_binning2m.Write()
HitProb_2_track_binning2m.Write()
HitProb_3_track_binning2m.Write()
HitProb_4_track_binning2m.Write()
graph1.Write()
QrelWrtMindistance.Write()
hClusterSizeX.Write() 
hClusterSizeY.Write() 
hClusterSize.Write()
hClusterSizeXvsSizeY.Write()
HitProb_1_correlationX.Write()
HitProb_2_correlationX.Write()
HitProb_3_correlationX.Write()
HitProb_4_correlationX.Write()
HitProb_1_correlationY.Write()
HitProb_2_correlationY.Write()
HitProb_3_correlationY.Write()
HitProb_4_correlationY.Write()
for i in range(1,n_cs+2) :
    resX_cs[i-1].Write()
    resY_cs[i-1].Write()
hClusterSizeCounter_percent.Write()
hClusterSizeCounter.Write()
       
#aDataSet.DumpClusterTree("run131_uncalibrated_cluster.root")
#aDataSet_calib.DumpClusterTree("run131_calibrated_cluster.root")
