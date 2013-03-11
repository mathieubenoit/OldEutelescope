/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#include "stdafx.h"
#include "usbmotorsapihelper.h"

PluginFuncType UsbMotorsApiHelper::moveMotor = 0;
PluginFuncType UsbMotorsApiHelper::isMotorMoving = 0;
PluginFuncType UsbMotorsApiHelper::motorInfo = 0;

INTPTR UsbMotorsApiHelper::moveMotorPar = 0;
INTPTR UsbMotorsApiHelper::isMotorMovingPar = 0;
INTPTR UsbMotorsApiHelper::motorInfoPar = 0;

extern const FuncTableType *mgr;

#define MOTOR_PLUGINNAME        "usbsteppermotordriver"
#define FNAME_MOVEMOTOR         "Move Motor"
#define FNAME_ISRUNNING         "Motor Is Running"
#define FNAME_MOTORINFO         "Motor Info"
#define EVNAME_MOTORSTPPED      "Motor Stopped"


UsbMotorsApiHelper::UsbMotorsApiHelper(CallbackFuncType cbMoveFinished)
    : cbMoveMotorFinished(cbMoveFinished)
{
}

int UsbMotorsApiHelper::Initialize()
{
    ExtFunctionInfo efi;
    int failCount = 0;
    if (cbMoveMotorFinished)
    {
        if (mgr->registerCallback(MOTOR_PLUGINNAME, EVNAME_MOTORSTPPED, cbMoveMotorFinished, 0))
            failCount++;
    }

    if (mgr->getFuncItem(MOTOR_PLUGINNAME, FNAME_MOVEMOTOR, &efi) == 0)
    {
        moveMotor = efi.func;
        moveMotorPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(MOTOR_PLUGINNAME, FNAME_ISRUNNING, &efi) == 0)
    {
        isMotorMoving = efi.func;
        isMotorMovingPar = efi.userData;
    }
    else
        failCount++;

    if (mgr->getFuncItem(MOTOR_PLUGINNAME, FNAME_MOTORINFO, &efi) == 0)
    {
        motorInfo = efi.func;
        motorInfoPar = efi.userData;
    }
    else
        failCount++;

    return failCount;
}

int UsbMotorsApiHelper::MoveMotor(double destin, BOOL relative, const char *motorName)
{
    if (!moveMotor)
        return -1;
    #pragma pack(push, 1)
    struct InPars
    {
        double destination;
        BOOL relative;
        const char *motorName;
    } in = {destin, relative, motorName};
    #pragma pack(pop)
    return moveMotor(moveMotorPar, (byte *) &in, 0);
}

int UsbMotorsApiHelper::IsMotorMoving(const char *name, BOOL *isMoving)
{
    if (!isMotorMoving)
        return -1;
    else
        return isMotorMoving(isMotorMovingPar, (byte *)&name, (byte *)isMoving);
}

int UsbMotorsApiHelper::MotorInfo(u32 motorIdx, u32 *count, char *name, char *type, double *positionZero, double *speedMinMax)
{
    if (!motorInfo)
        return -1;
    #pragma pack(push, 1)
    struct
    {
        u32 count;
        char name[10];
        char type[64];
        double positionZero[2];
        double speedMinMax[2];
    } out;
    #pragma pack(pop)
    if (motorInfo(motorInfoPar, (byte *)&motorIdx, (byte *) &out) == 0)
    {
        if (count)
            *count = out.count;
        if (name)
            strncpy(name, out.name, 10);
        if (type)
            strncpy(type, out.type, 10);
        if (positionZero)
            memcpy(positionZero, out.positionZero, 2*sizeof(double));
        if (speedMinMax)
            memcpy(speedMinMax, out.speedMinMax, 2*sizeof(double));
        return 0;
    }
    return -1;
}
