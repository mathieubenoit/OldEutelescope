/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#include "stdafx.h"
#include "dacscanapihelper.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

PluginFuncType DacScanApiHelper::dacScanStart = 0;
PluginFuncType DacScanApiHelper::dacScanSetFileOutput = 0;

INTPTR DacScanApiHelper::dacScanStartPar = 0;
INTPTR DacScanApiHelper::dacScanSetFileOutputPar = 0;

extern const FuncTableType *mgr;

#define DACSCAN_NAME                "thsequalization"
#define DACSCAN_FSTARTSCAN          "DacScanStart"
#define DACSCAN_FSETFILEOUTPUT      "DacScanSetFileOutput"


int DacScanApiHelper::Initialize()
{
    ExtFunctionInfo efi;
    int failCount = 0;
    if (mgr->getFuncItem(DACSCAN_NAME, DACSCAN_FSTARTSCAN, &efi) == 0)
    {
        dacScanStart = efi.func;
        dacScanStartPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(DACSCAN_NAME, DACSCAN_FSETFILEOUTPUT, &efi) == 0)
    {
        dacScanSetFileOutput = efi.func;
        dacScanSetFileOutputPar = efi.userData;
    }
    else
        failCount++;
    return failCount;
}

int DacScanApiHelper::DacScanStart(DEVID devID)
{
    if (dacScanStart)
        return dacScanStart(dacScanStartPar, (byte *)&devID, 0);
    else
        return -1;
}

int DacScanApiHelper::DacScanSetFileOutput(DEVID devID, const char *fileName, u32 flags)
{
    if (!dacScanSetFileOutput)
        return -1;
    struct InPars
    {
        DEVID devID;
        const char *fileName;
        u32 flags;
    } in = {devID, fileName, flags};
    return dacScanSetFileOutput(dacScanSetFileOutputPar, (byte *)&in, 0);
}
