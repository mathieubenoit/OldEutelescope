#  Simulation Model Generator
#  Xilinx EDK 14.4 EDK_P.49d
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     top_level_ports_wave.tcl (Fri Apr 19 11:19:14 2013)
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}system_tb${ps}dut" }

wave add $tbpath${ps}rzq -into $id 
wave add $tbpath${ps}mcbx_dram_we_n -into $id 
wave add $tbpath${ps}mcbx_dram_udqs -into $id 
wave add $tbpath${ps}mcbx_dram_udm -into $id 
wave add $tbpath${ps}mcbx_dram_ras_n -into $id 
wave add $tbpath${ps}mcbx_dram_ldm -into $id 
wave add $tbpath${ps}mcbx_dram_dqs -into $id 
wave add $tbpath${ps}mcbx_dram_dq -into $id 
wave add $tbpath${ps}mcbx_dram_clk_n -into $id 
wave add $tbpath${ps}mcbx_dram_clk -into $id 
wave add $tbpath${ps}mcbx_dram_cke -into $id 
wave add $tbpath${ps}mcbx_dram_cas_n -into $id 
wave add $tbpath${ps}mcbx_dram_ba -into $id 
wave add $tbpath${ps}mcbx_dram_addr -into $id 
wave add $tbpath${ps}USB_Uart_sout -into $id 
wave add $tbpath${ps}USB_Uart_sin -into $id 
wave add $tbpath${ps}RESET -into $id 
wave add $tbpath${ps}LEDs_4Bits_TRI_O -into $id 
wave add $tbpath${ps}Ethernet_MAC_TX_EN -into $id 
wave add $tbpath${ps}Ethernet_MAC_TX_CLK -into $id 
wave add $tbpath${ps}Ethernet_MAC_TXD -into $id 
wave add $tbpath${ps}Ethernet_MAC_RX_ER -into $id 
wave add $tbpath${ps}Ethernet_MAC_RX_DV -into $id 
wave add $tbpath${ps}Ethernet_MAC_RX_CLK -into $id 
wave add $tbpath${ps}Ethernet_MAC_RXD -into $id 
wave add $tbpath${ps}Ethernet_MAC_PHY_RST_N -into $id 
wave add $tbpath${ps}Ethernet_MAC_MDIO -into $id 
wave add $tbpath${ps}Ethernet_MAC_MDC -into $id 
wave add $tbpath${ps}Ethernet_MAC_CRS -into $id 
wave add $tbpath${ps}Ethernet_MAC_COL -into $id 
wave add $tbpath${ps}DIP_Switches_4Bits_TRI_I -into $id 
wave add $tbpath${ps}CLK_66MHZ -into $id 
wave add $tbpath${ps}mimtlu_0_TEST_pin -into $id 
wave add $tbpath${ps}mimtlu_0_CLOCK_Y2_pin -into $id 
wave add $tbpath${ps}mimtlu_0_BUSY_DUT_pin -into $id 
wave add $tbpath${ps}mimtlu_0_USER_CLOCK_pin -into $id 
wave add $tbpath${ps}mimtlu_0_TRIGGER_DUT_pin -into $id 
wave add $tbpath${ps}mimtlu_0_TRIGGER_COPY_pin -into $id 
wave add $tbpath${ps}mimtlu_0_BUSY_COPY_pin -into $id 
wave add $tbpath${ps}mimtlu_0_CLOCK_Y3_pin -into $id 

