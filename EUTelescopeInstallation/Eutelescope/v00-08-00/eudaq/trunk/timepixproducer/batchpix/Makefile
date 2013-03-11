# if not defined in the env take PWD
ifndef PIXELMAN_INSTALL
	PIXELMAN_INSTALL:=$(PWD)
endif
PIXELMAN_HWLIBS:=$(PIXELMAN_INSTALL)/hwlibs


all:	batchpixel batchpixel_ramp_k2410 batchpixel_EUDET	
	@echo done

batchpixel:	batchpixel.o
	g++ batchpixel.o -m32 -L$(PIXELMAN_INSTALL) -lMpxManager -lMpxCtrl -L$(PIXELMAN_HWLIBS) -lMpxHwUSB2 -lMpxHwUSB -ldl -o batchpixel.exe
	cp batchpixel.exe ../

batchpixel.o:	batchpixel.cpp
	g++ -Wall -m32 -g3 -c -I$(PIXELMAN_INSTALL)/_other_/headers batchpixel.cpp

batchpixel_EUDET:	batchpixel_EUDET.o
	g++ batchpixel_EUDET.o -m32    -L$(PIXELMAN_INSTALL) -lMpxManager -lMpxCtrl -L$(PIXELMAN_HWLIBS) -lMpxHwUSB2 -lMpxHwUSB -ldl -lstdc++ -o batchpixel_EUDET.exe 
	cp batchpixel_EUDET.exe ../

batchpixel_EUDET.o:	batchpixel_EUDET.cpp
	g++ -Wall -m32   -c   -I$(PIXELMAN_INSTALL)/_other_/headers batchpixel_EUDET.cpp


batchpixel_ramp_k2410:	batchpixel_ramp_k2410.o
	g++ batchpixel_ramp_k2410.o -m32 -L $(PIXELMAN_INSTALL) -lMpxManager -lMpxCtrl -L$(PIXELMAN_HWLIBS) -lMpxHwUSB2 -lMpxHwUSB -ldl -o batchpixel_ramp_k2410.exe
	cp batchpixel_ramp_k2410.exe ../

batchpixel_ramp_k2410.o:	
	g++ -m32 -Wall  -c -I$(PIXELMAN_INSTALL)/_other_/headers batchpixel_ramp_k2410.cpp

clean:
	rm -f batchpixel.o batchpixel_ramp_k2410.o batchpixel_ramp_k2410.exe batchpixel.exe
