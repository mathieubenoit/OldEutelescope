/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */

#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "microblaze_interrupts_i.h"
#include "xintc.h"
#include "xil_exception.h"
#include "xbasic_types.h"
#include "xstatus.h"
#include "xintc_l.h"
#include "xintc_i.h"


//int IntrStatus;
//int IpStatus;
//static XIntc InterruptController ;
int itr_cnt;

void MyTimestampInterruptHandler(void)
{

	xil_printf("interrupt \r\n");
	xil_printf("%d \r \n",itr_cnt);
	itr_cnt+=1;


	u32 *timestamp=0;
	timestamp = (u32*)XPAR_MIMTLU_0_BASEADDR;
	xil_printf("Timestamp : %d \r\n",*timestamp);


}

int main()
{
//init_platform();
    microblaze_enable_interrupts();

    itr_cnt=0;

    xil_printf("registering interrupt ! \r\n");
    XIntc_RegisterHandler(XPAR_MICROBLAZE_0_INTC_BASEADDR,XPAR_MICROBLAZE_0_INTC_MIMTLU_0_DATA_ITR_INTR,(XInterruptHandler)MyTimestampInterruptHandler,XPAR_MICROBLAZE_0_INTC_BASEADDR);
    XIntc_MasterEnable(XPAR_MICROBLAZE_0_INTC_BASEADDR);
    XIntc_EnableIntr(XPAR_MICROBLAZE_0_INTC_BASEADDR,XPAR_MIMTLU_0_DATA_ITR_MASK);

    xil_printf("Running \r\n");

    while (1)
    {
    };

    return 0;
}
