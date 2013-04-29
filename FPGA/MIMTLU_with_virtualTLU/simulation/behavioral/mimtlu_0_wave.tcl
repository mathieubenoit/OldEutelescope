#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     mimtlu_0_wave.tcl (Fri Apr 19 11:19:14 2013)
#
#  Module   system_mimtlu_0_wrapper
#  Instance mimtlu_0
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}system_tb${ps}dut" }

  wave add $tbpath${ps}mimtlu_0${ps}TEST -into $id
  wave add $tbpath${ps}mimtlu_0${ps}CLOCK_Y3 -into $id
  wave add $tbpath${ps}mimtlu_0${ps}USER_CLOCK -into $id
  wave add $tbpath${ps}mimtlu_0${ps}TRIGGER_DUT -into $id
  wave add $tbpath${ps}mimtlu_0${ps}TRIGGER_COPY -into $id
  wave add $tbpath${ps}mimtlu_0${ps}BUSY_DUT -into $id
  wave add $tbpath${ps}mimtlu_0${ps}BUSY_COPY -into $id
  wave add $tbpath${ps}mimtlu_0${ps}DATA_ITR -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_ACLK -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_ARESETN -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_AWADDR -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_AWVALID -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_WDATA -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_WSTRB -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_WVALID -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_BREADY -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_ARADDR -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_ARVALID -into $id
# wave add $tbpath${ps}mimtlu_0${ps}S_AXI_RREADY -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_ARREADY -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_RDATA -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_RRESP -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_RVALID -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_WREADY -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_BRESP -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_BVALID -into $id
  wave add $tbpath${ps}mimtlu_0${ps}S_AXI_AWREADY -into $id

