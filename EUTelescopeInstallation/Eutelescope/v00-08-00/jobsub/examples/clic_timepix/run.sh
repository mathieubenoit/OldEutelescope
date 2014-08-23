#!/bin/sh

first="2306"
last="2325"
RUNLIST=
DRY=

for i in `seq $first $last`; do

 #jobsub.py $DRY -c configDecember2013_EOS.cfg  converter  $i
 #jobsub.py  $DRY -c configDecember2013_EOS.cfg  clusearch $i
 #jobsub.py $DRY -c configDecember2013_EOS.cfg  hitmaker   $i
 #jobsub.py $DRY -c configDecember2013_EOS.cfg  align      $i
 jobsub.py $DRY -c configDecember2013_EOS.cfg fitter $i
done


