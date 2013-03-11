/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once
#include "mpxpluginmgrapi.h"

class DacScanApiHelper
{
public:
    static int Initialize();

    static int DacScanStart(DEVID devID);
    static int DacScanSetFileOutput(DEVID devID, const char *fileName, u32 flags);

private:
    static PluginFuncType dacScanStart;
    static PluginFuncType dacScanSetFileOutput;

    static INTPTR dacScanStartPar;
    static INTPTR dacScanSetFileOutputPar;
};
