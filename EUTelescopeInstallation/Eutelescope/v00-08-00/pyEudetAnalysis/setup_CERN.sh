export PATH="/afs/cern.ch/sw/lcg/external/Python/2.6.5/x86_64-slc5-gcc43-opt/bin:$PATH"
export LD_LIBRARY_PATH="/afs/cern.ch/sw/lcg/external/Python/2.6.5/x86_64-slc5-gcc43-opt/lib:$LD_LIBRARY_PATH"

#export PYTHONPATH="/afs/cern.ch/sw/lcg/external/pyanalysis/1.3_python2.6/x86_64-slc5-gcc43-opt/lib/python2.6/site-packages:$PYTHONPATH"
export PYTHONPATH="/afs/cern.ch/eng/clic/software/Pixel_TestBeam_Software/pytools/numpy/lib/python2.6/site-packages:$PYTHONPATH"
export PYTHONPATH="/afs/cern.ch/eng/clic/software/Pixel_TestBeam_Software/pytools/scipy/lib/python2.6/site-packages:$PYTHONPATH"
export PYTHONPATH="/afs/cern.ch/eng/clic/software/Pixel_TestBeam_Software/pytools/sympy/lib/python2.6/site-packages:$PYTHONPATH"
export PYTHONPATH="/afs/cern.ch/eng/clic/software/Pixel_TestBeam_Software/pytools/matplotlib/lib/python2.6/site-packages:$PYTHONPATH"

#BLAS and LAPACK
export LD_LIBRARY_PATH=/afs/cern.ch/sw/lcg/external/blas/20110419/x86_64-slc5-gcc43-opt/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/afs/cern.ch/sw/lcg/external/lapack/3.4.0/x86_64-slc5-gcc43-opt/lib:$LD_LIBRARY_PATH

. /afs/cern.ch/sw/lcg/external/gcc/4.3.2/x86_64-slc5/setup.sh
. /afs/cern.ch/sw/lcg/app/releases/ROOT/5.33.02/x86_64-slc5-gcc43-opt/root/bin/thisroot.sh
