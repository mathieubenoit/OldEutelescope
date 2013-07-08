from ROOT import *
import ROOT
from ROOT import gStyle
from math import fsum
from array import array 
from EudetData import *
from ToolBox import *

gStyle.SetOptStat("nemruoi")


#aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000062.root",500.0)
aDataSet = EudetData("/VertexScratch/TB_Data/DESY_TB_DATA_02_07-06-2013_results/histo/tbtrackrun000131.root",500.0)


histo_hot,histo_freq = aDataSet.FilterHotPixel(0.005,25000)

#canhot = TCanvas()
#histo_hot.Draw("colz")

#canfreq = TCanvas()
#canfreq.SetLogx()
#canfreq.SetLogy()
#histo_freq.Draw("")

for i in range(aDataSet.p_nEntries) : 
#for i in range(10000) : 


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
    
#resr,rest = PerformAlignement(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]])
resr,rest = Perform3StepAlignment(aDataSet,[[0,360],[0,360],[0,360],[-0.5,0.5],[-0.5,0.5]],aDataSet.p_nEntries,20)
ApplyAlignment(aDataSet,rest,resr)
#ApplyAlignment(aDataSet,[-0.0154687500 , -0.0205156250 , 0.],[0.0000000000, 0.0000000000, 0.0719150199])

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
		
		
		
#aDataSet.DumpClusterTree("run131_uncalibrated_cluster.root")
#aDataSet_calib.DumpClusterTree("run131_calibrated_cluster.root")
