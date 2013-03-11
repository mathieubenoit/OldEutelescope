/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once
#include "mpxpluginmgrapi.h"

class PrevWndApiHelper
{
public:
    static int Initialize();

    static int Create(u32 width, u32 height, BOOL autoDestroy, const char *iniFileName, u32 *id);
    static int CreateDevID(DEVID devID, BOOL autoDestroy, const char *iniFileName, u32 *id);
    static int Destroy(u32 id);
    static int AutoUpdate(u32 id, BOOL enable);
    static int ShowMpxFrame(u32 id, FRAMEID frameID);
    static int IsVisible(u32 id, BOOL *isVisible);
    static int SetCaption(u32 id, const char *caption);
    static int Show(u32 id, BOOL visible);
    static int SetErrorCb(u32 id, CallbackFuncType cb);
    static int SetCloseCb(u32 id, CallbackFuncType cb);
    static int GetLastErr(u32 id, char errorMsg[MPX_MAX_MSGLENGTH]);

private:
    static PluginFuncType create;
    static PluginFuncType createDevID;
    static PluginFuncType destroy;
    static PluginFuncType autoUpdate;
    static PluginFuncType showMpxFrame;
    static PluginFuncType isVisible;
    static PluginFuncType setCaption;
    static PluginFuncType show;
    static PluginFuncType setErrorCb;
    static PluginFuncType setCloseCb;
    static PluginFuncType getLastErr;

    static INTPTR createPar;
    static INTPTR createDevIDPar;
    static INTPTR destroyPar;
    static INTPTR autoUpdatePar;
    static INTPTR showMpxFramePar;
    static INTPTR isVisiblePar;
    static INTPTR setCaptionPar;
    static INTPTR showPar;
    static INTPTR setErrorCbPar;
    static INTPTR setCloseCbPar;
    static INTPTR getLastErrPar;
};
