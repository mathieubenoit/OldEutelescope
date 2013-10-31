hostname
date
uname -a
id
env | grep RFIO
env | grep STAGE
env | grep PATH
rpm -qa| grep castor
which xrdcp
which rfcp
which nsls
which stager_get
castor -v
echo $CNS_HOST
 
# switch on debugging (to be used when checking the libraries being called)
# ksh / zsh / bash syntax
export RFIO_TRACE=3
export STAGER_TRACE=3
# OR tcsh / csh syntax
setenv RFIO_TRACE 3
setenv STAGER_TRACE 3
 
# check the libraries used (note that occasionally experiments have "special" versions)
ldd /usr/bin/rfcp

