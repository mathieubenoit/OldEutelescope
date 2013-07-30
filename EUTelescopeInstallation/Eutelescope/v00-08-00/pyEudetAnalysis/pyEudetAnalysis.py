from ROOT import *
import ROOT
from ROOT import gStyle
from ROOT import TMath
from math import fsum
from array import array 
from EudetData import *
from ToolBox import *

PlotPath = "/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots"

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

# method_name = "QWeighted"
# method_name = "DigitalCentroid"
# method_name = "maxTOT"
method_name = "EtaCorrection"


#aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000062.root",500.0)
aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131.root",500.0,2)

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
histo_hot,histo_freq = aDataSet.FilterHotPixel(0.001,25000)

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
    #aDataSet.FindMatchedCluster(i, 0.350, 0.350,6)
    aDataSet.FindMatchedCluster(i, 2., 2.,6)
    if i%1000 ==0 :
        print "Event %d"%i
    #aDataSet.PrintClusters(i)    
    #aDataSet.PrintEvent(i)
    
    n_matched+=aDataSet.ComputeResiduals(i)
    
    aDataSet.getEvent(i)
    trackX_vs_trackY_plan3.Fill(aDataSet.t_posX[3],aDataSet.t_posY[3])
    trackX_vs_trackY_plan0.Fill(aDataSet.t_posX[0],aDataSet.t_posY[0])

print "Found %i matched track-cluster binome"%n_matched

n_tracks_in = ComputeDetectorAcceptance(aDataSet)
print "Found %i tracks in the detector acceptance"%n_tracks_in

if n_tracks_in!=0 :
    print "detector efficiency = %f"%float((1.*n_matched)/(1.*n_tracks_in))

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

#ApplyAlignment(aDataSet,[0.016125, 0.020414 , 0.],[0.0000000000, 0.0000000000, -0.072316])

# for i in range(10000) : 
for i in range(aDataSet.p_nEntries) :
    aDataSet.ComputeResiduals(i)
        
hx,hy = TrackClusterCorrelation(aDataSet)
#hxc,hyc = TrackClusterCorrelation(aDataSet_calib)
 
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

distance = 0 #microns
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
#             hClusterSizeX.Fill(aCluster.sizeX)
#             hClusterSizeY.Fill(aCluster.sizeY)
#             hClusterSize.Fill(aCluster.size)
#             hClusterSizeXvsSizeY.Fill(aCluster.sizeX,aCluster.sizeY)
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
 
can1 = TCanvas()			
allTOT.Draw()
 
# TOT1.Scale(1./(TOT1.Integral())) 
# TOT2.Scale(1./(TOT2.Integral()))
# TOT3.Scale(1./(TOT3.Integral()))
# TOT4.Scale(1./(TOT4.Integral()))

can2=TCanvas()
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
#     resX_cs[i-1].Scale(1./(resX_cs[i-1].Integral()))
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
#     resY_cs[i-1].Scale(1./(resY_cs[i-1].Integral())) 
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


if method_name == "QWeighted" :
    out = TFile("%s/QWeighted/output_rootfile_QWeighted_firingFreq001_run000131.root"%PlotPath, "recreate")
    canhot.SaveAs("%s/QWeighted/histo_hot_QWeighted.png"%PlotPath)
    canfreq.SaveAs("%s/QWeighted/histo_freq_QWeighted.png"%PlotPath)
    cancorx.SaveAs("%s/QWeighted/corx_QWeighted.png"%PlotPath)
    cancory.SaveAs("%s/QWeighted/cory_QWeighted.png"%PlotPath)
    can1.SaveAs("%s/QWeighted/allTOT_QWeighted.png"%PlotPath)
    can2.SaveAs("%s/QWeighted/TOTnormalized_QWeighted.png"%PlotPath)
    can3.SaveAs("%s/QWeighted/resX_QWeighted.png"%PlotPath)
    can4.SaveAs("%s/QWeighted/resY_QWeighted.png"%PlotPath)
    can5.SaveAs("%s/QWeighted/resX_cs_QWeighted.png"%PlotPath)
    can6.SaveAs("%s/QWeighted/resY_cs_QWeighted.png"%PlotPath)
    can7.SaveAs("%s/QWeighted/HitProb_1_cluster_binning1m_QWeighted.png"%PlotPath)
    can8.SaveAs("%s/QWeighted/HitProb_2_cluster_binning1m_QWeighted.png"%PlotPath)
    can9.SaveAs("%s/QWeighted/HitProb_3_cluster_binning1m_QWeighted.png"%PlotPath)
    can10.SaveAs("%s/QWeighted/HitProb_4_cluster_binning1m_QWeighted.png"%PlotPath)
    can7bis.SaveAs("%s/QWeighted/HitProb_1_cluster_binning2m_QWeighted.png"%PlotPath)
    can8bis.SaveAs("%s/QWeighted/HitProb_2_cluster_binning2m_QWeighted.png"%PlotPath)
    can9bis.SaveAs("%s/QWeighted/HitProb_3_cluster_binning2m_QWeighted.png"%PlotPath)
    can10bis.SaveAs("%s/QWeighted/HitProb_4_cluster_binning2m_QWeighted.png"%PlotPath)
    can11.SaveAs("%s/QWeighted/relX_vs_relY_QWeighted.png"%PlotPath)
    can12.SaveAs("%s/QWeighted/HitProb_1_track_binning1m_QWeighted.png"%PlotPath)
    can13.SaveAs("%s/QWeighted/HitProb_2_track_binning1m_QWeighted.png"%PlotPath)
    can14.SaveAs("%s/QWeighted/HitProb_3_track_binning1m_QWeighted.png"%PlotPath)
    can15.SaveAs("%s/QWeighted/HitProb_4_track_binning1m_QWeighted.png"%PlotPath)
    can12bis.SaveAs("%s/QWeighted/HitProb_1_track_binning2m_QWeighted.png"%PlotPath)
    can13bis.SaveAs("%s/QWeighted/HitProb_2_track_binning2m_QWeighted.png"%PlotPath)
    can14bis.SaveAs("%s/QWeighted/HitProb_3_track_binning2m_QWeighted.png"%PlotPath)
    can15bis.SaveAs("%s/QWeighted/HitProb_4_track_binning2m_QWeighted.png"%PlotPath)    
    can16.SaveAs("%s/QWeighted/trackX_vs_trackY_plan3_QWeighted.png"%PlotPath)
    can17.SaveAs("%s/QWeighted/trackX_vs_trackY_plan0_QWeighted.png"%PlotPath)
    can18.SaveAs("%s/QWeighted/ClusterSizeX_QWeighted.png"%PlotPath)
    can19.SaveAs("%s/QWeighted/ClusterSizeY_QWeighted.png"%PlotPath)
    can20.SaveAs("%s/QWeighted/ClusterSize_QWeighted.png"%PlotPath)
    can21.SaveAs("%s/QWeighted/ClusterSizeXvsSizeY_QWeighted.png"%PlotPath)
    canEtaCorr.SaveAs("%s/QWeighted/Eta_QWeighted.png"%PlotPath)
    canEtaCorr2.SaveAs("%s/QWeighted/Eta_hist_QWeighted.png"%PlotPath)
 
 
elif method_name == "DigitalCentroid" :
    out = TFile("%s/DigitalCentroid/output_rootfile_DigitalCentroid_firingFreq001_run000131.root"%PlotPath, "recreate")
    canhot.SaveAs("%s/DigitalCentroid/histo_hot_DigitalCentroid.png"%PlotPath)
    canfreq.SaveAs("%s/DigitalCentroid/histo_freq_DigitalCentroid.png"%PlotPath)
    cancorx.SaveAs("%s/DigitalCentroid/corx_DigitalCentroid.png"%PlotPath)
    cancory.SaveAs("%s/DigitalCentroid/cory_DigitalCentroid.png"%PlotPath)
    can1.SaveAs("%s/DigitalCentroid/allTOT_DigitalCentroid.png"%PlotPath)
    can2.SaveAs("%s/DigitalCentroid/TOTnormalized_DigitalCentroid.png"%PlotPath)
    can3.SaveAs("%s/DigitalCentroid/resX_DigitalCentroid.png"%PlotPath)
    can4.SaveAs("%s/DigitalCentroid/resY_DigitalCentroid.png"%PlotPath)
    can5.SaveAs("%s/DigitalCentroid/resX_cs_DigitalCentroid.png"%PlotPath)
    can6.SaveAs("%s/DigitalCentroid/resY_cs_DigitalCentroid.png"%PlotPath)
    can7.SaveAs("%s/DigitalCentroid/HitProb_1_cluster_binning1m_DigitalCentroid.png"%PlotPath)
    can8.SaveAs("%s/DigitalCentroid/HitProb_2_cluster_binning1m_DigitalCentroid.png"%PlotPath)
    can9.SaveAs("%s/DigitalCentroid/HitProb_3_cluster_binning1m_DigitalCentroid.png"%PlotPath)
    can10.SaveAs("%s/DigitalCentroid/HitProb_4_cluster_binning1m_DigitalCentroid.png"%PlotPath)
    can7bis.SaveAs("%s/DigitalCentroid/HitProb_1_cluster_binning2m_DigitalCentroid.png"%PlotPath)
    can8bis.SaveAs("%s/DigitalCentroid/HitProb_2_cluster_binning2m_DigitalCentroid.png"%PlotPath)
    can9bis.SaveAs("%s/DigitalCentroid/HitProb_3_cluster_binning2m_DigitalCentroid.png"%PlotPath)
    can10bis.SaveAs("%s/DigitalCentroid/HitProb_4_cluster_binning2m_DigitalCentroid.png"%PlotPath)
    can11.SaveAs("%s/DigitalCentroid/relX_vs_relY_DigitalCentroid.png"%PlotPath)
    can12.SaveAs("%s/DigitalCentroid/HitProb_1_track_binning1m_DigitalCentroid.png"%PlotPath)
    can13.SaveAs("%s/DigitalCentroid/HitProb_2_track_binning1m_DigitalCentroid.png"%PlotPath)
    can14.SaveAs("%s/DigitalCentroid/HitProb_3_track_binning1m_DigitalCentroid.png"%PlotPath)
    can15.SaveAs("%s/DigitalCentroid/HitProb_4_track_binning1m_DigitalCentroid.png"%PlotPath)
    can12bis.SaveAs("%s/DigitalCentroid/HitProb_1_track_binning2m_DigitalCentroid.png"%PlotPath)
    can13bis.SaveAs("%s/DigitalCentroid/HitProb_2_track_binning2m_DigitalCentroid.png"%PlotPath)
    can14bis.SaveAs("%s/DigitalCentroid/HitProb_3_track_binning2m_DigitalCentroid.png"%PlotPath)
    can15bis.SaveAs("%s/DigitalCentroid/HitProb_4_track_binning2m_DigitalCentroid.png"%PlotPath)    
    can16.SaveAs("%s/DigitalCentroid/trackX_vs_trackY_plan3_DigitalCentroid.png"%PlotPath)
    can17.SaveAs("%s/DigitalCentroid/trackX_vs_trackY_plan0_DigitalCentroid.png"%PlotPath)
    can18.SaveAs("%s/DigitalCentroid/ClusterSizeX_DigitalCentroid.png"%PlotPath)
    can19.SaveAs("%s/DigitalCentroid/ClusterSizeY_DigitalCentroid.png"%PlotPath)
    can20.SaveAs("%s/DigitalCentroid/ClusterSize_DigitalCentroid.png"%PlotPath)
    can21.SaveAs("%s/DigitalCentroid/ClusterSizeXvsSizeY_DigitalCentroid.png"%PlotPath)
    canEtaCorr.SaveAs("%s/DigitalCentroid/Eta_DigitalCentroid.png"%PlotPath)
    canEtaCorr2.SaveAs("%s/DigitalCentroid/Eta_hist_DigitalCentroid.png"%PlotPath)

         
elif method_name == "maxTOT" : 
    out = TFile("%s/maxTOT/output_rootfile_maxTOT_firingFreq001_run000131.root"%PlotPath, "recreate")
    canhot.SaveAs("%s/maxTOT/histo_hot_maxTOT.png"%PlotPath)
    canfreq.SaveAs("%s/maxTOT/histo_freq_maxTOT.png"%PlotPath)
    cancorx.SaveAs("%s/maxTOT/corx_maxTOT.png"%PlotPath)
    cancory.SaveAs("%s/maxTOT/cory_maxTOT.png"%PlotPath)
    can1.SaveAs("%s/maxTOT/allTOT_maxTOT.png"%PlotPath)
    can2.SaveAs("%s/maxTOT/TOTnormalized_maxTOT.png"%PlotPath)
    can3.SaveAs("%s/maxTOT/resX_maxTOT.png"%PlotPath)
    can4.SaveAs("%s/maxTOT/resY_maxTOT.png"%PlotPath)
    can5.SaveAs("%s/maxTOT/resX_cs_maxTOT.png"%PlotPath)
    can6.SaveAs("%s/maxTOT/resY_cs_maxTOT.png"%PlotPath)
    can7.SaveAs("%s/maxTOT/HitProb_1_cluster_binning1m_maxTOT.png"%PlotPath)
    can8.SaveAs("%s/maxTOT/HitProb_2_cluster_binning1m_maxTOT.png"%PlotPath)
    can9.SaveAs("%s/maxTOT/HitProb_3_cluster_binning1m_maxTOT.png"%PlotPath)
    can10.SaveAs("%s/maxTOT/HitProb_4_cluster_binning1m_maxTOT.png"%PlotPath)
    can7bis.SaveAs("%s/maxTOT/HitProb_1_cluster_binning2m_maxTOT.png"%PlotPath)
    can8bis.SaveAs("%s/maxTOT/HitProb_2_cluster_binning2m_maxTOT.png"%PlotPath)
    can9bis.SaveAs("%s/maxTOT/HitProb_3_cluster_binning2m_maxTOT.png"%PlotPath)
    can10bis.SaveAs("%s/maxTOT/HitProb_4_cluster_binning2m_maxTOT.png"%PlotPath)
    can11.SaveAs("%s/maxTOT/relX_vs_relY_maxTOT.png"%PlotPath)
    can12.SaveAs("%s/maxTOT/HitProb_1_track_binning1m_maxTOT.png"%PlotPath)
    can13.SaveAs("%s/maxTOT/HitProb_2_track_binning1m_maxTOT.png"%PlotPath)
    can14.SaveAs("%s/maxTOT/HitProb_3_track_binning1m_maxTOT.png"%PlotPath)
    can15.SaveAs("%s/maxTOT/HitProb_4_track_binning1m_maxTOT.png"%PlotPath)
    can12bis.SaveAs("%s/maxTOT/HitProb_1_track_binning2m_maxTOT.png"%PlotPath)
    can13bis.SaveAs("%s/maxTOT/HitProb_2_track_binning2m_maxTOT.png"%PlotPath)
    can14bis.SaveAs("%s/maxTOT/HitProb_3_track_binning2m_maxTOT.png"%PlotPath)
    can15bis.SaveAs("%s/maxTOT/HitProb_4_track_binning2m_maxTOT.png"%PlotPath)    
    can16.SaveAs("%s/maxTOT/trackX_vs_trackY_plan3_maxTOT.png"%PlotPath)
    can17.SaveAs("%s/maxTOT/trackX_vs_trackY_plan0_maxTOT.png"%PlotPath)
    can18.SaveAs("%s/maxTOT/ClusterSizeX_maxTOT.png"%PlotPath)
    can19.SaveAs("%s/maxTOT/ClusterSizeY_maxTOT.png"%PlotPath)
    can20.SaveAs("%s/maxTOT/ClusterSize_maxTOT.png"%PlotPath)
    can21.SaveAs("%s/maxTOT/ClusterSizeXvsSizeY_maxTOT.png"%PlotPath)
    canEtaCorr.SaveAs("%s/maxTOT/Eta_maxTOT.png"%PlotPath)
    canEtaCorr2.SaveAs("%s/maxTOT/Eta_hist_maxTOT.png"%PlotPath)
    
elif method_name == "EtaCorrection" : 
    out = TFile("%s/EtaCorrection/output_rootfile_EtaCorrection_firingFreq001_run000131.root"%PlotPath, "recreate")
    out = TFile("%s/EtaCorrection/output_rootfile_EtaCorrection_firingFreq001_run000131_distance%i.root"%(PlotPath,distance), "recreate")
    canhot.SaveAs("%s/EtaCorrection/histo_hot_EtaCorrection.png"%PlotPath)
    canfreq.SaveAs("%s/EtaCorrection/histo_freq_EtaCorrection.png"%PlotPath)
    cancorx.SaveAs("%s/EtaCorrection/corx_EtaCorrection.png"%PlotPath)
    cancory.SaveAs("%s/EtaCorrection/cory_EtaCorrection.png"%PlotPath)
    can1.SaveAs("%s/EtaCorrection/allTOT_EtaCorrection.png"%PlotPath)
    can2.SaveAs("%s/EtaCorrection/TOTnormalized_EtaCorrection.png"%PlotPath)
    can3.SaveAs("%s/EtaCorrection/resX_EtaCorrection.png"%PlotPath)
    can4.SaveAs("%s/EtaCorrection/resY_EtaCorrection.png"%PlotPath)
    can5.SaveAs("%s/EtaCorrection/resX_cs_EtaCorrection.png"%PlotPath)
    can6.SaveAs("%s/EtaCorrection/resY_cs_EtaCorrection.png"%PlotPath)
    can7.SaveAs("%s/EtaCorrection/HitProb_1_cluster_binning1m_EtaCorrection.png"%PlotPath)
    can8.SaveAs("%s/EtaCorrection/HitProb_2_cluster_binning1m_EtaCorrection.png"%PlotPath)
    can9.SaveAs("%s/EtaCorrection/HitProb_3_cluster_binning1m_EtaCorrection.png"%PlotPath)
    can10.SaveAs("%s/EtaCorrection/HitProb_4_cluster_binning1m_EtaCorrection.png"%PlotPath)
    can7bis.SaveAs("%s/EtaCorrection/HitProb_1_cluster_binning2m_EtaCorrection.png"%PlotPath)
    can8bis.SaveAs("%s/EtaCorrection/HitProb_2_cluster_binning2m_EtaCorrection.png"%PlotPath)
    can9bis.SaveAs("%s/EtaCorrection/HitProb_3_cluster_binning2m_EtaCorrection.png"%PlotPath)
    can10bis.SaveAs("%s/EtaCorrection/HitProb_4_cluster_binning2m_EtaCorrection.png"%PlotPath)
    can11.SaveAs("%s/EtaCorrection/relX_vs_relY_EtaCorrection.png"%PlotPath)
    can12.SaveAs("%s/EtaCorrection/HitProb_1_track_binning1m_EtaCorrection.png"%PlotPath)
    can13.SaveAs("%s/EtaCorrection/HitProb_2_track_binning1m_EtaCorrection.png"%PlotPath)
    can14.SaveAs("%s/EtaCorrection/HitProb_3_track_binning1m_EtaCorrection.png"%PlotPath)
    can15.SaveAs("%s/EtaCorrection/HitProb_4_track_binning1m_EtaCorrection.png"%PlotPath)
    can12bis.SaveAs("%s/EtaCorrection/HitProb_1_track_binning2m_EtaCorrection.png"%PlotPath)
    can13bis.SaveAs("%s/EtaCorrection/HitProb_2_track_binning2m_EtaCorrection.png"%PlotPath)
    can14bis.SaveAs("%s/EtaCorrection/HitProb_3_track_binning2m_EtaCorrection.png"%PlotPath)
    can15bis.SaveAs("%s/EtaCorrection/HitProb_4_track_binning2m_EtaCorrection.png"%PlotPath)    
    can16.SaveAs("%s/EtaCorrection/trackX_vs_trackY_plan3_EtaCorrection.png"%PlotPath)
    can17.SaveAs("%s/EtaCorrection/trackX_vs_trackY_plan0_EtaCorrection.png"%PlotPath)
    can18.SaveAs("%s/EtaCorrection/ClusterSizeX_EtaCorrection.png"%PlotPath)
    can19.SaveAs("%s/EtaCorrection/ClusterSizeY_EtaCorrection.png"%PlotPath)
    can20.SaveAs("%s/EtaCorrection/ClusterSize_EtaCorrection.png"%PlotPath)
    can21.SaveAs("%s/EtaCorrection/ClusterSizeXvsSizeY_EtaCorrection.png"%PlotPath)
    canEtaCorr.SaveAs("%s/EtaCorrection/Eta_EtaCorrection.png"%PlotPath)
    canEtaCorr2.SaveAs("%s/EtaCorrection/Eta_hist_EtaCorrection.png"%PlotPath)

 
# g1 = TF1("m1","gaus",-0.025,pitchX/sqrt(12))
# g2 = TF1("m2","gaus",0.025,pitchX/sqrt(12))
# 
# can_resX_cs_0 = TCanvas()
# resX_cs[0].Draw()
# r0 = resX_cs[0].Fit("gaus","","",-0.05,0.05) 
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
# can_resX_cs_2 = TCanvas()
# resX_cs[2].Draw()
# r2 = resX_cs[2].Fit(g1,"RS")
# r2bis = resX_cs[2].Fit(g2,"RS+")
# fitResult_resX_cs_2 = TPaveText(0.13,0.69,0.33,0.88,"NDC")
# fitResult_resX_cs_2.AddText("mean 1 : %f"%(r2.Parameter(1)))
# fitResult_resX_cs_2.AddText("sigma 1 : %f"%(r2.Parameter(2)))
# fitResult_resX_cs_2.AddLine(.0,.5,1.,.5)
# fitResult_resX_cs_2.AddText("mean 2 : %f"%(r2bis.Parameter(1)))
# fitResult_resX_cs_2.AddText("sigma 2 : %f"%(r2bis.Parameter(2)))
# fitResult_resX_cs_2.Draw("same")
# 
# can_resY_cs_0 = TCanvas()
# resY_cs[0].Draw()
# r0 = resY_cs[0].Fit("gaus","","",-0.05,0.05) 
# 
# can_resY_cs_1 = TCanvas()
# resY_cs[1].Draw()
# r1 = resY_cs[1].Fit(g1,"RS")
# r1bis = resY_cs[1].Fit(g2,"RS+")
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
#     can_resX_cs_0.SaveAs("%s/QWeighted/resX_cs_0_fit_QWeighted.png"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/QWeighted/resX_cs_1_fit_QWeighted.png"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/QWeighted/resX_cs_2_fit_QWeighted.png"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/QWeighted/resY_cs_0_fit_QWeighted.png"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/QWeighted/resY_cs_1_fit_QWeighted.png"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/QWeighted/resY_cs_2_fit_QWeighted.png"%PlotPath)
#  
# elif method_name == "DigitalCentroid" :
#     can_resX_cs_0.SaveAs("%s/DigitalCentroid/resX_cs_0_fit_DigitalCentroid.png"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/DigitalCentroid/resX_cs_1_fit_DigitalCentroid.png"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/DigitalCentroid/resX_cs_2_fit_DigitalCentroid.png"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/DigitalCentroid/resY_cs_0_fit_DigitalCentroid.png"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/DigitalCentroid/resY_cs_1_fit_DigitalCentroid.png"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/DigitalCentroid/resY_cs_2_fit_DigitalCentroid.png"%PlotPath)
#      
# elif method_name == "maxTOT" : 
#     can_resX_cs_0.SaveAs("%s/maxTOT/resX_cs_0_fit_maxTOT.png"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/maxTOT/resX_cs_1_fit_maxTOT.png"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/maxTOT/resX_cs_2_fit_maxTOT.png"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/maxTOT/resY_cs_0_fit_maxTOT.png"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/maxTOT/resY_cs_1_fit_maxTOT.png"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/maxTOT/resY_cs_2_fit_maxTOT.png"%PlotPath)
#     
# elif method_name == "EtaCorrection" : 
#     can_resX_cs_0.SaveAs("%s/EtaCorrection/resX_cs_0_fit_EtaCorrection.png"%PlotPath)
#     can_resX_cs_1.SaveAs("%s/EtaCorrection/resX_cs_1_fit_EtaCorrection.png"%PlotPath)
#     can_resX_cs_2.SaveAs("%s/EtaCorrection/resX_cs_2_fit_EtaCorrection.png"%PlotPath)
#     can_resY_cs_0.SaveAs("%s/EtaCorrection/resY_cs_0_fit_EtaCorrection.png"%PlotPath)
#     can_resY_cs_1.SaveAs("%s/EtaCorrection/resY_cs_1_fit_EtaCorrection.png"%PlotPath)
#     can_resY_cs_2.SaveAs("%s/EtaCorrection/resY_cs_2_fit_EtaCorrection.png"%PlotPath)
     
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
       
#aDataSet.DumpClusterTree("run131_uncalibrated_cluster.root")
#aDataSet_calib.DumpClusterTree("run131_calibrated_cluster.root")
