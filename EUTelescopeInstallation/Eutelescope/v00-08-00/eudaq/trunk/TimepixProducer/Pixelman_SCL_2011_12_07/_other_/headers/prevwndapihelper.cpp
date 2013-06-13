/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#include "stdafx.h"
#include "prevwndapihelper.h"
#include <cassert>

PluginFuncType PrevWndApiHelper::create = 0;
PluginFuncType PrevWndApiHelper::createDevID = 0;
PluginFuncType PrevWndApiHelper::destroy = 0;
PluginFuncType PrevWndApiHelper::autoUpdate = 0;
PluginFuncType PrevWndApiHelper::showMpxFrame = 0;
PluginFuncType PrevWndApiHelper::isVisible = 0;
PluginFuncType PrevWndApiHelper::setCaption = 0;
PluginFuncType PrevWndApiHelper::show = 0;
PluginFuncType PrevWndApiHelper::setErrorCb = 0;
PluginFuncType PrevWndApiHelper::setCloseCb = 0;
PluginFuncType PrevWndApiHelper::getLastErr = 0;

INTPTR PrevWndApiHelper::createPar = 0;
INTPTR PrevWndApiHelper::createDevIDPar = 0;
INTPTR PrevWndApiHelper::destroyPar = 0;
INTPTR PrevWndApiHelper::autoUpdatePar = 0;
INTPTR PrevWndApiHelper::showMpxFramePar = 0;
INTPTR PrevWndApiHelper::isVisiblePar = 0;
INTPTR PrevWndApiHelper::setCaptionPar = 0;
INTPTR PrevWndApiHelper::showPar = 0;
INTPTR PrevWndApiHelper::setErrorCbPar = 0;
INTPTR PrevWndApiHelper::setCloseCbPar = 0;
INTPTR PrevWndApiHelper::getLastErrPar = 0;

extern const FuncTableType *mgr;

int PrevWndApiHelper::Initialize()
{
    ExtFunctionInfo efi;
    const char *pluginName = "mpxctrlui";
    int failCount = 0;
    if (mgr->getFuncItem(pluginName, "PrevWndCreate", &efi) == 0)
    {
        create = efi.func;
        createPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndCreateDevID", &efi) == 0)
    {
        createDevID = efi.func;
        createDevIDPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndDestroy", &efi) == 0)
    {
        destroy = efi.func;
        destroyPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndAutoUpdate", &efi) == 0)
    {
        autoUpdate = efi.func;
        autoUpdatePar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndShowMpxFrame", &efi) == 0)
    {
        showMpxFrame = efi.func;
        showMpxFramePar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndSetCaption", &efi) == 0)
    {
        setCaption = efi.func;
        setCaptionPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndShow", &efi) == 0)
    {
        show = efi.func;
        showPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndSetErrorCb", &efi) == 0)
    {
        setErrorCb = efi.func;
        setErrorCbPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndSetCloseCb", &efi) == 0)
    {
        setCloseCb = efi.func;
        setCloseCbPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(pluginName, "PrevWndGetLastErr", &efi) == 0)
    {
        getLastErr = efi.func;
        getLastErrPar = efi.userData;
    }
    else
        failCount++;
    assert(failCount == 0);
    return failCount;
}

int PrevWndApiHelper::Create(u32 width, u32 height, BOOL autoDestroy, const char *iniFileName, u32 *id)
{
    if (create)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 width;
            u32 height;
            BOOL autoDestroy;
            const char *iniFileName;
        } inPars = {width, height, autoDestroy, iniFileName};
        #pragma pack(pop)
        return create(createPar, (byte *) &inPars, (byte *) id);
    }
    return -1;
}

int PrevWndApiHelper::CreateDevID(DEVID devID, BOOL autoDestroy, const char *iniFileName, u32 *id)
{
    if (createDevID)
    {
        #pragma pack(push, 1)
        struct
        {
            DEVID devID;
            BOOL autoDestroy;
            const char *iniFileName;
        } inPars = {devID, autoDestroy, iniFileName};
        #pragma pack(pop)
        return createDevID(createDevIDPar, (byte *) &inPars, (byte *) id);
    }
    return -1;
}

int PrevWndApiHelper::Destroy(u32 id)
{
    if (destroy)
        return destroy(destroyPar, (byte *) &id, 0);
    return -1;
}

int PrevWndApiHelper::AutoUpdate(u32 id, BOOL enable)
{
    if (autoUpdate)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 id;
            BOOL enable;
        } inPars = {id, enable};
        #pragma pack(pop)
        return autoUpdate(autoUpdatePar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::ShowMpxFrame(u32 id, FRAMEID frameID)
{
    if (showMpxFrame)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 id;
            FRAMEID frameID;
        } inPars = {id, frameID};
        #pragma pack(pop)
        return showMpxFrame(showMpxFramePar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::IsVisible(u32 id, BOOL *visible)
{
    if (isVisible)
        return isVisible(isVisiblePar, (byte *) &id, (byte *) visible);
    return -1;
}

int PrevWndApiHelper::SetCaption(u32 id, const char *caption)
{
    if (setCaption)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 id;
            const char *caption;
        } inPars = {id, caption};
        #pragma pack(pop)
        return setCaption(setCaptionPar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::Show(u32 id, BOOL visible)
{
    if (show)
    {
        #pragma pack(push, 1)
        struct Show_InPars
        {
            u32 id;
            BOOL visible;
        } inPars = {id, visible};
        #pragma pack(pop)
        return show(showPar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::SetErrorCb(u32 id, CallbackFuncType cb)
{
    if (setErrorCb)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 id;
            CallbackFuncType cb;
        } inPars = {id, cb};
        #pragma pack(pop)
        return setErrorCb(setErrorCbPar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::SetCloseCb(u32 id, CallbackFuncType cb)
{
    if (setCloseCb)
    {
        #pragma pack(push, 1)
        struct
        {
            u32 id;
            CallbackFuncType cb;
        } inPars = {id, cb};
        #pragma pack(pop)
        return setCloseCb(setCloseCbPar, (byte *) &inPars, 0);
    }
    return -1;
}

int PrevWndApiHelper::GetLastErr(u32 id, char errorMsg[MPX_MAX_MSGLENGTH])
{
    if (getLastErr)
        return getLastErr(getLastErrPar, (byte *) &id, (byte *) errorMsg);
    return -1;
}
