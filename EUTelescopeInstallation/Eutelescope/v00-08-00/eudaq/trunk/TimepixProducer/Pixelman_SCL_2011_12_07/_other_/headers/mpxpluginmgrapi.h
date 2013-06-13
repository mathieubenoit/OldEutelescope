/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once

#ifndef MPXPLUGINMGRAPI_H
#define MPXPLUGINMGRAPI_H

#include "common.h"
#include "mpxerrors.h"
#include <stdarg.h>

#define MPXMGR_NAME             "mpxmgr"            // name of mpx manager for accessing callbacks registered by manager itself
#define MPXMGR_CB_START         "Start"             // callback event name for start event (every plugin was loaded)
#define MPXMGR_CB_EXIT          "Exit"              // callback event name for exit event (application is shutting down, but everything is still functional (message processing, mpxCtrl library is still alive,...)
                                                    // good time for clean up if cleanup requires win message processing
#define MPXMGR_CB_MENU_CHANGED  "MenuChanged"       // tray menu changed
#define MPXMGR_NEW_LOG_ITEM     "NewLogItem"        // new log item in log

// frame callbacks - as the parameter of callback function plugin receives FRAMEID of corresponding frame
#define MPXMGR_CB_FRAME_NEW     "FrameCreated"      // new frame was created
#define MPXMGR_CB_FRAME_DEL     "FrameDelete"       // frame will be deleted (still exist during callback)
#define MPXMGR_CB_FRAME_DCHNG   "FrameDataChanged"  // frame data were changed
#define MPXMGR_CB_FRAME_ACHNG   "FrameAttrChanged"  // frame attributes were changed

#define MPXCTRL_NAME            "mpxctrl"           // "plugin name" for access callback events registered by MpxCtrl library
// Names for MpxCtrl callback events
#define MPXCTRL_CB_ACQPRESTART  "AcqPreStart"       // Acq. is going to start (either start or wait for start trigger, depends on mode)
#define MPXCTRL_CB_ACQSTART     "AcqStarted"        // acquisition was started (for triggered acq)
#define MPXCTRL_CB_ACQPREREAD   "AcqPreReadData"    // Data are going to be read-out (shutter is closed)
#define MPXCTRL_CB_ACQCOMPL     "AcqCompleted"      // single acquisition was completed (acq. finished, data read)
#define MPXCTRL_CB_ACQSERCOMPL  "AcqSerCompleted"   // acquisition series completed
#define MPXCTRL_CB_INFOMSG      "InfoMsg"           // callback event name for info/error messages
#define MPXCTRL_CB_DACSSET      "DACs set"          // DACs were set (changed)
#define MPXCTRL_CB_PIXCFG       "PixCfg"            // PixCfg changed
#define MPXCTRL_CB_MPXNEW       "MpxDevNew"         // new mpx device was detected
#define MPXCTRL_CB_MPXCHANGED   "MpxDevChanged"     // mpx device was "reconnected" (e.g. some mpx device was switched on one of interfaces)
#define MPXCTRL_CB_EXTDACSET    "ExtDACSet"         // external DAC was changed (value and/or it replaces another DAC)

#define PIXCFG_MASK     1
#define PIXCFG_TEST     2
#define PIXCFG_THL      3
#define PIXCFG_THH      4
#define PIXCFG_MODE     5
#define PIXCFG_GAIN     6

#define NAME_LENGTH                 32          // maximum length of registered names for plugins, callback events, function names... (in ExtFunctionInfo,...)
#define DESC_LENGTH                 128         // maximum length of description string for plugins, callback events, function names... (in ExtFunctionInfo,...)
#define MENU_LENGTH                 256         // maximum length of menu item path (path1|path2|item)
#define MAX_PARAM                   8           // maximum number of input/output parameters (limits number of ExtParamInfo in ExtFunctionInfo)
#define INVALID_DEVID_VALUE         0xffffffff  // invalid Device ID (DEVID type)
#define INVALID_THREADID_VALUE      0xffffffff  // invalid thread ID (u32)
#define INVALID_ITEMID_VALUE        0           // invalid ITEMID (functions, callbacks or filters)
#define ALLCHIPS                    (-1)        // "chipNumber" for operation with all chips
#define ALLFRAMES                   (-1)        // "frameNumber" for operation with all frames
#define INST_STARTID                (100000000) // first filter instance id

// known frame attributes names
#define FAN_CUSTOMNAME              "Custom name"
#define FAN_PIXELMANVERSION         "Pixelman version"
#define FAN_MPXTYPE                 "Mpx type"
#define FAN_CHIPBOARDID             "ChipboardID"
#define FAN_INTERFACE               "Interface"
#define FAN_MPXCLOCK                "Mpx clock"
#define FAN_ACQTIME                 "Acq time"
#define FAN_POLARITY                "Polarity"
#define FAN_ACQMODE                 "Acq mode"
#define FAN_HWTIMER                 "Hw timer"
#define FAN_DACS                    "DACs"
#define FAN_STARTTIME               "Start time"
#define FAN_STARTTIMESTR            "Start time (string)"
#define FAN_APPLIEDFILTERS          "Applied filters"
#define FAN_DATACHIPBYCHIP          "ChipByChip"       // data in frame are in chip by chip format (not super matrix)
#define FAN_LAYOUTWIDTH             "Matrix width"      // width of frame in chips
#define FAN_LAYOUTHEIGHT            "Matrix height"     // height of frame in chips
#define FAN_LAYOUTCHIPS             "Chips layout"      // order of chips in the frame
#define FAN_LAYOUTANGLES            "Chips angles layout"    // angles for each chips in matrix [0=0deg, 1=90deg, 2=180deg, 3=270deg]
#define FAN_MPX3COUNTER             "Mpx3Counter"    

typedef INTPTR ITEMID;              // type for accessing registered functions, callbacks or filters
typedef u32 DEVID;                  // type for accessing medipix device (device "handle" or "identifikator")
typedef u32 FRAMEID;                // type for accessing frames



// function plugin type that can be registered in Manager through function of type AddFuncType
// function has to return 0 on success, non zero on error
// userData is custom parameter, its value is specified by plugin which register this function
typedef int (*PluginFuncType)(INTPTR userData, byte *in, byte *out);

typedef INTPTR CBPARAM;                         // type of parameter for callback functions registered in manager

// callback type that can be registered in Manager
// par - data specific to callback
// userData - callback provider custom data
typedef void (*CallbackFuncType)(CBPARAM par, INTPTR userData);

typedef unsigned int MENUFUNCPAR;               // type of parameter for menu functions registered in tray menu
typedef void (*MenuFuncType)(MENUFUNCPAR par);  // type of function that can be registered through function of type AddMenuType
 
#ifndef WIN32
typedef void* LPMSG;
#endif

typedef BOOL (*MsgHandlerType)(LPMSG msg);      // message handler type for registering for win message loop

// function of this type can be registered by plugin to offer custom frame attribute
// these registered functions will be called after frame acquisition to get actual attribute value for current frame
// [in] userData - custom value
// [in] devID - ID of corresponding Mpx device
// [out] data - buffer for attribute value(s)
// [in/out] size - size of data buffer (in bytes), after call this variable should contain the used size of buffer or required size if supplied buffer is not big enough
typedef int (*GetFrameAttribType)(INTPTR userData, DEVID devID, byte *data, int *size);

// structure describing one parameter of plugin function
typedef struct _ExtParamInfo
{
    Data_Types type;                    // parameter type
    int count;                          // count (for array of type)
    char description[DESC_LENGTH];      // description string
} ExtParamInfo;

// function flags (distinguish certain func. types)
#define FUNCFLAG_FILTER     0x01        // function is a filter, (function parameters - two input parameters - frameID and instance id (for adjustable filters, 0 for simple filters), so the type should be: int func(INTPTR, &{FRAMEID, ITEMID}, 0))
#define FUNCFLAG_ADJFILTER  0x02        // function is adjustable filter (userData has to contained pointer to filled AdjFilterPars structure)

// structure describing plugin function registered in Manager
typedef struct _ExtFunctionInfo
{
    PluginFuncType func;                    // pointer to registered function
    int paramInCount;                       // number of input parameters
    int paramOutCount;                      // number of output parameters
    ExtParamInfo paramsInfoIn[MAX_PARAM];   // input parameters infos
    ExtParamInfo paramsInfoOut[MAX_PARAM];  // output parameters infos
    char pluginName[NAME_LENGTH];           // plugin name
    char functionName[NAME_LENGTH];         // function name
    char description[DESC_LENGTH];          // function description
    INTPTR userData;                        // custom parameter that will be used for func call
    u32 flags;                              // combination of FUNCFLAG_XXX
    ITEMID funcID;                          // function ID (filled by MpxManager)
} ExtFunctionInfo;

// structure describing plugin callback event registered in Manager
typedef struct _ExtCBEventInfo
{
    char pluginName[NAME_LENGTH];           // plugin name
    char cbEventName[NAME_LENGTH];          // callback event name
    char description[DESC_LENGTH];          // callback event description
} ExtCBEventInfo;

// structure to get information about certain FilterChain
typedef struct _ExtFilterChainInfo
{
    char pluginName[NAME_LENGTH];       // plugin which created filter chain
    char filterChainName[NAME_LENGTH];  // filter chain name
    ITEMID *filterIDs;                  // pointer to buffer (provided by user) to obtain IDs of filters which are in chain, can be NULL if caller do not want this info
    u32 filterIDsSize;                  // size of filterIDs buffer
    char *filterNames;                  // pointer to buffer (provided by user) to obtain names of filters which are in chain (separated by '|'), can be NULL if caller do not want this info
    u32 filterNamesSize;                // size of filterNames buffer
} ExtFilterChainInfo;

// structure describing custom frame attribute provided by plugin (template for attribute)
typedef struct _ExtFrameAttribInfo
{
    char pluginName[NAME_LENGTH];   // plugin which provides attribute value
    char attribName[NAME_LENGTH];   // name of attribute
    char description[DESC_LENGTH];  // description
    Data_Types type;                // type of attribute
    INTPTR userData;                // userData for GetFrameAttribType function
    GetFrameAttribType func;        // get attribute function
} ExtFrameAttribInfo;

// structure describing custom frame attribute provided by plugin
typedef struct _ExtFrameAttrib
{
    char name[NAME_LENGTH];         // name of attribute
    char desc[DESC_LENGTH];         // description of attribute
    Data_Types type;                // type of attribute
    int size;                       // size of data in bytes
} ExtFrameAttrib;

// codes of frame attribute change
#define FATTR_CHANGE_ADD        1       // attribute was added
#define FATTR_CHANGE_DEL        2       // attribute was deleted
#define FATTR_CHANGE_DELALL     3       // all attributes were removed
#define FATTR_CHANGE_SET        4       // attribute's value was changed 

// structure for callback MPXMGR_CB_FRAME_ACHNG
typedef struct _FrameAttribChange
{
    FRAMEID frameID;            // ID of frame which attribute was changed
    char name[NAME_LENGTH];     // name of attribute
    int size;                   // size of attribute
    int changeCode;             // code of frame attribute change
} FrameAttribChange;

// ---- adjustable filters ----
// if plugin wants to register "adjustable filter" it has to fill AdjFilterPars structure and pass it
// to manager in userData parameter in ExtFunctionInfo. UserData parameter for filter (function)
// is passed via AdjFilterPars. Manager will then provide access to these function via 
// MgrCreateFilterInstType, MgrDeleteFilterInstType, MgrSetFilterParType, MgrGetFilterParType functions
// NOTE: instance ID of filter returned by MgrCreateFilterInstType is globally unique across all plugins
// while instance ID returned by AdjFiltCreateInstType is unique just for plugin => these IDs are not same

// Function type for creating new instance of "Adjustable filter"
// [in] userData - custom parameter that will be passed by manager to plugin
// [out] instID - ID of filter instance (it is generated by plugin, it has to be unique for instances of certain filter, it can be recycled (if instance with certain id is deleted, this id can be used for new instance again))
typedef int (*AdjFiltCreateInstType)(INTPTR userData, ITEMID *instID);

// Function type for deleting instance of "Adjustable filter"
// [in] userData - custom parameter that will be passed by manager to plugin
// [in] instID - ID of filter instance to delete
typedef int (*AdjFiltDeleteInstType)(INTPTR userData, ITEMID instID);

// Function type for setting parameter of "Adjustable filter"
// [in] userData - custom parameter that will be passed by manager to plugin
// [in] instID - instance ID of filter
// [in] idx - zero-based index of parameter
// [in] data - data for parameter
// [in] dataSize - size of data (in bytes)
typedef int (*AdjFiltSetParType)(INTPTR userData, ITEMID instID, int idx, byte *data, int dataSize);

// Function type for getting informations about parameter and/or its value of "Adjustable filter"
// [in] userData - custom parameter that will be passed by manager to plugin
// [in] instID - instance ID of filter
// [in] idx - zero-based index of parameter or -1, in case of -1, *dataSize will contain number of parameters of adjustable filters, (info will be unused so it can be NULL)
// [in/out] info - data for parameter, info->data can contain allocated buffer for param. value, if info->data is NULL info structure will be filled without data
// [in/out] dataSize - dataSize should contain size of allocated buffer in info->data (in bytes), after return it will contain required size of data buffer for parameter
typedef int (*AdjFiltGetParType)(INTPTR userData, ITEMID instID, int idx, ItemInfo *info, int *dataSize);


struct AdjFilterPars
{
    INTPTR userData;                    // user data of filter function (userData in ExtFunctionInfo contains pointer to AdjFilterPars struct)
    INTPTR createInstUserData;          // user data parameter for provided createInst function
    INTPTR deleteInstUserData;          // user data parameter for provided deleteInst function
    INTPTR setParUserData;              // user data parameter for provided setPar function
    INTPTR getParUserData;              // user data parameter for provided getPar function
    AdjFiltCreateInstType createInst;   // function of adj. filter instance creation
    AdjFiltDeleteInstType deleteInst;   // function of adj. filter instance deletetion
    AdjFiltSetParType setPar;           // function for setting parameter of adj. filter
    AdjFiltGetParType getPar;           // function for getting parameter of adj. filter
};


// gets path to configs directory where all configuration files should be stored 
// [out] path - output buffer for path (path end with (back)slash)
typedef int (*MgrGetCfgsPathType)(char path[MPX_MAX_PATH]);


// flags for functions MgrLogMsgType
#define MGRLOG_GET_SYSERROR     0x1       // get last error and makes it part of logged error string (to simplify error reporting when WINAPI calls fail)
#define MGRLOG_SHOW_MSGBOX      0x2       // show messagebox with error
#define MGRLOG_SHOW_MSGBOX_UM   0x4       // show message window which is not modal


// error logging function type
// [in] pluginName - name of plugin which request loging
// [in] format - "printf-like" format string
// [in] flags - bitwise MGRLOG_XXX flags
// [in] ... - ellipsis (printf-like)
typedef int (*MgrLogMsgType)(const char *pluginName, const char *format, u32 flags, ...);

// error login function type
// [in] pluginName - name of plugin which request loging
// [in] flags - bitwise MGRLOG_XXX flags
// [in] format - "printf-like" format string
// [in] argptr - variable argument list (vprintf-like)
typedef int (*MgrLogMsgVType)(const char *pluginName, const char *format, u32 flags, va_list argptr);

// shows/hides log window error login functions types
// [in] show - TRUE to show log window, FALSE to hide it
typedef int (*MgrLogShowWindowType)(BOOL show);

// shows/hides windows with list of items managed by manager
// [in] show - TRUE to show window, FALSE to hide it
typedef int (*MgrManagedItemsShowWindowType)(BOOL show);

// function for registering plugin in Manager
// [in] fileName - fileNamePath to DLL
typedef int (*MgrAddPluginType)(const char *fileName);

// function type for adding item in Loader menu
// [in] pluginName - name of plugin which adds item to menu
// [in] itemName - name of item in menu
// [in] menuPath - sequence of submenus where menuitem will be placed, submenus are separated by pipe (|) e.g. "Special Plugins|Filteres"
// [in] func - pointer to function that will be called when user clicks on menuitem
// [in] param - parameter which will be given to function 'func'
// [out] menuItemID - pointer to ID which will be assigned to this menuitem, this can be 0 (NULL) if caller is not interested in this value (this ID is used for removing menuitem from menu)
// [in] flags - reserved flags, use 0
typedef int (*MgrAddMenuItemType)(const char *pluginName, const char *itemName, const char *menuPath, MenuFuncType func, MENUFUNCPAR param, ITEMID *menuItemID, u32 flags);

// function type for adding item in Loader menu to submenu corresponding to Medipix device identified by devID
// [in] devID - device ID of medipix
// [in] pluginName - name of plugin which adds item to menu
// [in] itemName - name of item in menu
// [in] menuPath - sequence of submenus where menuitem will be placed, submenus are separated by pipe (|) e.g. "Special Plugins|Filteres", these submenus will be placed in submenu correspnding to spedified mpx device
// [in] func - pointer to function that will be called when user clicks on menuitem
// [in] param - parameter which will be given to function 'func'
// [out] menuItemID - pointer to ID which will be assigned to this menuitem, this can be 0 (NULL) if caller is not interested in this value (this ID is used for removing menuitem from menu)
// [in] flags - reserved flags, use 0
typedef int (*MgrAddMpxMenuItemType)(DEVID devID, const char *pluginName, const char *itemName, const char *menuPath, MenuFuncType func, MENUFUNCPAR param, ITEMID *menuItemID, u32 flags);

// function type for removing item in Loader menu
// [in] menuItemID - ID of item that will be removed
typedef int (*MgrRemoveMenuItemType)(ITEMID menuItemID);

// [in] devID - device ID of medipix
// [out] menuPath - path to "menu folder" of mpx device
typedef int (*MgrGetMpxMenuPathType)(DEVID devID, char menuPath[MENU_LENGTH]);

// types of function for browsing of items in tray menu
// to enumerate all menu items MgrGetFirstMenuItem has to be called first, 
// return value 0 means that "name" contains path name of first menu item (e.g. path1|path2|someitem)
// use the itemID in subsequent calls of MgrGetNextMenuItem, call it repeatedly until return value != 0
// [in/out] itemID - pointer to "browse handle", do not change its value
// [out] name - path name of menu item, used for call in MgrCallMenuItemByName()
typedef int (*MgrGetFirstMenuItemType)(ITEMID *itemID, char name[MENU_LENGTH]);
typedef int (*MgrGetNextMenuItemType)(ITEMID *itemID, char name[MENU_LENGTH]);

// type of function for calling menu item
// [in] name - path name of menu item
typedef int (*MgrCallMenuItemByNameType)(const char *name);

// type of function for calling menu item
// [in] itemID - ID of menu item
typedef int (*MgrCallMenuItemByIDType)(ITEMID itemID);


// allows execution of supplied function in default UI thread
// [in] func - function that should be executed
// [in] par - data for func
typedef int (*MgrInvokeInUIThreadType)(CallbackFuncType func, CBPARAM par);

// type of function for adding own handler for win messages (pretranslation of win msgs, support for MFC plugins)
// [in] handler - message handler function
typedef void (*MgrAddMsgHandlerType)(MsgHandlerType handler);

// type of function for removing (unregistering) handler
// [in] handler - message handler function that should be unregistered
typedef void (*MgrRemoveHandlerType)(MsgHandlerType handler);

// function type for registering plugin function in Manager
// [in] funcInfo - this structure has to be filled to give manager all informations about function
typedef int (*MgrAddFuncItemType)(ExtFunctionInfo *funcInfo);

// function type for unregistering plugin function in Manager
// [in] pluginName - name of plugin containing function that should be removed
// [in] functionName - name of function that should be unregistered
typedef int (*MgrRemoveFuncItemType)(const char *pluginName, const char *functionName);

// types of function for browsing of registered functions
// to enumerate all registered functions mgrGetRegFirstFunc has to be called first, 
// return value 0 means that funcInfo contains information about registered function, 
// use the funcID in subsequent calls of mgrGetRegNextFunc, call it repeatedly until return value != 0
// [in/out] funcID - pointer to "browse handle", do not change its value
// [out] funcInfo - this structure will be filled by manager to provide all informations about registered function
typedef int (*MgrGetRegFirstFuncType)(ITEMID *funcID, ExtFunctionInfo *funcInfo);
typedef int (*MgrGetRegNextFuncType)(ITEMID *funcID, ExtFunctionInfo *funcInfo);

// type of function for getting function info via plugin.functionName
// [in] funcID - id of function
// [out] extFuncInfo - this structure will be filled by manager to provide all informations about registered function
typedef int (*MgrGetFuncItemIDType)(ITEMID funcID, ExtFunctionInfo *extFuncInfo);

// type of function for getting function info via plugin.functionName
// [in] pluginName - name of plugin where function resides
// [in] functionName - name of function we are interested in
// [out] extFuncInfo - this structure will be filled by manager to provide all informations about registered function
typedef int (*MgrGetFuncItemType)(const char *pluginName, const char *functionName, ExtFunctionInfo *extFuncInfo);

// type of function for calling function info via plugin.functionName
// [in] pluginName - name of plugin where function resides
// [in] functionName - name of function we are interested in
// [in] in - input parameters for specified function
// [out] out - output parameters for specified function
typedef int (*MgrCallFuncItemType)(const char *pluginName, const char *functionName, byte *in, byte *out);


// function type for registering callback event (by plugin) in Manager
// [in] cbEventInfo - structure describing callback event which will be registered
// [out] eventID - assigned ID, this value should be used for setting cb event
typedef int (*MgrAddCBEventType)(ExtCBEventInfo *cbEventInfo, ITEMID *eventID);

// function type for unregistering callback event (by plugin) in Manager
// [in] pluginName - name of plugin where function resides
// [in] cbEventName - name of callback event that shoud be unregistered
typedef int (*MgrRemoveCBEventType)(const char *pluginName, const char *cbEventName);

// types of function for browsing of registered callback events
// to enumerate all registered events mgrGetRegFirstCBEvent has to be called first, 
// return value 0 means that funcInfo contains information about registered function, 
// use the cbEventID in subsequent calls of mgrGetRegNextCBEvent, call it repeatedly until return value != 0
// [in/out] cbEventID - pointer to "browse handle", do not change its value
// [out] extCBEventInfo - this structure will be filled by manager to provide all informations about registered event
typedef int (*MgrGetRegFirstCBEventType)(ITEMID *cbEventID, ExtCBEventInfo *extCBEventInfo);
typedef int (*MgrGetRegNextCBEventType)(ITEMID *cbEventID, ExtCBEventInfo *extCBEventInfo);

// type of function for setting the registered callback event (Manager then calls registered callback function for this "callback event"
// [in] ID - event ID that should be set
// [in] par - parameter that will be given to callback function registered for this event
typedef int (*MgrSetCBEventType)(ITEMID ID, CBPARAM par);

// type of function for registering to receive notifications about callback event
// [in] pluginName - name of plugin which offers required cb event
// [in] cbEventName - name of event for which we register
// [in] callback - pointer to call back that should be called when event occures
// [in] userData - custom user data for provided callback function (callback is identified by <callback, userData> pair
// so it is possible to register same function several times for single event with different userData
typedef int (*MgrRegisterCallbackType)(const char *pluginName, const char *cbEventName, CallbackFuncType callback, INTPTR userData);

// type of function for registering to receive notifications about callback event
// [in] pluginName - name of plugin which offers the event
// [in] cbEventName - name of event for which should be registration changed
// [in] callback - callback function which we want remove from "call list" when event occurres
// [in] userData - custom user data for provided callback function (has to be some as for registration)
typedef int (*MgrUnregisterCallbackType)(const char *pluginName, const char *cbEventName, CallbackFuncType callback, INTPTR userData);

// function type for registering custom frame attribute template
// [in] attribInfo - this structure has to be filled to give manager required informations
typedef int (*MgrAddFrameAttribTemplType)(ExtFrameAttribInfo *attribInfo);

// function type for unregistering custom frame attribute template
// [in] attribName - name of attribName that should be unregistered
typedef int (*MgrRemoveFrameAttribTemplType)(const char *attribName);


// type of function for creating chain of filters
// [in] pluginName - name of plugin which is creating chain of filters
// [in] filterChainName - name of filter chain
// [out] filterChainID - ID of created filter chain
typedef int (*MgrCreateFilterChainType)(const char *pluginName, const char *filterChainName, ITEMID *filterChainID);

// removes filter chain
// [in] filterChainID - ID of filter chain that should be removed
typedef int (*MgrRemoveFilterChainType)(ITEMID filterChainID);

// type of function for adding filter to chain of filters
// [in] filterChainID - ID of filter chain to which the filter will be added
// [in] filtInstID - instance ID of filter (obtained via MgrCreateFilterInstType)
// [in] order - zero based index of filter in chain (0 add to begining, MAXDWORD - add to end)
typedef int (*MgrAddToFilterChainType)(ITEMID filterChainID, ITEMID filtInstID, u32 order);

// type of function for removing filter from chain of filters
// [in] filterChainID - ID of filter chain from which the filter will be removed
// [in] order - order of filter (zero based)
typedef int (*MgrRemoveFromFilterChainType)(ITEMID filterChainID, u32 order);

// type of function for getting frame processed by filter chain
// [in] filterChainID - ID of filter chain which will be used
// [in] inID - ID of input frame
// [out] outID - ID of created output frame
typedef int (*MgrGetFilteredFrameType)(ITEMID filterChainID, FRAMEID inID, FRAMEID *outID);

// types of function for browsing created filter chains
// to enumerate all filter chains MgrGetFirstFilterChainType has to be called first, 
// return value 0 means that filterChainInfo contains information about registered function, 
// use the filterChainID in subsequent calls of MgrGetNextFilterChainType, call it repeatedly until return value != 0
// [in/out] filterChainID - pointer to "browse handle", do not change its value
// [out] filterChainInfo - this structure will be filled by manager to provide all informations about filter chain, caller must supply filterChainInfo->filterNames and filterChainInfo->filterIDs buffer and their size if he wants fill informations about filter names and/or filter IDs, filterChainInfo->filterNamesSize and filterChainInfo->filterIDsSize will contain required size of buffers
typedef int (*MgrGetFirstFilterChainType)(ITEMID *filterChainID, ExtFilterChainInfo *filterChainInfo);
typedef int (*MgrGetNextFilterChainType)(ITEMID *filterChainID, ExtFilterChainInfo *filterChainInfo);

// [in] filterChainID - ID of filter chain 
// [out] filterChainInfo - this structure will be filled by manager to provide all informations about filter chain, caller must supply filterChainInfo->filterNames and filterChainInfo->filterIDs buffer and their size if he wants fill informations about filter names and/or filter IDs, filterChainInfo->filterNamesSize and filterChainInfo->filterIDsSize will contain required size of buffers
typedef int (*MgrGetFilterChainInfoType)(ITEMID filterChainID, ExtFilterChainInfo *filterChainInfo);

// [in] filterID - ID of filter
// [in] name - name of instance (no need to be unique)
// [out] instID - ID of filter instance
typedef int (*MgrCreateFilterInstType)(ITEMID filterID, const char *name, ITEMID *instID);

// [in] instID - ID of filter instance
typedef int (*MgrDeleteFilterInstType)(ITEMID instID);

// types of function for browsing created filter instances
// to enumerate all instances of given filter MgrGetFirstFilterInstType has to be called first, 
// return value 0 means that instID contains valid ID of existing filter instance
// use returned instID in subsequent calls of MgrGetNextFilterInstType, call it repeatedly until return value != 0
// [in] filterID - ID of existing filter (function info ID)
// [in/out] instID - instance ID of filter instance
// [out] name - name of filter instance (can be NULL)
typedef int (*MgrGetFirstFilterInstType)(ITEMID filterID, ITEMID *instID, char name[NAME_LENGTH]);
typedef int (*MgrGetNextFilterInstType)(ITEMID filterID, ITEMID *instID, char name[NAME_LENGTH]);


// [in] instID - instance ID of filter
// [in] idx - zero-based index of parameter
// [in] data - data for parameter
// [in] dataSize - size of data
typedef int (*MgrSetFilterParType)(ITEMID instID, int idx, byte *data, int dataSize);


// [in] instID - instance ID of filter
// [in] idx - zero-based index of parameter or -1, in case of -1, *dataSize will contain number of parameters of adjustable filters, (info will be unused so it can be NULL)
// [in/out] info - data for parameter, info->data can contain allocated buffer for param. value, if info->data is NULL info structure will be filled without data
// [in/out] dataSize - dataSize should contain size of allocated buffer in info->data (in bytes), after return it will contain required size of data buffer for parameter
typedef int (*MgrGetFilterParType)(ITEMID instID, int idx, ItemInfo *info, int *dataSize);


// [in] fileName - name of the file where filterChains will be saved. can be NULL, if NULL, default file name is used.
typedef int (*MgrSaveFilterChainsToFile)(const char *fileName);

// frame control
//

#define FCREATE_ZERO        0x0100      // created frame will be filled with zeros

// creates frame
// [out] frameID - ID of new created frame
// [in] width - width of frame
// [in] height - height of frame
// [in] flags - combination of type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE) and FCREATE_XXX flags
typedef int (*MgrCreateFrameType)(FRAMEID *frameID, u32 width, u32 height, int flags, const char *creatorName);

// read number of frames specified file
// [in] fileName - name of description or data file
// [out] frameCount - number of frames
typedef int (*MgrGetFrameCountType)(const char *fileName, int *frameCount);

// load frame from file, file can contain more than one frame
// [out] frameID - ID of new loaded frame
// [in] fileName - name of description or data file
// [in] idx - 0-based index of frame
typedef int (*MgrLoadFrameType)(FRAMEID *frameID, const char *fileName, int idx);

// save frame to file, if FSAVE_APPEND flag is set frame will be added to multi-frame file
// [in] frameID - ID of new loaded frame
// [in] fileName - name of data file
// [in] flags - bitwise combination of FSAVE_* flags see common.h for details
typedef int (*MgrSaveFrameType)(FRAMEID frameID, const char *fileName, u32 flags);

// makes copy of frame
// [in] origID - ID of original frame
// [out] newID - ID of new created copy
typedef int (*MgrDuplicateFrameType)(FRAMEID origID, FRAMEID *newID);

// frame browsing, return val 0 OK, > 0 no more frames, < 0 error
// [out] frameID - if return value is 0, frameID contains ID of first frame, use this ID for subsequent call of MgrGetNextFrameType
typedef int (*MgrGetFirstFrameType)(FRAMEID *frameID);

// frame browsing, return val 0 OK, > 0 no more frames, < 0 error
// [in/out] frameID - if return value is 0, frameID contains ID of browsed frame
typedef int (*MgrGetNextFrameType)(FRAMEID *frameID);

// open specified frame (increase reference count, if reference count drops to zero, frame is automatically deleted)
// [in] frameID - frame to open
// [out] refCount - actual reference count
typedef int (*MgrOpenFrameType)(FRAMEID frameID, u32 *refCount);

// close specified frame (decrease reference count, if reference count drops to zero, frame is automatically deleted)
// [in] frameID - frame to lock
// [out] refCount - actual reference count
typedef int (*MgrCloseFrameType)(FRAMEID frameID, u32 *refCount);

// locks frame for exclusive access
// [in] frameID - frame to lock
// [in] timeout - how long wait (in ms) for lock in ms (if lock will not be successfull in timeout milliseconds, function will return MPXERR_LOCK_TIMEOUT)
typedef int (*MgrLockFrameType)(FRAMEID frameID, u32 timeout);

// unlocks frame (this function has to be called after successful MgrLockFrameType or MgrGetLockedFrameBuffType)
// [in] frameID - frame to unlock
typedef int (*MgrUnlockFrameType)(FRAMEID frameID);

// retrieves type of selected frame
// [in] frameID - frame identification
// [out] type - type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrGetFrameTypeType)(FRAMEID frameID, Data_Types *type);

// sets type of selected frame (converts frame to specified format)
// [in] frameID - frame identification
// [in] type - type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrSetFrameTypeType)(FRAMEID frameID, Data_Types type);

// retrieves information about frame size
// [in] frameID - frame identification
// [out] width - width of frame
// [out] height - height of frame
typedef int (*MgrGetFrameSizeType)(FRAMEID frameID, u32 *width, u32 *height);

// sets frame size
// [in] frameID - frame identification
// [in] width - width of frame
// [in] height - height of frame
typedef int (*MgrSetFrameSizeType)(FRAMEID frameID, u32 width, u32 height);

// copy supplied buffer to frame internal data buffer
// [in] frameID - frame identification
// [in] buffer - buffer to copy
// [in] byteSize - size of buffer (in bytes)
typedef int (*MgrSetFrameDataType)(FRAMEID frameID, byte *buffer, u32 byteSize);

// retrieves data (copy) from frame in specified format
// [in] frameID - frame identification
// [out] buffer - output buffer for data
// [in/out] byteSize - size of supplied buffer (in bytes)
// [in] type - type of output format (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrGetFrameDataType)(FRAMEID frameID, byte *buffer, u32 *byteSize, Data_Types type);

// locks frame and retrieves pointer to internal data buffer
// [in] frameID - frame identification
// [out] buffer - pointer to internal data buffer
// [out] byteSize - size (in bytes) of internal data buffer
// [in] timeout - how long wait (in ms) for lock in ms (if lock will not be successfull in timeout milliseconds, function will return MPXERR_LOCK_TIMEOUT)
typedef int (*MgrGetLockedFrameBuffType)(FRAMEID frameID, byte **buffer, u32 *byteSize, u32 timeout);

// loads data file to existing frame
// [in] frameID - frame identification
// [in] fileName - name of data file
// [in] flags - flags describing data file format (bitwise combination of following flags: FSAVE_BINARY, FSAVE_ASCII, FSAVE_I16, FSAVE_U32, FSAVE_DOUBLE, FSAVE_NODESCFILE)
// flags FSAVE_BINARY/FSAVE_ASCII and flags FSAVE_I16/FSAVE_U32/FSAVE_DOUBLE are mutually exclusive
typedef int (*MgrLoadFrameDataType)(FRAMEID frameID, const char *fileName, u32 flags);

// sets frame name
// [in] frameID - frame identification
// [in] name - frame name
typedef int (*MgrSetFrameNameType)(FRAMEID frameID, const char *name);

// gets frame name
// [in] frameID - frame identification
// [out] name - frame name
typedef int (*MgrGetFrameNameType)(FRAMEID frameID, char name[MPX_MAX_PATH]);

// sets creator name (it should be plugin name that created frame)
// [in] frameID - frame identification
// [in] name - creator name
typedef int (*MgrSetFrameCreatorNameType)(FRAMEID frameID, const char *name);

// gets creator name (it should be plugin name that created frame)
// [in] frameID - frame identification
// [out] name - creator name
typedef int (*MgrGetFrameCreatorNameType)(FRAMEID frameID, char name[NAME_LENGTH]);

// sets "logical" path of frame ("logical" path defines context of frame)
// [in] frameID - frame identification
// [in] path - logical path (folders are separated by '|', e.g. "myplugin|filtered|device1"
typedef int (*MgrSetFrameLogPathType)(FRAMEID frameID, const char *path);

// gets "logical" path of frame ("logical" path defines context of frame)
// [in] frameID - frame identification
// [out] path - logical path (folders are separated by '|', e.g. "myplugin|filtered|device1"
typedef int (*MgrGetFrameLogPathType)(FRAMEID frameID, char path[MPX_MAX_PATH]);

// gets current frame file name 
// [in] frameID - frame identification
// [out] path - current frame file name (if exists - it was saved or loaded, otherwise "")
typedef int (*MgrGetFrameFileNameType)(FRAMEID frameID, char path[MPX_MAX_PATH]);

// adds attribute to frame
// [in] frameID - frame identification
// [in] name - name of attribute
// [in] desc - description of attribute
// [in] type - type of data of attribute
// [in] data - data of attribute ('count' of items of type 'type')
// [in] count - number of items of type 'type' in 'data' buffer
typedef int (*MgrAddFrameAttribType)(FRAMEID frameID, const char *name, const char *desc, Data_Types type, const byte *data, u32 count);

// sets value of selected attribute of selected frame
// [in] frameID - frame identification
// [in] name - name of attribute to set
// [in] data - data (value) of attribute
// [in] size - size of 'data' buffer in bytes
typedef int (*MgrSetFrameAttribType)(FRAMEID frameID, const char *name, byte *data, u32 size);

// gets value of selected attribute of selected frame
// [in] frameID - frame identification
// [in] name - name of attribute to get
// [in] data - buffer for attribute value
// [in/out] size - size of 'data' buffer in bytes, if 'data' buffer is not big enough MPXERR_BUFFER_SMALL is returned and size contains required size of buffer)
// [out] type - type of attribute (may be 0 if caller do not want this information)
typedef int (*MgrGetFrameAttribType)(FRAMEID frameID, const char *name, byte *data, u32 *size, Data_Types *type);

// removes selected attribute from frame
// [in] frameID - frame identification
// [in] name - name of attribute to remove
typedef int (*MgrRemoveAttribType)(FRAMEID frameID, const char *name);

// removes all attributes from frame
// [in] frameID - frame identification
typedef int (*MgrRemoveAllAttribsType)(FRAMEID frameID);

// browsing of frame attributes
// [in] frameID - frame identification
// [out] itemID - "browse handle", use it in subsequent calls of MgrGetFrameNextAttribType
// [out] attrib - ouput structure containing information about attribute
typedef int (*MgrGetFrameFirstAttribType)(FRAMEID frameID, ITEMID *itemID, ExtFrameAttrib *attrib);

// browsing of frame attributes
// [in] frameID - frame identification
// [in/out] itemID - "browse handle"
// [out] attrib - ouput structure containing information about attribute
typedef int (*MgrGetFrameNextAttribType)(FRAMEID frameID, ITEMID *itemID, ExtFrameAttrib *attrib);

// creates a new subframe
// [in] frameID - frame identification
// [out] subframeIdx - index of new subframe
// [in] width - width of subframe
// [in] height - height of subframe
// [in] flags - combination of type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE) and FCREATE_XXX flags
typedef int (*MgrCreateSubframeType)(FRAMEID frameID, int *subframeIdx, u32 width, u32 height, int flags);

// retrieves number of subframes in frame
// [in] frameID - frame identification
// [out] subframeCount - will be filled with number of subframes
typedef int (*MgrGetSubframeCountType)(FRAMEID frameID, int *subframeCount);

// retrieves type of selected subframe
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [out] type - type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrGetSubframeTypeType)(FRAMEID frameID, int subframeIdx, Data_Types *type);

// sets type of selected subframe (converts subframe to specified format)
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [in] type - type of frame (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrSetSubframeTypeType)(FRAMEID frameID, int subframeIdx, Data_Types type);

// retrieves information about subframe size
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [out] width - width of frame
// [out] height - height of frame
typedef int (*MgrGetSubframeSizeType)(FRAMEID frameID, int subframeIdx, u32 *width, u32 *height);

// sets subframe size
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [in] width - width of frame
// [in] height - height of frame
typedef int (*MgrSetSubframeSizeType)(FRAMEID frameID, int subframeIdx, u32 width, u32 height);

// copy supplied buffer to subframe internal data buffer
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [in] buffer - buffer to copy
// [in] byteSize - size of buffer (in bytes)
typedef int (*MgrSetSubframeDataType)(FRAMEID frameID, int subframeIdx, byte *buffer, u32 byteSize);

// retrieves data (copy) from subframe in specified format
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [out] buffer - output buffer for data
// [in/out] byteSize - size of supplied buffer (in bytes)
// [in] type - type of output format (TYPE_I16, TYPE_U32, TYPE_DOUBLE)
typedef int (*MgrGetSubframeDataType)(FRAMEID frameID, int subframeIdx, byte *buffer, u32 *byteSize, Data_Types type);

// locks frame and retrieves pointer to internal data buffer for specified subframe
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [out] buffer - pointer to internal data buffer
// [out] size - size (in bytes) of internal data buffer
// [in] timeout - how long wait (in ms) for lock in ms (if lock will not be successfull in timeout milliseconds, function will return MPXERR_LOCK_TIMEOUT)
typedef int (*MgrGetLockedSubframeBuffType)(FRAMEID frameID, int subframeIdx, byte **buffer, u32 *byteSize, u32 timeout);

// sets subframe name
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [in] name - frame name
typedef int (*MgrSetSubframeNameType)(FRAMEID frameID, int subframeIdx, const char *name);

// gets subframe name
// [in] frameID - frame identification
// [in] subframeIdx - subframe index
// [out] name - frame name
typedef int (*MgrGetSubframeNameType)(FRAMEID frameID, int subframeIdx, char name[MPX_MAX_PATH]);


#define SRVFRAME_MASKBITS   1       // mask bits
#define SRVFRAME_TESTBITS   2       // test bits
#define SRVFRAME_THLADJ     3       // THL adj. bits
#define SRVFRAME_THHADJ     4       // THH adj. bits (does not exist for Timepix)
#define SRVFRAME_MODE       5       // mode bits (Timepix)
#define SRVFRAME_GAIN       6       // mode bits (Mpx3)
#define SRVFRAME_LAST       7       // just convenient constant, not valid frame
// gets service frame ID of selected type for particular device
// [in] devID - device ID of medipix
// [in] type - type of service frame (SRVFRAME_xxx)
// [out] frameID - id of service frame (it is constant for certain FRAMEID during program run)
typedef int (*MgrGetServiceFrameType)(DEVID devID, u32 type, FRAMEID *frameID);


// MPXCTRL FUNCTION TYPES
//

// types of functions for enumerating found Medipix devices
// to enumerate all devices mpxCtrlGetFirstMpx has to be called first
// return value 0 means that *devID is valid ID of successfuly initialized Medipix
// use the devID in subsequent calls of mpxCtrlGetNextMpx, call it repeatedly until return value != 0
// [in/out] devID - this device ID uniquely identifies particular Medipix in MpxCtrl functions
// [out] count - after call will contain number of found devices; can be NULL
typedef int (*MpxCtrlGetFirstMpxType)(DEVID *devID, int *count);
typedef int (*MpxCtrlGetNextMpxType)(DEVID *devID);

// tries to find new devices (it will notify via MPXCTRL_CB_NEWMPX callback)
typedef int (*MpxCtrlFindNewMpxsType)();

// it will "reconnect" (reinitialize) the interface and connected medipix (for hot swap of medipix on interface)
// [in] devID - medipix device identification
typedef int (*MpxCtrlReconnectMpxType)(DEVID devID);

// type of function for getting number of "hardware info items" for particular Medipix
// "hardware info items" are used to access interface specific variables to obtain or set interface specifice information (e.g. muros clock frequency)
// [in] devID - medipix device identification
// [out] count - number of hw info items of this device
typedef int (*MpxCtrlGetHwInfoCountType)(DEVID devID, int *count);

// obtains selected HwInfoItem structure
// [in] devID - medipix device identification
// [in] index - zero-based index of "hardware info item", should be in <0, count-1> (count is obtained via mpxCtrlGetHwInfoCount)
// [out] infoItem - structure that will contain informations about selected item
// [in/out] dataSize - size of infoItem->data for "raw item data", if the dataSize is not big enough for item data, 
// the function returns error (!=0) and *dataSize will contain required size (to allow caller allocate big enough data buffer)
typedef int (*MpxCtrlGetHwInfoItemType)(DEVID devID, int index, HwInfoItem *infoItem, int *dataSize);

// set selected "hardware info item" data
// [in] devID - medipix device identification
// [in] index - zero-based index of "hardware info item", should be in <0, count-1> (count is obtained via mpxCtrlGetHwInfoCount)
// [in] data - pointer to data
// [in] dataSize - size of data (to allow sizecheck of data for certain hw info item)
typedef int (*MpxCtrlSetHwInfoItemType)(DEVID devID, int index, byte *data, int dataSize);	

// sets custom name for mpx device
// [in] devID - medipix device identification
// [in] name - custom name for mpx device
typedef int (*MpxCtrlSetCustomNameType)(DEVID devID, const char *name);

// gets custom name for mpx device
// [in] devID - medipix device identification
// [out] name - custom name for mpx device
typedef int (*MpxCtrlGetCustomNameType)(DEVID devID, char name[NAME_LENGTH]);

// try to locks medipix device for exclusive access
// [in] devID - medipix device identification
// [out] success - TRUE if locking was successful
// [in] timeout - how long wait (in ms) for lock in ms (if lock will not be successfull in timeout milliseconds, function will return MPXERR_LOCK_TIMEOUT)
typedef int (*MpxCtrlTryLockDeviceType)(DEVID devID, BOOL *success, u32 timeout);

// release locked device, MUST be called after each successful call to MpxCtrlTryLockDevice
// [in] devID - medipix device identification
typedef int (*MpxCtrlReleaseDeviceType)(DEVID devID);

// [in] devID - medipix device identification
// [out] id - id of thread that currently owns medipix device lock
typedef int (*MpxCtrlGetLockOwnerIDType)(DEVID devID, u32 *id);

// tries to revive selected device (e.g. after short disconnection)
// difference between MpxCtrlReviveMpxDeviceType and MpxCtrlInitMpxDeviceType is that init uses the same config as during start up ("safe values") while revive preserves current config (dacs, pix cfg, etc.)
// [in] devID - medipix device identification
typedef int (*MpxCtrlReviveMpxDeviceType)(DEVID devID);

// saves current configuration of particular Medipix device to selected medipix configuration file
// [in] devID - medipix device identification
// [in] fileName - filepathname of medipix configuration file, can be NULL, if it is NULL default fileName (based on chipboard ID is used)
typedef int (*MpxCtrlSaveMpxCfgType)(DEVID devID, const char *fileName);

// initialize particular Medipix device with values from medipix configuration file
// [in] devID - medipix device identification
// [in] fileName - filepathname of medipix configuration file, can be NULL, if it is NULL default fileName (based on chipboard ID is used)
typedef int (*MpxCtrlLoadMpxCfgType)(DEVID devID, const char *fileName);

// saves current configuration as default one (this configuration is used as default
// for new devices which do not have their own cfgs files created yet)
// [in] devID - medipix device identification
typedef int (*MpxCtrlSaveMpxCfgAsDefaultType)(DEVID devID);


// SET/GET ACQUISITION SETTING
//

// sets device specific acq. parameters
// [in] devID - medipix device identification
// [in] pars - pointer to structure describing mpx device-specific acq. settings (Mpx3SpecificAcqParams for Mpx3, unused for Mpx2)
// [in] size - structure size (for size check)
typedef int (*MpxCtrlSetDevSpecAcqParsType)(DEVID devID, byte *pars, u32 size);

// gets device specific acq. parameters
// [in] devID - medipix device identification
// [out] pars - pointer to structure describing mpx device-specific acq. settings (Mpx3SpecificAcqParams for Mpx3, unused for Mpx2)
// [in] size - structure size (for size check)
typedef int (*MpxCtrlGetDevSpecAcqParsType)(DEVID devID, byte *pars, u32 size);

// sets polarity of selected Medipix device
// [in] devID - medipix device identification
// [in] positive - TRUE for positive polarity, FALSE for negative
typedef int (*MpxCtrlSetPolarityType)(DEVID devID, BOOL positive);

// gets polarity setting for selected medipix device
// [in] devID - medipix device identification
// [out] positive - TRUE for positive polarity, FALSE for negative
typedef int (*MpxCtrlGetPolarityType)(DEVID devID, BOOL *positive);

// sets acquisition mode for selected Medipix device
// [in] devID - medipix device identification
// [in] mode - acq. mode to set (check ACQMODE_MANUAL, ACQMODE_xxxx)
typedef int (*MpxCtrlSetAcqModeType)(DEVID devID, int mode);

// gets currently selected acquisition mode for selected Medipix device
// [in] devID - medipix device identification
// [out] mode - current acq mode (check ACQMODE_MANUAL, ACQMODE_xxxx)
typedef int (*MpxCtrlGetAcqModeType)(DEVID devID, int *mode);

#define MPXCTRL_HWTIMER_ENABLE      0       // HW timer enabled
#define MPXCTRL_HWTIMER_DISABLE     1       // HW timer disabled (PC timer used)
#define MPXCTRL_HWTIMER_AUTO        2       // MpxCtrl library decides which timer will be used according to time of measurement and capabilities of device
// selects which timer is used for selected Medipix device
// [in] devID - medipix device identification
// [in] state - MPXCTRL_HWTIMER_ENABLE, MPXCTRL_HWTIMER_DISABLE, MPXCTRL_HWTIMER_AUTO
typedef int (*MpxCtrlSetHwTimerType)(DEVID devID, int state);

// gets HW timer setting
// [in] devID - medipix device identification
// [out] state - MPXCTRL_HWTIMER_ENABLE, MPXCTRL_HWTIMER_DISABLE, MPXCTRL_HWTIMER_AUTO (see definitions)
typedef int (*MpxCtrlGetHwTimerType)(DEVID devID, int *state);

// sets all DACs of all chips to default (typical for usage) values, depends on currently set polarity
// [in] devID - medipix device identification
typedef int (*MpxCtrlSetDACsDefaultType)(DEVID devID);


#define REFDAC_THL      0x01
#define REFDAC_THH      0x02
// sets DACs of particular chip or all chips of certain device
// [in] devID - medipix device identification
// [in] dacVals - array of DAC values
// [in] size - size of array dacVals (should be number of DACs, 13 original, 14 MXR or numberOfDacs*number of chips if chipNumber == ALLCHIPS)
// [in] chipNumber - zero-based index of chip or ALLCHIPS (all chips values are set)
typedef int (*MpxCtrlSetDACsType)(DEVID devID, DACTYPE *dacVals, int size, int chipNumber);

// gets DAC values for one chip of selected medipix device
// [in] devID - medipix device identification
// [out] dacVals - output array for DAC values
// [in] size - size of array dacVals (should be number of DACs, 13 original, 14 MXR or numberOfDacs*number of chips if chipNumber == ALLCHIPS)
// [in] chipNumber - zero-based index of chip or ALLCHIPS (all chips values are gset)
typedef int (*MpxCtrlGetDACsType)(DEVID devID, DACTYPE *dacVals, int size, int chipNumber);

// gets single DAC value of single chip or all chips of selected medipix device
// [in] devID - medipix device identification
// [out] dacVals - output for DAC analog values, size of array should be 1 for single value or numberOfChips to read from all chips (if its 2 or 2*numberOfChips, the second part will contain std. deviation of reading (if senseCount > 1))
// [in] size - size of dacVals array (for size check)
// [in] dacNumber - number from DACS_ORDER specifying which DAC analog value should be read
// [in] chipNumber - zero-based index of chip or ALLCHIPS if dac value should be read from all chips
// [in] senseCount - number of sensing (to receive mean of senseCount values)
typedef int (*MpxCtrlGetSingleDACAnalogType)(DEVID devID, double *dacVals, int size, int dacNumber, int chipNumber, int senseCount);

// gets all DACs values from specified chip or from all chips  of selected medipix device
// [in] devID - medipix device identification
// [out] dacVals - output array for DAC values, size has to be double[number of dacs] for single chip or le[numberOfChips*number of dacs] for all chips
// [in] size - size of dacVals array (for size check)
// [in] chipNumber - zero-based index of chip or ALLCHIPS if all the dacs values should be read from all chips
typedef int (*MpxCtrlGetDACsAnalogType)(DEVID devID, double *dacVals, int size, int chipNumber);

// sends last set DAC values to all chips of selected medipix device
// [in] devID - medipix device identification
typedef int (*MpxCtrlRefreshDACsType)(DEVID devID);

// sends last set DAC values to all chips of selected medipix device
// [in] devID - medipix device identification
// [out] names - *names is const array of names (const char *) of DACs of medipix chip
// [out] precisions - *precisions is const array of precisions of individual DACs in bits
// [out] size - *size of *names array, (e.g. 13 for normal mpx chip, 12 for MXR)
typedef int (*MpxCtrlGetDACsNamesType)(DEVID devID, const char * const **names, const int **precisions, int *size);

// sets external DAC value
// [in] devID - medipix device identification
// [in] dacNumber - medipix DAC index that should be replaced by external DAC, -1 means that ext DAC is not used
// [in] value - value in V, the valid range and step can be obtained from DevInfo structure
typedef int (*MpxCtrlSetExtDACType)(DEVID devID, int dacNumber, double value);

// gets external DAC value
// [in] devID - medipix device identification
// [out] dacNumber - medipix DAC index that is currently overloaded by external DAC, -1 means ext DAC is not used
// [out] value - value in V
typedef int (*MpxCtrlGetExtDACType)(DEVID devID, int *dacNumber, double *value);

// sets pixels configurations of one selected chip or all chips of selected medipix device
// [in] devID - medipix device identification
// [in] pixCfgs - array of pixels configurations, PixelCfg for MPX_ORIG and MPX_MXR and TpxPixCfg for MPX_TPX, size should be MATRIX_SIZE for one selected chip or numberOfChips*MATRIX_SIZE for all chips mode
// [in] size - byte size of pixCfgs array (for size check) (e.g. MATRIX_SIZE*sizeof(PixelCfg) )
// [in] chipNumber - zero-based number of selected chip or ALLCHIPS for "all chips mode"
typedef int (*MpxCtrlSetPixelsCfgType)(DEVID devID, byte *pixCfgs, int size, int chipNumber);

// gets pixels configurations of one selected chip or all chips of selected medipix device
// [in] devID - medipix device identification
// [out] pixCfgs - array for pixels configurations, PixelCfg for MPX_ORIG and MPX_MXR and TpxPixCfg for MPX_TPX, size should be MATRIX_SIZE for one selected chip or numberOfChips*MATRIX_SIZE for all chips mode
// [in] size - byte size of pixCfgs array (for size check) (e.g. MATRIX_SIZE*sizeof(PixelCfg) )
// [in] chipNumber - zero-based number of selected chip or ALLCHIPS for "all chips mode"
typedef int (*MpxCtrlGetPixelsCfgType)(DEVID devID, byte *pixCfgs, int size, int chipNumber);

// resets pixels configurations (nothing masked, no test bits, adj bits 7) of one selected chip or all chips of selected medipix device
// [in] devID - medipix device identification
// [in] chipNumber - zero-based number of selected chip or ALLCHIPS  for "all chips mode"
typedef int (*MpxCtrlResetPixelsCfgType)(DEVID devID, int chipNumber);

// sets pixels configurations of all chips of selected medipix device from one "super matrix" (e.g. for quad 512x512)
// [in] devID - medipix device identification
// [in] pixCfgs - buffer of pix. cfgs
// [in] size - size of buffer
typedef int (*MpxCtrlSetSuperMatrixPixCfgType)(DEVID devID, byte *pixCfgs, int size);

// gets pixels configurations of all chips of selected medipix device in one "super matrix"
// [in] devID - medipix device identification
// [out] pixCfgs - output buffer for pix. cfgs
// [in] size - size of buffer for size-check
typedef int (*MpxCtrlGetSuperMatrixPixCfgType)(DEVID devID, byte *pixCfgs, int size);

// sends last set pixels cfgs to all chips of selected medipix device
// [in] devID - medipix device identification
typedef int (*MpxCtrlRefreshPixelsCfgType)(DEVID devID);

// sets masked pixels suppression
// the distance is given by spacing parameter (min 1, max 256)
// [in] devID - medipix device identification
// [in] suppress - if TRUE masked pixels are set 0 instead of taken value (suppress unmaskable pixels)
typedef int (*MpxCtrlSetSuppressMaskedType)(DEVID devID, BOOL suppress);

// gets masked pixels suppression
// [in] devID - medipix device identification
// [out] suppress - gets settings of "masked suppression"
typedef int (*MpxCtrlGetSuppressMaskedType)(DEVID devID, BOOL *suppress);

// sets auto conversion of frame to "super matrix" for quad, enabled by default, useful to disable this for per chip operation
// [in] devID - medipix device identification
// [in] enable - if TRUE each frame is automatically converted to "super matrix" (512*512 matrix for quad) at the end (no effect for single)
typedef int (*MpxCtrlSetAutoConvToSMType)(DEVID devID, BOOL enable);

// gets settings of auto conversion of frame to "super matrix" for quad
// [in] devID - medipix device identification
// [out] enable - if TRUE each frame is automatically converted to "super matrix" (512*512 matrix for quad) at the end (no effect for single)
typedef int (*MpxCtrlGetAutoConvToSMType)(DEVID devID, BOOL *enable);

// function for conversion of "chip by chip" frame to "super matrix" frame (for quad)
// [in] devID - medipix device identification
// [in] chipByChip - input buffer containing frame where data are in chip by chip order
// [out] superMatrix - output buffer for super matrix frame (frame contains proper image)
// [in] buffSize - size of buffer in bytes (for size check)
// [in] buffType - buffer types (allowed values - TYPE_I16, TYPE_I32, TYPE_DOUBLE)
typedef int (*MpxCtrlConvToSuperMatrixType)(DEVID devID, const byte *chipByChip, byte *superMatrix, u32 buffSize, Data_Types buffType);

// function for conversion of "super matrix" frame to "chip by chip" frame (for quad)
// [in] devID - medipix device identification
// [in] superMatrix - input buffer with super matrix frame (frame contains proper image)
// [out] chipByChip - output buffer containing frame in chip by chip order
// [in] buffSize - size of buffer in bytes (for size check)
// [in] buffType - buffer types (allowed values - TYPE_I16, TYPE_I32, TYPE_DOUBLE)
typedef int (*MpxCtrlConvFromSuperMatrixType)(DEVID devID, const byte *superMatrix, byte *chipByChip, u32 buffSize, Data_Types buffType);

// function for setting chips layout of matrix
// [in] devID - medipix device identification
// [in] width - width of matrix in chips
// [in] height - height of matrix in chips
// [in] chips - list of custom ordered chip numbers (position of chips in matrix). Chips are filled to matrix as follow: [row, column]=chips[i], e.g for Quad (2x2): [0,0]=chips[0], [0,1]=chips[1], [1,0]=chips[2], [1,1]=chips[3]  
// [in] angles - list of rotation angles for each chip (0 = 0deg, 1 = 90deg, 2 = 180deg, 3 = 270deg)
// [in] createSubFrames - if TRUE, for each chip a subframe is created
typedef int (*MpxCtrlSetMatrixLayoutType)(DEVID devID, u16 width, u16 height, i32 *chips, i32 *angles, BOOL createSubFrames);

// function for getting chips layout of matrix
// [in] devID - medipix device identification
// [out] width - width of matrix in chips
// [out] height - height of matrix in chips
// [out] chips - list of custom ordered chip numbers (position of chips in matrix). Chips are filled to matrix as follow: [row, column]=chips[i], e.g for Quad (2x2): [0,0]=chips[0], [0,1]=chips[1], [1,0]=chips[2], [1,1]=chips[3]
// [out] angles - list of rotation angles for each chip (0 = 0deg, 1 = 90deg, 2 = 180deg, 3 = 270deg)
// [out] createSubFrames - if TRUE, for each chip a subframe is created
typedef int (*MpxCtrlGetMatrixLayoutType)(DEVID devID, u16 *width, u16 *height, i32 *chips, i32 *angles, BOOL *createSubFrames);

// loads pixels configurations (mask bit, test bit, and 3-bit threshold adjustements) from "binary pixels configuration" file
// [in] devID - medipix device identification
// [in] fileName - file name path of binary file, if it is NULL default filename based on chipboard ID is used
// [in] loadDacs - if TRUE, DACs are loaded from "$fileName.dacs"
typedef int (*MpxCtrlLoadPixelsCfgType)(DEVID devID, const char *fileName, BOOL loadDacs);

// saves pixels configurations (mask bit, test bit, and 3-bit threshold adjustements) to "binary pixels configuration" file
// [in] devID - medipix device identification
// [in] fileName - file name path of binary file, can be NULL, if it is NULL default fileName (based on chipboard ID is used)
// [in] saveDacs - if TRUE, current DACs are saved to file "$fileName.dacs"
typedef int (*MpxCtrlSavePixelsCfgType)(DEVID devID, const char *fileName, BOOL saveDacs);

// loads pixels configurations (mask bit, test bit, and 3-bit threshold adjustements) from several ASCII files
// [in] devID - medipix device identification
// [in] fileName - file name path of ASCII file containing part of pix. cfg.
// [in] part - PIXCFG_XXX flag specifying which part of pix. cfg. ASCII file contains (mask bit, test bit, THL adj...)
// [in] loadDacs - if TRUE, DACs are loaded from "$fileName.dacs"
typedef int (*MpxCtrlLoadPixelsCfgAsciiType)(DEVID devID, const char *fileName, int part, BOOL loadDacs);

// saves pixels configurations (mask bit, test bit, and 3-bit threshold adjustements) to several ASCII files
// [in] devID - medipix device identification
// [in] fileName - file name path for saving part of pix. cfg.
// [in] part - PIXCFG_XXX flag specifying which part of pix. cfg. should be save (mask bit, test bit, THL adj...)
// [in] saveDacs - if TRUE, current DACs are saved to file "$fileName.dacs"
typedef int (*MpxCtrlSavePixelsCfgAsciiType)(DEVID devID, const char *fileName, int part, BOOL saveDacs);


// ACQUISITION CONTROL
//

// perform acquisition in frame mode
// [in] devID - medipix device identification
// [in] numberOfFrames - acquisition count
// [in] timeOfEachAcq - time of each acquistion in seconds
// [in] fileFlags - combinations of format flags (use bitwise or "|") for saving (FSAVE_BINARY, FSAVE_ASCII, FSAVE_I16, FSAVE_U32, FSAVE_DOUBLE, FSAVE_NODESCFILE), if fileFlags=0 frames are held in memory
// [in] fileName - basename of filename (if fileFlags is set properly), resulting file name is created by appending acquisition number to basename
// flags FSAVE_BINARY/FSAVE_ASCII and flags FSAVE_I16/FSAVE_U32/FSAVE_DOUBLE are mutually exclusive
typedef int (*MpxCtrlPerformFrameAcqType)(DEVID devID, int numberOfFrames, double timeOfEachAcq, u32 fileFlags, const char *fileName);


// perform acquisition in integral mode
// [in] devID - medipix device identification
// [in] numberOfAcq - acquisition count
// [in] timeOfEachAcq - time of each acquistion in seconds
// [in] fileFlags - combinations of format flags (use bitwise or "|") for saving (FSAVE_BINARY, FSAVE_ASCII, FSAVE_I16, FSAVE_U32, FSAVE_DOUBLE, FSAVE_NODESCFILE)
// [in] fileName - filename (if fileFlags is set properly) to which integral frame will be automatically saved
typedef int (*MpxCtrlPerformIntegralAcqType)(DEVID devID, int numberOfAcq, double timeOfEachAcq, u32 fileFlags, const char *fileName);

// perform test pulse acquisition
// [in] devID - medipix device identification
// [in] spacing - distance between nonmasked pixels (number of subacq. is spacing*spacing)
// [in] pulseHeight - height of pulses, double[1] for mpx2 (pulse height in [V]), double[2] for mpx3 (charge in [ke])
// [in] period - period of pulses [s] (distance between pulses is same as length i.e. period/2)
// [in] pulseCount - number of pulses
// [in] manual - controls manual/automatic handling of spacing/ctpr, 0 = automatic, or pointer to column test pulse register, for MXR/TPX u32[1], for Mpx3 u32[8]
// [in] manualTPBits - if true test bit will be set ON in spacing algorithm only on pixels that have alreay test bit ON selected by user
typedef int (*MpxCtrlPerformTestPulseAcqType)(DEVID devID, int spacing, double *pulseHeight, double period, u32 pulseCount, u32 *manual, BOOL manualTPBits);

// perform full digital test (write random matrix, read it back and counts number of pixels where values agree)
// [in] devID - medipix device identification
// [out] goodPixels - number fo good pixels (custom, may be NULL)
// [out] frameID - if frameID is specified (custom, may be NULL), frame is created and its ID is stored in *frameID, caller is then responsible for closing frame
// [in] delay - delay between writing and reading matrix (in s)
typedef int (*MpxCtrlPerformDigitalTestType)(DEVID devID, u32 *goodPixels, FRAMEID *frameID, BOOL show, double delay);

// abort operation in progress
// [in] devID - medipix device identification
typedef int (*MpxCtrlAbortOperationType)(DEVID devID);

// SW trigger for acq. start/stop; can be also used to prematurely terminate acq. in other modes than SW triggered
// [in] devID - medipix device identification
// [in] trigger - trigger type (TRIGGER_ACQSTART/TRIGGER_ACQSTOP)
typedef int (*MpxCtrlTriggerType)(DEVID devID, int trigger);


// BUFFER CONTROL
//

// close opened frames
// [in] devID - medipix device identification
typedef int (*MpxCtrlCloseFramesType)(DEVID devID);

// copy frame from last acquisition to supplied i16[] buffer, this functionality is availaible for all acquisition modes (even for acquisition to files)
// this function can be used for asynchronous access to buffer (e.g. during acquisition, so buffer for error message should be provided
// [in] devID - medipix device identification
// [out] buffer - supplied buffer for frame
// [in] size - size of buffer (for size-check)
// [in] frameNumber - zero-based index of frame
typedef int (*MpxCtrlGetFrame16Type)(DEVID devID, i16 *buffer, u32 size, u32 frameNumber);

// copy frame from last acquisition to supplied u32[] buffer, this functionality is availaible for all acquisition modes (even for acquisition to files)
// this function can be used for asynchronous access to buffer (e.g. during acquisition, so buffer for error message should be provided
// [in] devID - medipix device identification
// [out] buffer - supplied buffer for frame
// [in] size - size of buffer (for size-check)
// [in] frameNumber - zero-based index of frame
typedef int (*MpxCtrlGetFrame32Type)(DEVID devID, u32 *buffer, u32 size, u32 frameNumber);

// copy frame from last acquisition to supplied double[] buffer, this functionality is availaible for all acquisition modes (even for acquisition to files)
// this function can be used for asynchronous access to buffer (e.g. during acquisition, so buffer for error message should be provided
// [in] devID - medipix device identification
// [out] buffer - supplied buffer for frame
// [in] size - size of buffer (for size-check)
// [in] frameNumber - zero-based index of frame
typedef int (*MpxCtrlGetFrameDoubleType)(DEVID devID, double *buffer, u32 size, u32 frameNumber);

// saves selected frame to file in various formats
// [in] devID - medipix device identification
// [in] fileName - filepathname of file, if output is set to multiple files (see flags parameter) this filename is a base name (final filename contains index suffix)
// [in] frameNumber - zero-based frame index, if frameNumber is ALLFRAMES all frames are saved
// [in] flags - bitwise combination of following flags: FSAVE_BINARY, FSAVE_ASCII, FSAVE_I16, FSAVE_U32, FSAVE_DOUBLE, FSAVE_NODESCFILE
// flags FSAVE_BINARY/FSAVE_ASCII and flags FSAVE_I16/FSAVE_U32/FSAVE_DOUBLE are mutually exclusive
typedef int (*MpxCtrlSaveFrameType)(DEVID devID, const char *fileName, int frameNumber, u32 flags);

// retrieve value of attribute from selected frame
// [in] devID - medipix device identification
// [in] frameNumber - zero-based index of frame from last series of acquisition
// [in] name - name of attribute 
// [out] value - output buffer for attribute
// [in/out] size - size of output buffer, if buffer is too small for data of selected attribute MPXERR_BUFFER_SMALL is returned and "size" contains required buffer size
// [out] type - type of attribute (may be 0 if caller do not want this information)
typedef int (*MpxCtrlGetFrameAttribType)(DEVID devID, int frameNumber, const char *name, byte *value, u32 *size, Data_Types *type);

// converts frameNumber to frameID
// if frame acquisition was performed to file and therefore there is not corresponding frame registered in manager the new frame is created and registered
// [in] devID - medipix device identification
// [in] frameNumber - zero-based index of frame from last series of acquisition
// [out] frameID - id of corresponding frame
typedef int (*MpxCtrlGetFrameIDType)(DEVID devID, int frameNumber, FRAMEID *frameID);

// INFO FUNCTIONS
//

// gets info about device (interface+medipix)
// [in] devID - medipix device identification
// [out] devInfo - info structure describing capabilities of interface+medipix
typedef int (*MpxCtrlGetDevInfoType)(DEVID devID, DevInfo *devInfo);

// gives basic information about selected medipix device
// [in] devID - medipix device identification
// [out] numberOfChips - number of chips
// [out] numberOfRows - number of rows to which is chips are placed in
// [out] chipBoardID - chipboard ID
// [out] ifaceName - name of hardware interface (muros, usb,... ) which is used
typedef int (*MpxCtrlGetMedipixInfoType)(DEVID devID, int *numberOfChips, int *numberOfRows, char chipBoardID[MPX_MAX_CHBID], char ifaceName[MPX_MAX_IFACENAME]);


// provides information about acquisition (in progress or completed), (acqNumber, ...) pointers can be NULL
// [in] devID - medipix device identification
// [out] acqNumber - zero-based acqusition number
// [out] acqTotalCount - total number of acquisition which was ordered
// [out] acqType - type of acqusition (possible output values - MPXCTRL_ACQTYPE_FRAME, MPXCTRL_ACQTYPE_FRAME_FILE, MPXCTRL_ACQTYPE_INTEGRAL, MPXCTRL_ACQTYPE_INTEGRAL_FILE)
// [out] frameFilled - number of frames that are available from last serie (in integral mode - number of integrated frames)
typedef int (*MpxCtrlGetAcqInfoType)(DEVID devID, int *acqNumber, int *acqTotalCount, int *acqType, u32 *frameFilled);
#define MPXCTRL_ACQTYPE_FRAME               0       // frames to memory
#define MPXCTRL_ACQTYPE_FRAME_FILE          1       // frames to files
#define MPXCTRL_ACQTYPE_INTEGRAL            2       // frames integrated to single frame in memory
#define MPXCTRL_ACQTYPE_INTEGRAL_FILE       3       // frames integrated to single file

// gets info/error message for selected medipix device
// MpxCtrl library registeres several callback events (see MPXCTRL_CB_XXX) - one of this is MPXCTRL_CB_INFOMSG
// when important/error condition occurred this event is set and plugins registered for this event can call in callback function mpxCtrlGetInfoMsg function to obtain this info/error message
// [in] devID - medipix device identification
// [out] msgType - info/error code
// [out] msg - pointer to info/error message
typedef int (*MpxCtrlGetInfoMsgType)(DEVID devID, int *msgType, const char **msg);


// structure conataining all relevant functions provided by manager, its description is given in types definitions
// version - version of API (for version checks, e.g. by CHECK_IFACE_VER macro)
//
typedef struct _FuncTableType
{
    int version;
    MgrGetCfgsPathType getCfgsPath;
    MgrLogMsgType logMsg;
    MgrLogMsgVType logMsgV;
    MgrLogShowWindowType logShowWindow;
    MgrManagedItemsShowWindowType managedItemsShowWindow;

    MgrAddPluginType addPlugin;

    MgrAddMenuItemType addMenuItem;
    MgrAddMpxMenuItemType addMpxMenuItem;    
    MgrRemoveMenuItemType removeMenuItem;
    MgrGetMpxMenuPathType getMpxMenuPath;
    MgrGetFirstMenuItemType getFirstMenuItem;
    MgrGetNextMenuItemType getNextMenuItem;
    MgrCallMenuItemByNameType callMenuItemByName;
    MgrCallMenuItemByIDType callMenuItemByID;

    MgrInvokeInUIThreadType invokeInUIThread;
    MgrAddMsgHandlerType addMsgHandler;
    MgrRemoveHandlerType removeMsgHandler;

    MgrAddFuncItemType addFuncItem;
    MgrRemoveFuncItemType removeFuncItem;
    MgrGetRegFirstFuncType getRegFirstFunc;
    MgrGetRegNextFuncType getRegNextFunc;
    MgrGetFuncItemIDType getFuncItemID;
    MgrGetFuncItemType getFuncItem;
    MgrCallFuncItemType callFuncItem;

    MgrAddCBEventType addCBEvent;
    MgrRemoveCBEventType removeCBEvent;    
    MgrGetRegFirstCBEventType getRegFirstCBEvent;
    MgrGetRegNextCBEventType getRegNextCBEvent;
    MgrSetCBEventType setCBEvent;
    MgrRegisterCallbackType registerCallback;
    MgrUnregisterCallbackType unregisterCallback;

    MgrAddFrameAttribTemplType addFrameAttribTempl;
    MgrRemoveFrameAttribTemplType removeFrameAttribTempl;

    MgrCreateFilterChainType createFilterChain;
    MgrRemoveFilterChainType removeFilterChain;
    MgrAddToFilterChainType addToFilterChain;
    MgrRemoveFromFilterChainType removeFromFilterChain;
    MgrGetFilteredFrameType getFilteredFrame;
    MgrGetFirstFilterChainType getFirstFilterChain;
    MgrGetNextFilterChainType getNextFilterChain;
    MgrGetFilterChainInfoType getFilterChainInfo;

    MgrCreateFilterInstType createFilterInst;
    MgrDeleteFilterInstType deleteFilterInst;
    MgrGetFirstFilterInstType getFirstFilterInst;
    MgrGetNextFilterInstType getNextFilterInst;
    MgrSetFilterParType setFilterPar;
    MgrGetFilterParType getFilterPar;
    MgrSaveFilterChainsToFile saveFilterChainsToFile;


    // FRAME CONTROL
    MgrCreateFrameType createFrame;
    MgrGetFrameCountType getFrameCount;
    MgrLoadFrameType loadFrame;
    MgrSaveFrameType saveFrame;
    MgrDuplicateFrameType duplicateFrame;
    MgrGetFirstFrameType getFirstFrame;
    MgrGetNextFrameType getNextFrame;
    MgrOpenFrameType openFrame;
    MgrCloseFrameType closeFrame;
    MgrLockFrameType lockFrame;
    MgrUnlockFrameType unlockFrame;
    MgrGetFrameTypeType getFrameType;
    MgrSetFrameTypeType setFrameType;
    MgrGetFrameSizeType getFrameSize;
    MgrSetFrameSizeType setFrameSize;
    MgrSetFrameDataType setFrameData;
    MgrGetFrameDataType getFrameData;
    MgrGetLockedFrameBuffType getLockedFrameBuff;
    MgrLoadFrameDataType loadFrameData;

    MgrSetFrameNameType setFrameName;
    MgrGetFrameNameType getFrameName;
    MgrSetFrameCreatorNameType setFrameCreatorName;
    MgrGetFrameCreatorNameType getFrameCreatorName;
    MgrSetFrameLogPathType setFrameLogPath;
    MgrGetFrameLogPathType getFrameLogPath;
    MgrGetFrameFileNameType getFrameFileName;
    MgrAddFrameAttribType addFrameAttrib;
    MgrSetFrameAttribType setFrameAttrib;
    MgrGetFrameAttribType getFrameAttrib;
    MgrRemoveAttribType removeAttrib;
    MgrRemoveAllAttribsType removeAllAttribs;
    MgrGetFrameFirstAttribType getFrameFirstAttrib;
    MgrGetFrameNextAttribType getFrameNextAttrib;

    MgrCreateSubframeType createSubframe;
    MgrGetSubframeCountType getSubframeCount;
    MgrGetSubframeTypeType getSubframeType;
    MgrSetSubframeTypeType setSubframeType;
    MgrGetSubframeSizeType getSubframeSize;
    MgrSetSubframeSizeType setSubframeSize;
    MgrSetSubframeDataType setSubframeData;
    MgrGetSubframeDataType getSubframeData;
    MgrGetLockedSubframeBuffType getLockedSubframeBuff;
    MgrSetSubframeNameType setSubframeName;
    MgrGetSubframeNameType getSubframeName;

    MgrGetServiceFrameType getServiceFrame;

    // MPXCTRL FUNCTIONS
    //
    MpxCtrlGetFirstMpxType mpxCtrlGetFirstMpx;
    MpxCtrlGetNextMpxType mpxCtrlGetNextMpx;
    MpxCtrlFindNewMpxsType mpxCtrlFindNewMpxs;
    MpxCtrlReconnectMpxType mpxCtrlReconnectMpx;

    MpxCtrlGetHwInfoCountType mpxCtrlGetHwInfoCount;
    MpxCtrlGetHwInfoItemType mpxCtrlGetHwInfoItem;
    MpxCtrlSetHwInfoItemType mpxCtrlSetHwInfoItem;

    //
    MpxCtrlSetCustomNameType mpxCtrlSetCustomName;
    MpxCtrlGetCustomNameType mpxCtrlGetCustomName;
    MpxCtrlTryLockDeviceType mpxCtrlTryLockDevice;
    MpxCtrlReleaseDeviceType mpxCtrlReleaseDevice;
    MpxCtrlGetLockOwnerIDType mpxCtrlGetLockOwnerID;
    MpxCtrlReviveMpxDeviceType mpxCtrlReviveMpxDevice;
    MpxCtrlSaveMpxCfgType mpxCtrlSaveMpxCfg;
    MpxCtrlLoadMpxCfgType mpxCtrlLoadMpxCfg;
    MpxCtrlSaveMpxCfgAsDefaultType mpxCtrlSaveMpxCfgAsDefault;

    // SET/GET ACQUISITION SETTING
    //
    MpxCtrlSetDevSpecAcqParsType mpxCtrlSetDevSpecAcqPars;
    MpxCtrlGetDevSpecAcqParsType mpxCtrlGetDevSpecAcqPars;
    MpxCtrlSetPolarityType mpxCtrlSetPolarity;
    MpxCtrlGetPolarityType mpxCtrlGetPolarity;
    MpxCtrlSetAcqModeType mpxCtrlSetAcqMode;
    MpxCtrlGetAcqModeType mpxCtrlGetAcqMode;
    MpxCtrlSetHwTimerType mpxCtrlSetHwTimer;
    MpxCtrlGetHwTimerType mpxCtrlGetHwTimer;
    MpxCtrlSetDACsDefaultType mpxCtrlSetDACsDefault;
    MpxCtrlSetDACsType mpxCtrlSetDACs;
    MpxCtrlGetDACsType mpxCtrlGetDACs;
    MpxCtrlGetSingleDACAnalogType mpxCtrlGetSingleDACAnalog;
    MpxCtrlGetDACsAnalogType mpxCtrlGetDACsAnalog;
    MpxCtrlRefreshDACsType mpxCtrlRefreshDACs;
    MpxCtrlGetDACsNamesType mpxCtrlGetDACsNames;
    MpxCtrlSetExtDACType mpxCtrlSetExtDAC;
    MpxCtrlGetExtDACType mpxCtrlGetExtDAC;

    MpxCtrlSetPixelsCfgType mpxCtrlSetPixelsCfg;
    MpxCtrlGetPixelsCfgType mpxCtrlGetPixelsCfg;
    MpxCtrlResetPixelsCfgType mpxCtrlResetPixelsCfg;
    MpxCtrlSetSuperMatrixPixCfgType mpxCtrlSetSuperMatrixPixCfg;
    MpxCtrlGetSuperMatrixPixCfgType mpxCtrlGetSuperMatrixPixCfg;
    MpxCtrlRefreshPixelsCfgType mpxCtrlRefreshPixelsCfg;
    MpxCtrlSetSuppressMaskedType mpxCtrlSetSuppressMasked;
    MpxCtrlGetSuppressMaskedType mpxCtrlGetSuppressMasked;
    MpxCtrlSetAutoConvToSMType mpxCtrlSetAutoConvToSM;
    MpxCtrlGetAutoConvToSMType mpxCtrlGetAutoConvToSM;
    MpxCtrlConvToSuperMatrixType mpxCtrlConvToSuperMatrix;
    MpxCtrlConvFromSuperMatrixType mpxCtrlConvFromSuperMatrix;
    MpxCtrlSetMatrixLayoutType mpxCtrlSetMatrixLayout;
    MpxCtrlGetMatrixLayoutType mpxCtrlGetMatrixLayout;

    MpxCtrlLoadPixelsCfgType mpxCtrlLoadPixelsCfg;
    MpxCtrlSavePixelsCfgType mpxCtrlSavePixelsCfg;
    MpxCtrlLoadPixelsCfgAsciiType mpxCtrlLoadPixelsCfgAscii;
    MpxCtrlSavePixelsCfgAsciiType mpxCtrlSavePixelsCfgAscii;

    // ACQUISITION CONTROL
    //
    MpxCtrlPerformIntegralAcqType mpxCtrlPerformIntegralAcq;
    MpxCtrlPerformFrameAcqType mpxCtrlPerformFrameAcq;
    MpxCtrlPerformTestPulseAcqType mpxCtrlPerformTestPulseAcq;
    MpxCtrlPerformDigitalTestType mpxCtrlPerformDigitalTest;
    MpxCtrlAbortOperationType mpxCtrlAbortOperation;
    MpxCtrlTriggerType mpxCtrlTrigger;

    // MPXCTRL FRAME CONTROL
    //
    MpxCtrlCloseFramesType mpxCtrlCloseFrames;
    MpxCtrlGetFrame16Type mpxCtrlGetFrame16;
    MpxCtrlGetFrame32Type mpxCtrlGetFrame32;
    MpxCtrlGetFrameDoubleType mpxCtrlGetFrameDouble;
    MpxCtrlSaveFrameType mpxCtrlSaveFrame;
    MpxCtrlGetFrameAttribType mpxCtrlGetFrameAttrib;
    MpxCtrlGetFrameIDType mpxCtrlGetFrameID;

    // INFO FUNCTIONS
    //
    MpxCtrlGetDevInfoType mpxCtrlGetDevInfo;
    MpxCtrlGetMedipixInfoType mpxCtrlGetMedipixInfo;
    MpxCtrlGetAcqInfoType mpxCtrlGetAcqInfo;
    MpxCtrlGetInfoMsgType mpxCtrlGetInfoMsg;
} FuncTableType;


// every plugin has to contain "InitMpxPlugin" function of this type for initialization
typedef u32 (*InitPluginType)(const FuncTableType * funcTable);


//==============================================================================================
// Helper Macros:

// current version of interface (e.g. 17 means 1.7.x versions)
#define MPXMGR_CURVERSION (206)

#ifdef WIN32
// macro for checking proper version of interface, it assumes that in plugin is defined macro PLUGIN_NAME which constitutes
// name of plugin (#define PLUGIN_NAME "myplugin")
// this macro should be placed on beginning of InitMpxPlugin function
#define CHECK_IFACE_VER \
    if (funcTable->version != MPXMGR_CURVERSION)\
    {\
        char str[256] = "";\
        _snprintf(str, 256, "Plugin \"%s\" was compiled with header files ver. %d, this version is %d, please recompile the plugin.", PLUGIN_NAME, MPXMGR_CURVERSION, funcTable->version);\
        ::MessageBox(NULL, str, "Plugin version check failed", MB_ICONEXCLAMATION | MB_OK);\
        return -1;\
    }

// Initialisation of a Plugin can be done using following Macro:
// Macro creates global variable mgr which is pointer to table of functions exported by Manager.
// Plugin can call Manager functions using mgr pointer.
// Macro contains declaration of PluginInit function. It have to be defined in c(pp) file.
// Function is called automatically during plugin initialisation by Manager.
#define PLUGIN_INIT \
    DWORD PluginInit();\
    const FuncTableType *mgr = NULL;\
    extern "C" __declspec(dllexport) DWORD InitMpxPlugin(const FuncTableType *funcTable)\
    {\
        CHECK_IFACE_VER\
        mgr = funcTable;\
        return PluginInit();\
    }\
    DWORD PluginInit()

// Extended version of previous MACRO containing DllMain function.
// Macro defines moreover global variable Module containing handle of DLL module.
// Macro contais begining of PluginInit function definition => body have to follow, if it is not desired put semicolon after macro
#define PLUGIN_INIT_EXTENDED \
    HINSTANCE Module=NULL; \
    BOOL APIENTRY DllMain( HANDLE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)\
    {\
        switch (ul_reason_for_call)\
        {\
            case DLL_PROCESS_ATTACH:\
                Module = (HINSTANCE) hModule;\
                break;\
        }\
        return TRUE;\
    }\
    PLUGIN_INIT
    
#else

// macro for checking proper version of interface, it assumes that in plugin is defined macro PLUGIN_NAME which constitutes
// name of plugin (#define PLUGIN_NAME "myplugin")
// this macro should be placed on beginning of InitMpxPlugin function
#define CHECK_IFACE_VER \
    if (funcTable->version != MPXMGR_CURVERSION)\
    {\
        char str[256] = "";\
        printf(str, 256, "Plugin \"%s\" was compiled with header files ver. %d, this version is %d, please recompile the plugin.", PLUGIN_NAME, MPXMGR_CURVERSION, funcTable->version);\
        return -1;\
    }

// Initialisation of a Plugin can be done using following Macro:
// Macro creates global variable mgr which is pointer to table of functions exported by Manager.
// Plugin can call Manager functions using mgr pointer.
// Macro contains declaration of PluginInit function. It have to be defined in c(pp) file.
// Function is called automatically during plugin initialisation by Manager.
#define PLUGIN_INIT \
    u32 PluginInit();\
    const FuncTableType *mgr = NULL;\
    extern "C"  u32 InitMpxPlugin(const FuncTableType *funcTable)\
    {\
        CHECK_IFACE_VER\
        mgr = funcTable;\
        return PluginInit();\
    }\
    u32 PluginInit()

#endif

#endif //MPXPLUGINMGRAPI_H
