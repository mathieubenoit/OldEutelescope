/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#include "stdafx.h"
#include "depscanapihelper.h"
#include <cassert>

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

PluginFuncType DepScanApiHelper::depScanShowWnd = 0;
PluginFuncType DepScanApiHelper::depScanCloseWnd = 0;
PluginFuncType DepScanApiHelper::depScanSetIniFile = 0;
PluginFuncType DepScanApiHelper::depScanHideOnClose = 0;
PluginFuncType DepScanApiHelper::depScanStart = 0;
PluginFuncType DepScanApiHelper::depScanAbort = 0;
PluginFuncType DepScanApiHelper::depScanSaveImage = 0;
PluginFuncType DepScanApiHelper::depScanGetLastErr = 0;
PluginFuncType DepScanApiHelper::depScanSetCbFinished = 0;
PluginFuncType DepScanApiHelper::depScanSetCbError = 0;
PluginFuncType DepScanApiHelper::depScanSetCbClose = 0;

INTPTR DepScanApiHelper::depScanShowWndPar = 0;
INTPTR DepScanApiHelper::depScanCloseWndPar = 0;
INTPTR DepScanApiHelper::depScanSetIniFilePar = 0;
INTPTR DepScanApiHelper::depScanHideOnClosePar = 0;
INTPTR DepScanApiHelper::depScanStartPar = 0;
INTPTR DepScanApiHelper::depScanAbortPar = 0;
INTPTR DepScanApiHelper::depScanSaveImagePar = 0;
INTPTR DepScanApiHelper::depScanGetLastErrPar = 0;
INTPTR DepScanApiHelper::depScanSetCbFinishedPar = 0;
INTPTR DepScanApiHelper::depScanSetCbErrorPar = 0;
INTPTR DepScanApiHelper::depScanSetCbClosePar = 0;

extern const FuncTableType *mgr;

#define DEPSCAN_NAME                "thsequalization"

#define STRINGER(x) #x
#define GETFUNCITEM(name) \
    if (mgr->getFuncItem(DEPSCAN_NAME, STRINGER(DepScan##name), &efi) == 0)\
    {\
        depScan##name = efi.func;\
        depScan##name##Par = efi.userData;\
    }\
    else\
        failCount++;

int DepScanApiHelper::Initialize()
{
    ExtFunctionInfo efi;
    int failCount = 0;
    GETFUNCITEM(ShowWnd);
    GETFUNCITEM(CloseWnd);
    GETFUNCITEM(SetIniFile);
    GETFUNCITEM(HideOnClose);
    GETFUNCITEM(Start);
    GETFUNCITEM(Abort);
    GETFUNCITEM(SaveImage);
    GETFUNCITEM(GetLastErr);
    GETFUNCITEM(SetCbFinished);
    GETFUNCITEM(SetCbError);
    GETFUNCITEM(SetCbClose);
    assert(failCount == 0);
    return failCount;
}

int DepScanApiHelper::ShowWnd(DEVID devID, BOOL show, BOOL enableUI)
{
    if (depScanShowWnd)
    {
        struct InPars
        {
            DEVID devID;
            BOOL show;
            BOOL enableUI;
        };
        InPars inPars = {devID, show, enableUI};
        return depScanShowWnd(0, (byte *) &inPars, (byte *) &inPars);
    }
    return -1;
}

int DepScanApiHelper::CloseWnd(DEVID devID)
{
    if (depScanCloseWnd)
        return depScanCloseWnd(depScanCloseWndPar, (byte *) &devID, 0);
    return -1;
}

int DepScanApiHelper::SetIniFile(DEVID devID, const char *iniFileName)
{
    if (depScanSetIniFile)
    {
        struct InPars 
        {
            DEVID devID;
            const char *iniFileName;
        };
        InPars inPars = {devID, iniFileName};
        return depScanSetIniFile(depScanSetIniFilePar, (byte *) &inPars, 0);
    }
    return -1;
}

int DepScanApiHelper::HideOnClose(DEVID devID, BOOL hideOnClose)
{
    if (depScanHideOnClose)
    {
        struct InPars 
        {
            DEVID devID;
            BOOL hideOnClose;
        };
        InPars inPars = {devID, hideOnClose};
        return depScanHideOnClose(depScanHideOnClosePar, (byte *) &inPars, 0);
    }
    return -1;
}

int DepScanApiHelper::Start(DEVID devID, u32 dacsMask, BOOL setDefVals, int dacFrom, int dacTo, int dacStep, const char *outputFileName, BOOL appendRange)
{
    if (depScanStart)
    {
        struct InPars
        {
            DEVID devID;
            u32 dacsMask;
            BOOL setDefVals;
            int dacFrom;
            int dacTo;
            int dacStep;
            const char *outputFileName;
            BOOL appendRange;
        };
        InPars inPars = {devID, dacsMask, setDefVals, dacFrom, dacTo, dacStep, outputFileName, appendRange};
        return depScanStart(depScanStartPar, (byte *) &inPars, (byte *) &inPars);
    }
    return -1;    
}

int DepScanApiHelper::Abort(DEVID devID)
{
    if (depScanAbort)
        return depScanAbort(depScanAbortPar, (byte *) &devID, 0);
    return -1;
}

int DepScanApiHelper::SaveImage(DEVID devID, const char *fileName)
{
    if (depScanSaveImage)
    {
        struct InPars
        {
            DEVID devID;
            const char *fileName;
        };
        InPars inPars = {devID, fileName};
        return depScanSaveImage(depScanSaveImagePar, (byte *) &inPars, 0);
    }
    return -1;
}

int DepScanApiHelper::GetLastErr(DEVID devID, char errorMsg[MPX_MAX_MSGLENGTH])
{
    if (depScanGetLastErr)
        return depScanGetLastErr(depScanGetLastErrPar, (byte *) &devID, (byte *) errorMsg);
    return -1;
}

int DepScanApiHelper::SetCbFinished(CallbackFuncType cb)
{
    if (depScanSetCbFinished)
        return depScanSetCbFinished(depScanSetCbFinishedPar, (byte *) &cb, 0);
    return -1;
}

int DepScanApiHelper::SetCbError(CallbackFuncType cb)
{
    if (depScanSetCbError)
        return depScanSetCbError(depScanSetCbErrorPar, (byte *) &cb, 0);
    return -1;
}

int DepScanApiHelper::SetCbClose(CallbackFuncType cb)
{
    if (depScanSetCbClose)
        return depScanSetCbClose(depScanSetCbClosePar, (byte *) &cb, 0);
    return -1;
}

