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
