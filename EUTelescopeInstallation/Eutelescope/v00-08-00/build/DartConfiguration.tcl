# This file is configured by CMake automatically as DartConfiguration.tcl
# If you choose not to use CMake, this file may be hand configured, by
# filling in the required variables.


# Configuration directories and files
SourceDirectory: /afs/cern.ch/user/m/mbenoit/TestBeam_Analysis/ILCsoft/EUTelescopeInstallation/Eutelescope/v00-08-00
BuildDirectory: /afs/cern.ch/user/m/mbenoit/TestBeam_Analysis/ILCsoft/EUTelescopeInstallation/Eutelescope/v00-08-00/build

# Where to place the cost data store
CostDataFile: 

# Site is something like machine.domain, i.e. pragmatic.crd
Site: lxplus407.cern.ch

# Build name is osname-revision-compiler, i.e. Linux-2.4.2-2smp-c++
BuildName: Linux-g++

# Submission information
IsCDash: TRUE
CDashVersion: 
QueryCDashVersion: 
DropSite: aidasoft.desy.de
DropLocation: /CDash/submit.php?project=EuTelescope
DropSiteUser: 
DropSitePassword: 
DropSiteMode: 
DropMethod: http
TriggerSite: 
ScpCommand: /usr/bin/scp

# Dashboard start time
NightlyStartTime: 02:00:00 UTC

# Commands for the build/test/submit cycle
ConfigureCommand: "/afs/cern.ch/sw/lcg/external/CMake/2.8.6/x86_64-slc5-gcc43-opt/bin/cmake" "/afs/cern.ch/user/m/mbenoit/TestBeam_Analysis/ILCsoft/EUTelescopeInstallation/Eutelescope/v00-08-00"
MakeCommand: /usr/bin/gmake -i
DefaultCTestConfigurationType: Release

# CVS options
# Default is "-d -P -A"
CVSCommand: /usr/bin/cvs
CVSUpdateOptions: -d -A -P

# Subversion options
SVNCommand: /usr/bin/svn
SVNUpdateOptions: 

# Git options
GITCommand: /usr/bin/git
GITUpdateOptions: 
GITUpdateCustom: 

# Generic update command
UpdateCommand: /usr/bin/svn
UpdateOptions: 
UpdateType: svn

# Compiler info
Compiler: /usr/bin/g++

# Dynamic analysis and coverage
PurifyCommand: 
ValgrindCommand: 
ValgrindCommandOptions: 
MemoryCheckCommand: /usr/bin/valgrind
MemoryCheckCommandOptions: 
MemoryCheckSuppressionFile: 
CoverageCommand: /usr/bin/gcov

# Cluster commands
SlurmBatchCommand: SLURM_SBATCH_COMMAND-NOTFOUND
SlurmRunCommand: SLURM_SRUN_COMMAND-NOTFOUND

# Testing options
# TimeOut is the amount of time in seconds to wait for processes
# to complete during testing.  After TimeOut seconds, the
# process will be summarily terminated.
# Currently set to 25 minutes
TimeOut: 1500

UseLaunchers: 
CurlOptions: 
# warning, if you add new options here that have to do with submit,
# you have to update cmCTestSubmitCommand.cxx

# For CTest submissions that timeout, these options
# specify behavior for retrying the submission
CTestSubmitRetryDelay: 5
CTestSubmitRetryCount: 3
