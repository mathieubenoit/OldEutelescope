/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once
#include "mpxpluginmgrapi.h"

class DepScanApiHelper
{
public:
    static int Initialize();
    
    static int ShowWnd(DEVID devID, BOOL show, BOOL enableUI);
    static int CloseWnd(DEVID devID);
    static int SetIniFile(DEVID devID, const char *iniFileName);
    static int HideOnClose(DEVID devID, BOOL hideOnClose);
    static int Start(DEVID devID, u32 dacsMask, BOOL setDefVals, int dacFrom, int dacTo, int dacStep, const char *outputFileName, BOOL appendRange);
    static int Abort(DEVID devID);
    static int SaveImage(DEVID devID, const char *fileName);
    static int GetLastErr(DEVID devID, char errorMsg[MPX_MAX_MSGLENGTH]);
    static int SetCbFinished(CallbackFuncType cb);
    static int SetCbError(CallbackFuncType cb);
    static int SetCbClose(CallbackFuncType cb);

private:
    static PluginFuncType depScanShowWnd;
    static PluginFuncType depScanCloseWnd;
    static PluginFuncType depScanSetIniFile;
    static PluginFuncType depScanHideOnClose;
    static PluginFuncType depScanStart;
    static PluginFuncType depScanAbort;
    static PluginFuncType depScanSaveImage;
    static PluginFuncType depScanGetLastErr;
    static PluginFuncType depScanSetCbFinished;
    static PluginFuncType depScanSetCbError;
    static PluginFuncType depScanSetCbClose;

    static INTPTR depScanShowWndPar;
    static INTPTR depScanCloseWndPar;
    static INTPTR depScanSetIniFilePar;
    static INTPTR depScanHideOnClosePar;
    static INTPTR depScanStartPar;
    static INTPTR depScanAbortPar;
    static INTPTR depScanSaveImagePar;
    static INTPTR depScanGetLastErrPar;
    static INTPTR depScanSetCbFinishedPar;
    static INTPTR depScanSetCbErrorPar;
    static INTPTR depScanSetCbClosePar;
};
