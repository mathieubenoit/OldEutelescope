##############################################################################
## Filename:          C:\Users\mbenoit\Documents\FPGA_Projects\MIMTLU/drivers/mimtlu_v1_00_a/data/mimtlu_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Apr 18 10:32:33 2013 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "mimtlu" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
