########################################################
# cmake file for building Marlin example Package
CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
########################################################

# project name
PROJECT( Eutelescope )

# project version
SET( ${PROJECT_NAME}_VERSION_MAJOR 0 )
SET( ${PROJECT_NAME}_VERSION_MINOR 8 )
SET( ${PROJECT_NAME}_VERSION_PATCH 0 )

# These switches activate/deactivate compiler switches such as the
# inclusion of debugging symbols and code optimizations. For actual
# data analysis we recommend setting CMAKE_BUILD_TYPE to "Release"
# while for developement "RelWithDebInfo" is best used. For actual
# debugging e.g. using gdb, please consider "Debug" which will turn
# off all (!) optimizations but will be "gdb-friendlier"
#SET(CMAKE_BUILD_TYPE Debug) # use for debugging with e.g. gdb: add. warnings, no optimizations, debug symbols
#SET(CMAKE_BUILD_TYPE RelWithDebInfo) # useful for normal development, runs faster but compilation takes longer: gcc optimizations (-O2) with debug symbols and add. warnings
SET(CMAKE_BUILD_TYPE Release) # for production: full gcc optimization (-O3), no debug symbols, no debug messages


### DEPENDENCIES ############################################################

FIND_PACKAGE( ILCUTIL COMPONENTS ILCSOFT_CMAKE_MODULES REQUIRED ILCTEST)

# load default settings from ILCSOFT_CMAKE_MODULES
INCLUDE( ilcsoft_default_settings )

# in order to find FindEUDAQ.cmake
LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )


FIND_PACKAGE( Marlin 1.0 REQUIRED )
FIND_PACKAGE( MarlinUtil 1.2 REQUIRED )
FIND_PACKAGE( GSL )
FIND_PACKAGE( AIDA )
FIND_PACKAGE( EUDAQ )
FIND_PACKAGE( ROOT COMPONENTS Minuit )
FIND_PACKAGE( LCCD  REQUIRED )               

FOREACH( pkg Marlin MarlinUtil GSL AIDA EUDAQ ROOT LCCD )
    IF( ${pkg}_FOUND )
        # include as "system" libraries: gcc will be less verbose w.r.t. warnings
        INCLUDE_DIRECTORIES(SYSTEM ${${pkg}_INCLUDE_DIRS} )
        LINK_LIBRARIES( ${${pkg}_LIBRARIES} )
        ADD_DEFINITIONS ( ${${pkg}_DEFINITIONS} )
    ELSE()
        MESSAGE( STATUS "${pkg} not found" )
    ENDIF()
ENDFOREACH()

### DOCUMENTATION ###########################################################

OPTION( INSTALL_DOC "Set to OFF to skip build/install Documentation" OFF )

IF( INSTALL_DOC )
    ADD_SUBDIRECTORY( ./doc )
ENDIF()



### LIBRARY #################################################################

# ------ add preprocessor flags ---------------------------------------------
IF( EUDAQ_FOUND )
    ADD_DEFINITIONS( "-DUSE_EUDAQ -DEUDAQ_PLATFORM=PF_LINUX -DEUDAQ_FUNC=__PRETTY_FUNCTION__" )
    GET_FILENAME_COMPONENT( EUDAQ_LIBRARY_FULL_PATH ${EUDAQ_EUDAQ_LIBRARY} REALPATH )
    INSTALL( PROGRAMS ${EUDAQ_LIBRARY_FULL_PATH} DESTINATION lib ) # PROGRAMS is like FILES but sets executable permissions
ELSE()
    MESSAGE( STATUS "WARNING: failed to configure Eutelescope with EUDAQ!!" )
ENDIF()

IF ( AIDA_FOUND)
  ADD_DEFINITIONS("-DUSE_AIDA")
ENDIF()

IF ( GSL_FOUND )
  ADD_DEFINITIONS("-DUSE_GSL")
ENDIF()

# these are needed anyway...
ADD_DEFINITIONS("-DUSE_MARLIN")
ADD_DEFINITIONS("-DUSE_GEAR")
ADD_DEFINITIONS("-DUSE_MARLINUTIL")
ADD_DEFINITIONS("-DUSE_CLHEP")
ADD_DEFINITIONS("-DUSE_CED")


# ---------------------------------------------------------------------------


# include directories
INCLUDE_DIRECTORIES( ./include )

#INSTALL_DIRECTORY( ./include DESTINATION . FILES_MATCHING PATTERN "*.h" )

# definitions to pass to the compiler
ADD_DEFINITIONS( "-Wall -ansi -pedantic -Wextra" )
ADD_DEFINITIONS( "-Wno-long-long" )

# debuging warnings and switches - only active if  CMAKE_BUILD_TYPE  is set to debug
SET(CMAKE_CXX_FLAGS_DEBUG "-g -fdiagnostics-show-option -Weffc++ -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wsign-promo -Wstrict-null-sentinel -Wswitch-default -Wundef" CACHE STRING "Debug options." FORCE )
# also useful: -Wshadow (however, GCC 4.1 uses this even for system libraries, causing many warnings from Marlin & co)
SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -fdiagnostics-show-option -Weffc++ -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wsign-promo -Wstrict-null-sentinel -Wswitch-default -Wundef" CACHE STRING "Debug options." FORCE )

# add library
SET( libname ${PROJECT_NAME} )
AUX_SOURCE_DIRECTORY( ./src library_sources )
ADD_SHARED_LIBRARY( ${libname} ${library_sources} )
INSTALL_SHARED_LIBRARY( ${libname} DESTINATION lib )

# used for alignment if Eutelescope was build with ROOT support
IF( ROOT_FOUND AND ROOT_MINUIT_FOUND )
    TARGET_LINK_LIBRARIES( ${libname} ${ROOT_MINUIT_LIBRARY} )
ENDIF()

MACRO( ADD_EUTELESCOPE_TOOL _name )
    ADD_EXECUTABLE( ${_name} src/exec/${_name}.cxx )
    TARGET_LINK_LIBRARIES( ${_name} ${libname} )
    INSTALL( TARGETS ${_name} DESTINATION bin )
ENDMACRO()

ADD_EUTELESCOPE_TOOL( pede2lcio )
ADD_EUTELESCOPE_TOOL( pedestalmerge )

# electric fence
#FIND_LIBRARY(EFENCE_LIBRARY
#    NAMES efence
#    DOC "The electric fence library"
#    PATHS
#        /usr/lib
#        /usr/local/lib
#        /usr/efence/lib
#        /usr/share/efence/lib
#    )
#IF(EFENCE_LIBRARY)
#  MESSAGE("Electric Fence library was found and will be linked against ${PROJECT_NAME}")
#  target_link_libraries(${libname} ${EFENCE_LIBRARY})
#ENDIF()

# display some variables and write them to cache
DISPLAY_STD_VARIABLES()


#  _            _       
# | |_ ___  ___| |_ ___ 
# | __/ _ \/ __| __/ __|
# | ||  __/\__ \ |_\__ \
#  \__\___||___/\__|___/
#=============================================================================                      
# EUTelescope uses the CMake/CTest framework for daily automated,
#data-driven tests to constantly verify the validity of the output. The
#basis for the tests are the examples provided with the software
#together with a real data sample and the expected output in form of
#root files.
#
#If you are a user of EUTelescope and you have already taken data and
#performed you analysis, we would be very interested in obtaining a
#data sample with the corresponding analysis results including the
#EUTelescope configuration used so that we can include your analysis in
#the regular testing. This guarantees that your analysis will be well
#supported in future releases of EUTelescope and it might serve as a
#good starting point for others.
#
#The test can also be used by any developer who wishes to verify
#changes made to the EUTelescope code. For a short how-to see
#README.tests; for more detailed information see the CMake manual or
#web page (http://www.cmake.org/Wiki/CMake/Testing_With_CTest).

ENABLE_TESTING()
INCLUDE(CTest)


# ----------------------------------------------------------------------------
# TEST IF ENVIRONMENT IS OK FOR RUNNING TESTS
# ----------------------------------------------------------------------------

IF( NOT DEFINED ENV{EUTELESCOPE} OR NOT DEFINED ENV{MARLIN})
      MESSAGE( "trying to load build and run environment for EUTelescope" )

  IF( DEFINED ENV{ILCSOFT})
        EXECUTE_PROCESS( COMMAND sh -c " [ -f $ILCSOFT/Eutelscope/HEAD/build_env.sh ] && . $ILCSOFT/Eutelescope/HEAD/build_env.sh" )

	IF( NOT DEFINED ENV{EUTELESCOPE} OR NOT DEFINED ENV{MARLIN} )
        # try to load build_env.sh environment - if running 'make' from 'build' directory, it should be located in '../'
        EXECUTE_PROCESS( COMMAND sh -c " [ -f '../build_env.sh' ] && . ../build_env.sh" )
	IF( DEFINED ENV{EUTELESCOPE} AND DEFINED ENV{MARLIN} )
	    MESSAGE( "EUTELESCOPE environment automatically loaded from ../build_env.sh" )
	ENDIF()
     ENDIF()
  ENDIF()

ENDIF()

# ----------------------------------------------------------------------------
# ACTUAL TESTS BEGIN HERE
# ----------------------------------------------------------------------------

# check environment
IF( DEFINED ENV{EUTELESCOPE} AND DEFINED ENV{MARLIN})

# cppcheck should be a useful check for developers to test their code against
# if cppcheck is installed, offer static code analysis test
find_program(CPPCHECK cppcheck /scratch/local/bin) # hint at path /scratch/... used on EUTelTesting server; will also parse $PATH
if(CPPCHECK)
  MESSAGE("cppcheck was found and will be made available as test.")
  ADD_TEST( TestCppcheckSources sh -c "${CPPCHECK} --enable=all -I $ENV{EUTELESCOPE}/include -q -rp=$ENV{EUTELESCOPE} --std=c99 --std=posix $ENV{EUTELESCOPE}/src" )
  SET_TESTS_PROPERTIES (TestCppcheckSources PROPERTIES
    FAIL_REGULAR_EXPRESSION "(error)"
    )
#else()
#  MESSAGE("cppcheck was not found - omitting cppcheck static code analysis test.")
endif()

# Developers: please consider using these tests to verify your code!
# to obtain the necessary data files, please check the corresponding
# README files in the example folders and/or contact the EUTelescope
# software coordinators.
#  INCLUDE(jobsub/examples/datura-alone/testing.cmake)
#  INCLUDE(pysub/examples/datura-alone/testing.cmake)
#  INCLUDE(pysub/examples/anemone-2FEI4/testing.cmake)
#  configure_file (
#	       ./CTestCustom.cmake.in   # set custom settings (e.g. tests to be skipped for valgrind)
#	       ${PROJECT_BINARY_DIR}/CTestCustom.cmake
#	       )

ELSE()
    MESSAGE( "EUTELESCOPE environment variable not defined, cannot run tests - please run 'source build_env.sh' in the EUTel root directory first." )
ENDIF()

