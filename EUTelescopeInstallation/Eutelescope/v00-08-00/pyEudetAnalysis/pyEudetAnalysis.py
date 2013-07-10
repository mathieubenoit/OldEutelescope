from ROOT import *
import ROOT
from ROOT import gStyle
from math import fsum
from array import array 
from EudetData import *
from ToolBox import *

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
#     h->SetTitle(0)
    h.SetTitleFont(42, "XYZ")



gStyle.SetOptStat("nemruoi")
gStyle.SetOptFit(1111)

method_name = "QWeighted"
# method_name = "DigitalCentroid"
# method_name = "maxTOT"


#aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000062.root",500.0)
aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131.root",500.0)

# Filter Hot Pixels
histo_hot,histo_freq = aDataSet.FilterHotPixel(0.005,25000)

#canhot = TCanvas()
#histo_hot.Draw("colz")

#canfreq = TCanvas()
#canfreq.SetLogx()
#canfreq.SetLogy()
#histo_freq.Draw("")

for i in range(aDataSet.p_nEntries) : 
#for i in range(10000) : 

    aDataSet.ClusterEvent(i,method_name)
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
    
#resr,rest = PerformAlignement(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]])

#decomment to perform the alignment in 3 steps
# resr,rest = Perform3StepAlignment(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]],aDataSet.p_nEntries,20)
# ApplyAlignment(aDataSet,rest,resr)

ApplyAlignment(aDataSet,[-0.0154687500 , -0.0205156250 , 0.],[0.0000000000, 0.0000000000, 0.0719150199])

for i in range(aDataSet.p_nEntries) :
#for i in range(10000) : 
 
        aDataSet.ComputeResiduals(i)
        
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

resX = TH1D("resX","Unbiased residual X",600,-0.150,0.150)
resY = TH1D("resY","Unbiased residual Y",600,-0.150,0.150)
resX.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
resX.GetYaxis().SetTitle("Number of hits")
resY.GetXaxis().SetTitle("Y_{track} - Y_{Timepix} (mm)")
resY.GetYaxis().SetTitle("Number of hits")

HitProb_1 = TH2D("HitProb_1","Hit probability, cluster size 1",30,0.,0.060,30,0.,0.060)
HitProb_1.GetXaxis().SetRangeUser(0.,0.055)
HitProb_1.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
HitProb_1.GetYaxis().SetRangeUser(0.,0.055)
HitProb_1.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")

HitProb_2 = TH2D("HitProb_2","Hit probability, cluster size 2",30,0.,0.060,30,0.,0.060)
HitProb_2.GetXaxis().SetRangeUser(0.,0.055)
HitProb_2.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
HitProb_2.GetYaxis().SetRangeUser(0.,0.055)
HitProb_2.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")

HitProb_3 = TH2D("HitProb_3","Hit probability, cluster size 3",30,0.,0.060,30,0.,0.060)
HitProb_3.GetXaxis().SetRangeUser(0.,0.055)
HitProb_3.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
HitProb_3.GetYaxis().SetRangeUser(0.,0.055)
HitProb_3.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")

HitProb_4 = TH2D("HitProb_4","Hit probability, cluster size 4",30,0.,0.060,30,0.,0.060)
HitProb_4.GetXaxis().SetRangeUser(0.,0.055)
HitProb_4.GetXaxis().SetTitle("Cluster X position within pixel [mm]")
HitProb_4.GetYaxis().SetRangeUser(0.,0.055)
HitProb_4.GetYaxis().SetTitle("Cluster Y position within pixel [mm]")

h1_style(HitProb_1)
h1_style(HitProb_2)
h1_style(HitProb_3)
h1_style(HitProb_4)

#resX_calib = TH1D("resX_calib","Unbiased residual X, calibrated",500,-0.150,0.150)
#resY_calib = TH1D("resY_calib","Unbiased residual Y, calibrated",500,-0.150,0.150)

resX_cs = []
resY_cs = []
n_cs = 3

for i in range(1,n_cs+1) : 
	tmpx = TH1D("resX_%i"%i,"Unbiased residual X, cluster size X = %i"%i,300,-0.150,0.150)
	tmpy = TH1D("resY_%i"%i,"Unbiased residual Y, cluster size Y = %i"%i,300,-0.150,0.150)
	tmpx.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
	tmpx.GetYaxis().SetTitle("Number of hits")
	tmpy.GetXaxis().SetTitle("X_{track} - X_{Timepix} (mm)")
	tmpy.GetYaxis().SetTitle("Number of hits")
	tmpx.SetLineColor(i)
	tmpy.SetLineColor(i)
	resX_cs.append(tmpx)
	resY_cs.append(tmpy)
	
	
for clusters in aDataSet.AllClusters : 
    for cluster in clusters : 
        allTOT.Fill(cluster.totalTOT) 
        if(fabs(cluster.resX)<0.150 and cluster.resY<0.150) : 
            resX.Fill(cluster.resX) 
            resY.Fill(cluster.resY)
        if(cluster.size==1) : 
            HitProb_1.Fill((cluster.relX)%pitchX,(cluster.relY)%pitchY) 
        elif(cluster.size==2) : 
            HitProb_2.Fill((cluster.relX)%pitchX,(cluster.relY)%pitchY)  
        elif(cluster.size==3) : 
            HitProb_3.Fill((cluster.relX)%pitchX,(cluster.relY)%pitchY) 
        elif(cluster.size==4) : 
            HitProb_4.Fill((cluster.relX)%pitchX,(cluster.relY)%pitchY)  
	for i in range(1,n_cs+1) :
        	if(fabs(cluster.resX)<0.150 and cluster.resY<0.150 and cluster.sizeX==i) : 
        	    resX_cs[i-1].Fill(cluster.resX) 
        	if(fabs(cluster.resX)<0.150 and cluster.resY<0.150 and cluster.sizeY==i) : 
		    resY_cs[i-1].Fill(cluster.resY)	     	
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
TOT4.DrawNormalized("same")


can3 = TCanvas()
resX.Draw("")
resX.Fit("gaus","R","",-0.03,0.03)

#resX_calib.DrawNormalized("same")

can4 = TCanvas()
resY.Draw("")
resY.Fit("gaus","R","",-0.03,0.03)
#resY_calib.DrawNormalized("same")

can5 = TCanvas()

for i in range(1,n_cs+1) : 
	if i==1 : 
		resX_cs[i-1].DrawNormalized("")
	else : 
		resX_cs[i-1].DrawNormalized("same")

can6 = TCanvas()

for i in range(1,n_cs+1) : 
	if i==1 : 
		resY_cs[i-1].DrawNormalized("")
	else : 
		resY_cs[i-1].DrawNormalized("same")
		

can7 = TCanvas()
can7.cd()
HitProb_1.Draw("colz")

can8 = TCanvas()
can8.cd()
HitProb_2.Draw("colz")

can9 = TCanvas()
can9.cd()
HitProb_3.Draw("colz")

can10 = TCanvas()
can10.cd()
HitProb_4.Draw("colz")


if method_name == "QWeighted" :
    cancorx.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/corx.png")
    cancory.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/cory.png")
    can1.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/allTOT.png")
    can2.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/TOTnormalized.png")
    can3.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/resX.png")
    can4.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/resY.png")
    can5.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/resX_cs.png")
    can6.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/resY_cs.png")
    can7.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/HitProb_1.png")
    can8.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/HitProb_2.png")
    can9.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/HitProb_3.png")
    can10.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/QWeighted/HitProb_4.png")

elif method_name == "DigitalCentroid" :
    cancorx.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/corx.png")
    cancory.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/cory.png")
    can1.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/allTOT.png")
    can2.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/TOTnormalized.png")
    can3.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/resX.png")
    can4.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/resY.png")
    can5.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/resX_cs.png")
    can6.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/resY_cs.png")
    can7.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/HitProb_1.png")
    can8.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/HitProb_2.png")
    can9.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/HitProb_3.png")
    can10.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/DigitalCentroid/HitProb_4.png")
    
elif method_name == "maxTOT" : 
    cancorx.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/corx.png")
    cancory.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/cory.png")
    can1.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/allTOT.png")
    can2.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/TOTnormalized.png")
    can3.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/resX.png")
    can4.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/resY.png")
    can5.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/resX_cs.png")
    can6.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/resY_cs.png")
    can7.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/HitProb_1.png")
    can8.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/HitProb_2.png")
    can9.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/HitProb_3.png")
    can10.SaveAs("/afs/cern.ch/work/a/apequegn/public/DESY_TB_DATA_02_07-06-2013_results/pyEudetAnalysisPlots/maxTOT/HitProb_4.png")
       
#aDataSet.DumpClusterTree("run131_uncalibrated_cluster.root")
#aDataSet_calib.DumpClusterTree("run131_calibrated_cluster.root")
