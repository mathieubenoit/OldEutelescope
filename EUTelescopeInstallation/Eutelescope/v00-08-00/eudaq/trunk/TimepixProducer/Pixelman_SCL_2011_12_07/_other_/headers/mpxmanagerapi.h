/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once
/*
#ifdef MPXMANAGER_EXPORTS
    #define MPXMANAGER_API __declspec(dllexport)
#else
    #define MPXMANAGER_API __declspec(dllimport)
#endif
*/
#define MPXMANAGER_API

#include "mpxpluginmgrapi.h"

#define MGRINIT_TRAYMENUEXIT    0x01        // enable exit via tray menu
#define MGRINIT_TRAYMENUSHOW    0x02        // tray menu is visible
#define MGRINIT_WAITFORJAVA     0x04        // c++ plugins are initialized, but manager wait with sending START event until java plugins are loaded
#define MGRINIT_JAVAREADY       0x08        // java plugins are loaded, manager should initialize filter intstances and send start event
#define MGRINIT_NOEXHANDLING    0x10        // exception won't be handled in main ui thread - for development purposes only


extern "C"
{
    // MM initialization
    // [in] flags - flags controlling tray menu via bitwise OR-ed MGRINIT_TRAYMENUXXX flags
    // [in] pluginNames - string of \0 separated path names of plugins (e.g. "plugins\\mpxctrlui.dll\0plugins\\thsequalization.dll\0") that should be loaded (both absolute and relative paths are possible), 0 if plugins should be loaded from ini file
    MPXMANAGER_API int mgrInitManager(u32 flags, const char *pluginNames);
    MPXMANAGER_API int mgrExitManager();
    MPXMANAGER_API BOOL mgrIsRunning();
    MPXMANAGER_API int mgrInvokeInUIThread(CallbackFuncType func, CBPARAM par);
    MPXMANAGER_API int mgrSetSplashScreenMsgCallback(CallbackFuncType func);

    MPXMANAGER_API int mgrGetCfgsPath(char path[MPX_MAX_PATH]);
    MPXMANAGER_API int mgrLogMsg(const char *pluginName, const char *format, u32 flags, ...);
    MPXMANAGER_API int mgrLogMsgV(const char *pluginName, const char *format, u32 flags, va_list argptr);
    MPXMANAGER_API int mgrLogShowWindow(BOOL show);
    MPXMANAGER_API int mgrManagedItemsShowWindow(BOOL show);
    MPXMANAGER_API int mgrAddPlugin(const char *fileName);
    MPXMANAGER_API int mgrRegisterExtPlugin(const char *name);

    MPXMANAGER_API int mgrAddMenuItem(const char *pluginName, const char *itemName, const char *menuPath, MenuFuncType func, MENUFUNCPAR param, ITEMID *menuItemID, u32 flags);
    MPXMANAGER_API int mgrAddMpxMenuItem(DEVID devID, const char *pluginName, const char *itemName, const char *menuPath, MenuFuncType func, MENUFUNCPAR param, ITEMID *menuItemID, u32 flags);
    MPXMANAGER_API int mgrRemoveMenuItem(ITEMID menuItemID);
    MPXMANAGER_API int mgrGetMpxMenuPath(DEVID devID, char menuPath[MENU_LENGTH]);
    MPXMANAGER_API int mgrGetFirstMenuItem(ITEMID *itemID, char name[MENU_LENGTH]);
    MPXMANAGER_API int mgrGetNextMenuItem(ITEMID *itemID, char name[MENU_LENGTH]);
    MPXMANAGER_API int mgrCallMenuItemByName(const char *name);
    MPXMANAGER_API int mgrCallMenuItemByID(ITEMID itemID);

    MPXMANAGER_API void mgrAddMsgHandler(MsgHandlerType handler);
    MPXMANAGER_API void mgrRemoveMsgHandler(MsgHandlerType handler);

    MPXMANAGER_API int mgrAddFuncItem(ExtFunctionInfo *funcInfo);
    MPXMANAGER_API int mgrRemoveFuncItem(const char *pluginName, const char *functionName);
    MPXMANAGER_API int mgrGetRegFirstFunc(ITEMID *funcID, ExtFunctionInfo *funcInfo);
    MPXMANAGER_API int mgrGetRegNextFunc(ITEMID *funcID, ExtFunctionInfo *funcInfo);
    MPXMANAGER_API int mgrGetFuncItemID(ITEMID funcID, ExtFunctionInfo *extFuncInfo);
    MPXMANAGER_API int mgrGetFuncItem(const char *pluginName, const char *functionName, ExtFunctionInfo *extFuncInfo);
    MPXMANAGER_API int mgrCallFuncItem(const char *pluginName, const char *functionName, byte *in, byte *out); 
   
    MPXMANAGER_API int mgrAddCBEvent(ExtCBEventInfo *cbEventInfo, ITEMID *cbEventID);
    MPXMANAGER_API int mgrRemoveCBEvent(const char *pluginName, const char *cbEventName);
    MPXMANAGER_API int mgrGetRegFirstCBEvent(ITEMID *cbEventID, ExtCBEventInfo *extCBEventInfo);
    MPXMANAGER_API int mgrGetRegNextCBEvent(ITEMID *cbEventID, ExtCBEventInfo *extCBEventInfo);
    MPXMANAGER_API int mgrSetCBEvent(ITEMID ID, CBPARAM par);
    MPXMANAGER_API int mgrRegisterCallback(const char *pluginName, const char *cbEventName, CallbackFuncType callback, INTPTR userData);
    MPXMANAGER_API int mgrUnregisterCallback(const char *pluginName, const char *cbEventName, CallbackFuncType callback, INTPTR userData);

    MPXMANAGER_API int mgrAddFrameAttribTempl(ExtFrameAttribInfo *attribInfo);
    MPXMANAGER_API int mgrRemoveFrameAttribTempl(const char *attribName);

    MPXMANAGER_API int mgrCreateFilterChain(const char *pluginName, const char *filterChainName, ITEMID *filterChainID);
    MPXMANAGER_API int mgrRemoveFilterChain(ITEMID filterChainID);
    MPXMANAGER_API int mgrAddToFilterChain(ITEMID filterChainID, ITEMID funcID, u32 order);
    MPXMANAGER_API int mgrRemoveFromFilterChain(ITEMID filterChainID, u32 order);
    MPXMANAGER_API int mgrGetFilteredFrame(ITEMID filterChainID, FRAMEID inID, FRAMEID *outID);
    MPXMANAGER_API int mgrGetFirstFilterChain(ITEMID *filterChainID, ExtFilterChainInfo *filterChainInfo);
    MPXMANAGER_API int mgrGetNextFilterChain(ITEMID *filterChainID, ExtFilterChainInfo *filterChainInfo);
    MPXMANAGER_API int mgrGetFilterChainInfo(ITEMID filterChainID, ExtFilterChainInfo *filterChainInfo);

    MPXMANAGER_API int mgrCreateFilterInst(ITEMID filterID, const char *name, ITEMID *instID);
    MPXMANAGER_API int mgrDeleteFilterInst(ITEMID instID);
    MPXMANAGER_API int mgrGetFirstFilterInst(ITEMID filterID, ITEMID *instID, char name[NAME_LENGTH]);
    MPXMANAGER_API int mgrGetNextFilterInst(ITEMID filterID, ITEMID *instID, char name[NAME_LENGTH]);
    MPXMANAGER_API int mgrSetFilterPar(ITEMID instID, int idx, byte *data, int dataSize);
    MPXMANAGER_API int mgrGetFilterPar(ITEMID instID, int idx, ItemInfo *info, int *dataSize);
    MPXMANAGER_API int mgrSaveFilterChainsToFile(const char* fileName);



    // frame control
    //
    MPXMANAGER_API int mgrCreateFrame(FRAMEID *frameID, u32 width, u32 height, int type, const char *creatorName);
    MPXMANAGER_API int mgrGetFrameCount(const char *fileName, int *count);
    MPXMANAGER_API int mgrLoadFrame(FRAMEID *frameID, const char *fileName, int idx);
    MPXMANAGER_API int mgrSaveFrame(FRAMEID frameID, const char *fileName, u32 flags);
    MPXMANAGER_API int mgrDuplicateFrame(FRAMEID origID, FRAMEID *newID);
    MPXMANAGER_API int mgrGetFirstFrame(FRAMEID *frameID);
    MPXMANAGER_API int mgrGetNextFrame(FRAMEID *frameID);
    MPXMANAGER_API int mgrOpenFrame(FRAMEID frameID, u32 *refCount);
    MPXMANAGER_API int mgrCloseFrame(FRAMEID frameID, u32 *refCount);
    MPXMANAGER_API int mgrLockFrame(FRAMEID frameID, u32 timeout);
    MPXMANAGER_API int mgrUnlockFrame(FRAMEID frameID);

    MPXMANAGER_API int mgrGetFrameType(FRAMEID frameID, Data_Types *type);
    MPXMANAGER_API int mgrSetFrameType(FRAMEID frameID, Data_Types type);
    MPXMANAGER_API int mgrGetFrameSize(FRAMEID frameID, u32 *width, u32 *height);
    MPXMANAGER_API int mgrSetFrameSize(FRAMEID frameID, u32 width, u32 height);
    MPXMANAGER_API int mgrSetFrameData(FRAMEID frameID, byte *buffer, u32 size);
    MPXMANAGER_API int mgrGetFrameData(FRAMEID frameID, byte *buffer, u32 *size, Data_Types type);
    MPXMANAGER_API int mgrGetLockedFrameBuff(FRAMEID frameID, byte **buffer, u32 *size, u32 timeout);  
    MPXMANAGER_API int mgrLoadFrameData(FRAMEID frameID, const char *fileName, u32 flags);

    MPXMANAGER_API int mgrSetFrameName(FRAMEID frameID, const char *name);
    MPXMANAGER_API int mgrGetFrameName(FRAMEID frameID, char name[NAME_LENGTH]);
    MPXMANAGER_API int mgrSetFrameCreatorName(FRAMEID frameID, const char *name);
    MPXMANAGER_API int mgrGetFrameCreatorName(FRAMEID frameID, char name[NAME_LENGTH]);
    MPXMANAGER_API int mgrSetFrameLogPath(FRAMEID frameID, const char *path);
    MPXMANAGER_API int mgrGetFrameLogPath(FRAMEID frameID, char path[MPX_MAX_PATH]);
    MPXMANAGER_API int mgrGetFrameFileName(FRAMEID frameID, char path[MPX_MAX_PATH]);
    MPXMANAGER_API int mgrAddFrameAttrib(FRAMEID frameID, const char *name, const char *desc, Data_Types type, const byte *data, u32 count);
    MPXMANAGER_API int mgrSetFrameAttrib(FRAMEID frameID, const char *name, byte *data, u32 size);
    MPXMANAGER_API int mgrGetFrameAttrib(FRAMEID frameID, const char *name, byte *data, u32 *size, Data_Types *type);
    MPXMANAGER_API int mgrRemoveAttrib(FRAMEID frameID, const char *name);
    MPXMANAGER_API int mgrRemoveAllAttribs(FRAMEID frameID);
    MPXMANAGER_API int mgrGetFrameFirstAttrib(FRAMEID frameID, ITEMID *itemID, ExtFrameAttrib *attrib);
    MPXMANAGER_API int mgrGetFrameNextAttrib(FRAMEID frameID, ITEMID *itemID, ExtFrameAttrib *attrib);

    MPXMANAGER_API int mgrCreateSubframe(FRAMEID frameID, int *subframeIdx, u32 width, u32 height, int flags);
    MPXMANAGER_API int mgrGetSubframeCount(FRAMEID frameID, int *subframeCount);
    MPXMANAGER_API int mgrGetSubframeType(FRAMEID frameID, int subframeIdx, Data_Types *type);
    MPXMANAGER_API int mgrSetSubframeType(FRAMEID frameID, int subframeIdx, Data_Types type);
    MPXMANAGER_API int mgrGetSubframeSize(FRAMEID frameID, int subframeIdx, u32 *width, u32 *height);
    MPXMANAGER_API int mgrSetSubframeSize(FRAMEID frameID, int subframeIdx, u32 width, u32 height);
    MPXMANAGER_API int mgrSetSubframeData(FRAMEID frameID, int subframeIdx, byte *buffer, u32 size);
    MPXMANAGER_API int mgrGetSubframeData(FRAMEID frameID, int subframeIdx, byte *buffer, u32 *size, Data_Types type);
    MPXMANAGER_API int mgrGetLockedSubframeBuff(FRAMEID frameID, int subframeIdx, byte **buffer, u32 *size, u32 timeout);
    MPXMANAGER_API int mgrSetSubframeName(FRAMEID frameID, int subframeIdx, const char *name);
    MPXMANAGER_API int mgrGetSubframeName(FRAMEID frameID, int subframeIdx, char name[MPX_MAX_PATH]);

    MPXMANAGER_API int mgrGetServiceFrame(DEVID devID, u32 type, FRAMEID *frameID);

    // functions provided from MpxCtrl dll (mpxCtrl prefix)
    //
    MPXMANAGER_API int mpxCtrlGetFirstMpx(DEVID *devID, int *count = 0);
    MPXMANAGER_API int mpxCtrlGetNextMpx(DEVID *devID);
    MPXMANAGER_API int mpxCtrlFindNewMpxs();
    MPXMANAGER_API int mpxCtrlReconnectMpx(DEVID devID);

    MPXMANAGER_API int mpxCtrlGetHwInfoCount(DEVID devID, int *count);
    MPXMANAGER_API int mpxCtrlGetHwInfoItem(DEVID devID, int index, HwInfoItem *infoItem, int *dataSize);
    MPXMANAGER_API int mpxCtrlSetHwInfoItem(DEVID devID, int index, byte *data, int dataSize);	

    //
    MPXMANAGER_API int mpxCtrlSetCustomName(DEVID devID, const char *name);
    MPXMANAGER_API int mpxCtrlGetCustomName(DEVID devID, char name[NAME_LENGTH]);
    MPXMANAGER_API int mpxCtrlTryLockDevice(DEVID devID, BOOL *success, u32 timeout = 0);
    MPXMANAGER_API int mpxCtrlReleaseDevice(DEVID devID);
    MPXMANAGER_API int mpxCtrlGetLockOwnerID(DEVID devID, u32 *id);

    MPXMANAGER_API int mpxCtrlReviveMpxDevice(DEVID devID);
    MPXMANAGER_API int mpxCtrlSaveMpxCfg(DEVID devID, const char *fileName);
    MPXMANAGER_API int mpxCtrlLoadMpxCfg(DEVID devID, const char *fileName);
    MPXMANAGER_API int mpxCtrlSaveMpxCfgAsDefault(DEVID devID);

    // set/get acquisition setting
    //
    MPXMANAGER_API int mpxCtrlSetDevSpecAcqPars(DEVID devID, byte *pars, u32 size);
    MPXMANAGER_API int mpxCtrlGetDevSpecAcqPars(DEVID devID, byte *pars, u32 size);
    MPXMANAGER_API int mpxCtrlSetPolarity(DEVID devID, BOOL positive);
    MPXMANAGER_API int mpxCtrlGetPolarity(DEVID devID, BOOL *positive);
    MPXMANAGER_API int mpxCtrlSetAcqMode(DEVID devID, int mode);
    MPXMANAGER_API int mpxCtrlGetAcqMode(DEVID devID, int *mode);
    MPXMANAGER_API int mpxCtrlSetHwTimer(DEVID devID, int state);
    MPXMANAGER_API int mpxCtrlGetHwTimer(DEVID devID, int *state);
    MPXMANAGER_API int mpxCtrlSetDACsDefault(DEVID devID);
    MPXMANAGER_API int mpxCtrlSetDACs(DEVID devID, DACTYPE dacVals[], int size, int chipNumber);
    MPXMANAGER_API int mpxCtrlGetDACs(DEVID devID, DACTYPE dacVals[], int size, int chipNumber);
    MPXMANAGER_API int mpxCtrlGetSingleDACAnalog(DEVID devID, double dacVals[], int size, int dacNumber, int chipNumber, int senseCount);
    MPXMANAGER_API int mpxCtrlGetDACsAnalog(DEVID devID, double dacVals[], int size, int chipNumber);
    MPXMANAGER_API int mpxCtrlRefreshDACs(DEVID devID);
    MPXMANAGER_API int mpxCtrlGetDACsNames(DEVID devID, const char * const **names, const int **precisions, int *size);
    MPXMANAGER_API int mpxCtrlSetExtDAC(DEVID devID, int dacNumber, double value);
    MPXMANAGER_API int mpxCtrlGetExtDAC(DEVID devID, int *dacNumber, double *value);

    MPXMANAGER_API int mpxCtrlSetPixelsCfg(DEVID devID, byte pixCfgs[], int size, int chipNumber);
    MPXMANAGER_API int mpxCtrlGetPixelsCfg(DEVID devID, byte pixCfgs[], int size, int chipNumber);
    MPXMANAGER_API int mpxCtrlResetPixelsCfg(DEVID devID, int chipNumber);
    MPXMANAGER_API int mpxCtrlSetSuperMatrixPixCfg(DEVID devID, byte pixCfgs[], int size);
    MPXMANAGER_API int mpxCtrlGetSuperMatrixPixCfg(DEVID devID, byte pixCfgs[], int size);
    MPXMANAGER_API int mpxCtrlRefreshPixelsCfg(DEVID devID);
    MPXMANAGER_API int mpxCtrlSetSuppressMasked(DEVID devID, BOOL suppress);
    MPXMANAGER_API int mpxCtrlGetSuppressMasked(DEVID devID, BOOL *suppress);
    MPXMANAGER_API int mpxCtrlSetAutoConvToSM(DEVID devID, BOOL enable);
    MPXMANAGER_API int mpxCtrlGetAutoConvToSM(DEVID devID, BOOL *enable);
    MPXMANAGER_API int mpxCtrlConvToSuperMatrix(DEVID devID, const byte *chipByChip, byte *superMatrix, u32 buffSize, Data_Types buffType);
    MPXMANAGER_API int mpxCtrlConvFromSuperMatrix(DEVID devID, const byte *superMatrix, byte *chipByChip, u32 buffSize, Data_Types buffType);
    MPXMANAGER_API int mpxCtrlSetMatrixLayout(DEVID devID, u16 width, u16 height, i32* chips, i32* angles, BOOL createSubFrames);
    MPXMANAGER_API int mpxCtrlGetMatrixLayout(DEVID devID, u16 *width, u16 *height, i32* chips, i32* angles, BOOL* createSubFrames);

    MPXMANAGER_API int mpxCtrlLoadPixelsCfg(DEVID devID, const char *fileName, BOOL loadDacs);
    MPXMANAGER_API int mpxCtrlSavePixelsCfg(DEVID devID, const char *fileName, BOOL saveDacs);
    MPXMANAGER_API int mpxCtrlLoadPixelsCfgAscii(DEVID devID, const char *fileName, int part, BOOL loadDacs);
    MPXMANAGER_API int mpxCtrlSavePixelsCfgAscii(DEVID devID, const char *fileName, int part, BOOL saveDacs);

    // acquisition control
    //
    MPXMANAGER_API int mpxCtrlPerformIntegralAcq(DEVID devID, int numberOfAcq, double timeOfEachAcq, u32 fileFlags = 0, const char *fileName = 0);
    MPXMANAGER_API int mpxCtrlPerformFrameAcq(DEVID devID, int numberOfFrames, double timeOfEachAcq, u32 fileFlags = 0, const char *fileName = 0);
    MPXMANAGER_API int mpxCtrlPerformTestPulseAcq(DEVID devID, int spacing, double *pulseHeight, double period, u32 pulseCount, u32 *manual, BOOL manualTPBits);
    MPXMANAGER_API int mpxCtrlPerformDigitalTest(DEVID devID, u32 *goodPixels, FRAMEID *frameID, BOOL show, double delay);
    MPXMANAGER_API int mpxCtrlAbortOperation(DEVID devID);
    MPXMANAGER_API int mpxCtrlTrigger(DEVID devID, int trigger);

    // buffer control
    //
    MPXMANAGER_API int mpxCtrlCloseFrames(DEVID devID);
    MPXMANAGER_API int mpxCtrlGetFrame16(DEVID devID, i16 *buffer, u32 size, u32 frameNumber);
    MPXMANAGER_API int mpxCtrlGetFrame32(DEVID devID, u32 *buffer, u32 size, u32 frameNumber);
    MPXMANAGER_API int mpxCtrlGetFrameDouble(DEVID devID, double *buffer, u32 size, u32 frameNumber);
    MPXMANAGER_API int mpxCtrlSaveFrame(DEVID devID, const char *fileName, int frameNumber, u32 flags);
    MPXMANAGER_API int mpxCtrlGetFrameAttrib(DEVID devID, int frameNumber, const char *name, byte *value, u32 *size, Data_Types *type);
    MPXMANAGER_API int mpxCtrlGetFrameID(DEVID devID, int frameNumber, FRAMEID *frameID);

    // info functions
    MPXMANAGER_API int mpxCtrlGetDevInfo(DEVID devID, DevInfo *devInfo);
    MPXMANAGER_API int mpxCtrlGetMedipixInfo(DEVID devID, int *numberOfChips, int *numberOfRows, char chipBoardID[MPX_MAX_CHBID] = 0, char ifaceName[MPX_MAX_IFACENAME] = 0);
    MPXMANAGER_API int mpxCtrlGetAcqInfo(DEVID devID, int *acqNumber, int *acqTotalCount, int *acqType, u32 *frameFilled);
    MPXMANAGER_API int mpxCtrlGetInfoMsg(DEVID devID, int *msgType, const char **msg);
}

