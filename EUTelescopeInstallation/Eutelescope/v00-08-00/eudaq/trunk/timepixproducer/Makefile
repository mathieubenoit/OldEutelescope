EXTERNAL_DEFS += EUDAQ_FUNC=__PRETTY_FUNCTION__ EUDAQ_PLATFORM=PF_$(PLATFORM)
EXTERNAL_LIBS += eudaq dl
EXTERNAL_LIBDIRS += ../bin
EXTERNAL_INCS += ../main/include
EXTERNAL_INCS += ./_other_/headers

include ../Makefile.common

PIXELMAN_INSTALL:=/afs/cern.ch/user/m/mbenoit/TestBeam_Analysis/ILCsoft/EUTelescopeInstallation/Eutelescope/v00-08-00/eudaq/trunk/timepixproducer
PIXELMAN_HWLIBS:=$(PIXELMAN_INSTALL)/hwlibs

BIN = ${PWD}

CFLAGS += -isystem ./_other_/headers  -m32 -c -lstdc++ -ldl -L$(PIXELMAN_INSTALL) -lMpxManager -lMpxCtrl -L$(PIXELMAN_HWLIBS) -lMpxHwUSB2 -lMpxHwUSB
LDFLAGS += -L$(PIXELMAN_INSTALL) -lMpxManager -lMpxCtrl -L$(PIXELMAN_HWLIBS) -lMpxHwUSB2 -lMpxHwUSB

ifeq ($(PLATFORM),WIN32)
EXTERNAL_LIBS += Ws2_32
endif

default: exe

exe: $(EXE_FILES)

$(EXE_FILES): $(OBJ_FILES)

lib: $(TARGET)

all: exe

.PHONY: exe lib all default
