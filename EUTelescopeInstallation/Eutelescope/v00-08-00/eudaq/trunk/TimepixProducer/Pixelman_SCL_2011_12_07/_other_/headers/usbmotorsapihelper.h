/*
   Copyright 2004-2009 IEAP CTU
   Author: Tomas Holy (tomas.holy@utef.cvut.cz)
*/

#pragma once
#include "mpxpluginmgrapi.h"

class UsbMotorsApiHelper
{
public:
    CallbackFuncType cbMoveMotorFinished;

public:
    UsbMotorsApiHelper(CallbackFuncType cbMoveFinished = 0);
    int Initialize();

    static int MoveMotor(double destin, BOOL relative, const char *motorName);
    static int IsMotorMoving(const char *name, BOOL *isMoving);
    static int MotorInfo(u32 motorIdx, u32 *count = 0, char name[10] = 0, char type[64] = 0, double positionZero[2] = 0, double speedMinMax[2] = 0);

private:
    static PluginFuncType moveMotor;
    static PluginFuncType isMotorMoving;
    static PluginFuncType motorInfo;

    static INTPTR moveMotorPar;
    static INTPTR isMotorMovingPar;
    static INTPTR motorInfoPar;
};
