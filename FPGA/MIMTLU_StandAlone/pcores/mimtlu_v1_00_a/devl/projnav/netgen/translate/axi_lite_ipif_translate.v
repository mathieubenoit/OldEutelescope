////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.49d
//  \   \         Application: netgen
//  /   /         Filename: axi_lite_ipif_translate.v
// /___/   /\     Timestamp: Tue Apr 23 11:48:49 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/translate -ofmt verilog -sim axi_lite_ipif.ngd axi_lite_ipif_translate.v 
// Device	: 6slx9csg324-2
// Input file	: axi_lite_ipif.ngd
// Output file	: C:\Users\mbenoit\Documents\FPGA_Projects\MIMTLU\pcores\mimtlu_v1_00_a\devl\projnav\netgen\translate\axi_lite_ipif_translate.v
// # of Modules	: 1
// Design Name	: axi_lite_ipif
// Xilinx        : C:\Xilinx\14.4\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module axi_lite_ipif (
  S_AXI_ACLK, S_AXI_ARESETN, S_AXI_AWVALID, S_AXI_WVALID, S_AXI_BREADY, S_AXI_ARVALID, S_AXI_RREADY, IP2Bus_WrAck, IP2Bus_RdAck, IP2Bus_Error, 
S_AXI_AWREADY, S_AXI_WREADY, S_AXI_BVALID, S_AXI_ARREADY, S_AXI_RVALID, Bus2IP_Clk, Bus2IP_Resetn, Bus2IP_RNW, S_AXI_AWADDR, S_AXI_WDATA, S_AXI_WSTRB
, S_AXI_ARADDR, IP2Bus_Data, S_AXI_BRESP, S_AXI_RDATA, S_AXI_RRESP, Bus2IP_Addr, Bus2IP_BE, Bus2IP_CS, Bus2IP_RdCE, Bus2IP_WrCE, Bus2IP_Data
);
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input S_AXI_AWVALID;
  input S_AXI_WVALID;
  input S_AXI_BREADY;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  input IP2Bus_WrAck;
  input IP2Bus_RdAck;
  input IP2Bus_Error;
  output S_AXI_AWREADY;
  output S_AXI_WREADY;
  output S_AXI_BVALID;
  output S_AXI_ARREADY;
  output S_AXI_RVALID;
  output Bus2IP_Clk;
  output Bus2IP_Resetn;
  output Bus2IP_RNW;
  input [31 : 0] S_AXI_AWADDR;
  input [31 : 0] S_AXI_WDATA;
  input [3 : 0] S_AXI_WSTRB;
  input [31 : 0] S_AXI_ARADDR;
  input [31 : 0] IP2Bus_Data;
  output [1 : 0] S_AXI_BRESP;
  output [31 : 0] S_AXI_RDATA;
  output [1 : 0] S_AXI_RRESP;
  output [31 : 0] Bus2IP_Addr;
  output [3 : 0] Bus2IP_BE;
  output [1 : 0] Bus2IP_CS;
  output [15 : 0] Bus2IP_RdCE;
  output [15 : 0] Bus2IP_WrCE;
  output [31 : 0] Bus2IP_Data;
  wire S_AXI_AWADDR_8_IBUF_0;
  wire S_AXI_AWADDR_7_IBUF_1;
  wire S_AXI_AWADDR_6_IBUF_2;
  wire S_AXI_AWADDR_5_IBUF_3;
  wire S_AXI_AWADDR_4_IBUF_4;
  wire S_AXI_AWADDR_3_IBUF_5;
  wire S_AXI_AWADDR_2_IBUF_6;
  wire S_AXI_AWADDR_1_IBUF_7;
  wire S_AXI_AWADDR_0_IBUF_8;
  wire S_AXI_ARADDR_8_IBUF_9;
  wire S_AXI_ARADDR_7_IBUF_10;
  wire S_AXI_ARADDR_6_IBUF_11;
  wire S_AXI_ARADDR_5_IBUF_12;
  wire S_AXI_ARADDR_4_IBUF_13;
  wire S_AXI_ARADDR_3_IBUF_14;
  wire S_AXI_ARADDR_2_IBUF_15;
  wire S_AXI_ARADDR_1_IBUF_16;
  wire S_AXI_ARADDR_0_IBUF_17;
  wire IP2Bus_Data_31_IBUF_18;
  wire IP2Bus_Data_30_IBUF_19;
  wire IP2Bus_Data_29_IBUF_20;
  wire IP2Bus_Data_28_IBUF_21;
  wire IP2Bus_Data_27_IBUF_22;
  wire IP2Bus_Data_26_IBUF_23;
  wire IP2Bus_Data_25_IBUF_24;
  wire IP2Bus_Data_24_IBUF_25;
  wire IP2Bus_Data_23_IBUF_26;
  wire IP2Bus_Data_22_IBUF_27;
  wire IP2Bus_Data_21_IBUF_28;
  wire IP2Bus_Data_20_IBUF_29;
  wire IP2Bus_Data_19_IBUF_30;
  wire IP2Bus_Data_18_IBUF_31;
  wire IP2Bus_Data_17_IBUF_32;
  wire IP2Bus_Data_16_IBUF_33;
  wire IP2Bus_Data_15_IBUF_34;
  wire IP2Bus_Data_14_IBUF_35;
  wire IP2Bus_Data_13_IBUF_36;
  wire IP2Bus_Data_12_IBUF_37;
  wire IP2Bus_Data_11_IBUF_38;
  wire IP2Bus_Data_10_IBUF_39;
  wire IP2Bus_Data_9_IBUF_40;
  wire IP2Bus_Data_8_IBUF_41;
  wire IP2Bus_Data_7_IBUF_42;
  wire IP2Bus_Data_6_IBUF_43;
  wire IP2Bus_Data_5_IBUF_44;
  wire IP2Bus_Data_4_IBUF_45;
  wire IP2Bus_Data_3_IBUF_46;
  wire IP2Bus_Data_2_IBUF_47;
  wire IP2Bus_Data_1_IBUF_48;
  wire IP2Bus_Data_0_IBUF_49;
  wire S_AXI_AWVALID_IBUF_50;
  wire S_AXI_WVALID_IBUF_51;
  wire S_AXI_BREADY_IBUF_52;
  wire S_AXI_RREADY_IBUF_53;
  wire IP2Bus_WrAck_IBUF_54;
  wire IP2Bus_RdAck_IBUF_55;
  wire IP2Bus_Error_IBUF_56;
  wire Bus2IP_Addr_8_OBUF_91;
  wire Bus2IP_Addr_7_OBUF_92;
  wire Bus2IP_Addr_6_OBUF_93;
  wire Bus2IP_Addr_5_OBUF_94;
  wire Bus2IP_Addr_4_OBUF_95;
  wire Bus2IP_Addr_3_OBUF_96;
  wire Bus2IP_Addr_2_OBUF_97;
  wire Bus2IP_Addr_1_OBUF_98;
  wire Bus2IP_Addr_0_OBUF_99;
  wire Bus2IP_RdCE_15_OBUF_102;
  wire Bus2IP_RdCE_14_OBUF_103;
  wire Bus2IP_RdCE_13_OBUF_104;
  wire Bus2IP_RdCE_12_OBUF_105;
  wire Bus2IP_RdCE_11_OBUF_106;
  wire Bus2IP_RdCE_10_OBUF_107;
  wire Bus2IP_RdCE_9_OBUF_108;
  wire Bus2IP_RdCE_8_OBUF_109;
  wire Bus2IP_RdCE_7_OBUF_110;
  wire Bus2IP_RdCE_6_OBUF_111;
  wire Bus2IP_RdCE_5_OBUF_112;
  wire Bus2IP_RdCE_4_OBUF_113;
  wire Bus2IP_RdCE_3_OBUF_114;
  wire Bus2IP_RdCE_2_OBUF_115;
  wire Bus2IP_RdCE_1_OBUF_116;
  wire Bus2IP_RdCE_0_OBUF_117;
  wire Bus2IP_WrCE_15_OBUF_118;
  wire Bus2IP_WrCE_14_OBUF_119;
  wire Bus2IP_WrCE_13_OBUF_120;
  wire Bus2IP_WrCE_12_OBUF_121;
  wire Bus2IP_WrCE_11_OBUF_122;
  wire Bus2IP_WrCE_10_OBUF_123;
  wire Bus2IP_WrCE_9_OBUF_124;
  wire Bus2IP_WrCE_8_OBUF_125;
  wire Bus2IP_WrCE_7_OBUF_126;
  wire Bus2IP_WrCE_6_OBUF_127;
  wire Bus2IP_WrCE_5_OBUF_128;
  wire Bus2IP_WrCE_4_OBUF_129;
  wire Bus2IP_WrCE_3_OBUF_130;
  wire Bus2IP_WrCE_2_OBUF_131;
  wire Bus2IP_WrCE_1_OBUF_132;
  wire Bus2IP_WrCE_0_OBUF_133;
  wire S_AXI_WDATA_31_IBUF_134;
  wire S_AXI_WDATA_30_IBUF_135;
  wire S_AXI_WDATA_29_IBUF_136;
  wire S_AXI_WDATA_28_IBUF_137;
  wire S_AXI_WDATA_27_IBUF_138;
  wire S_AXI_WDATA_26_IBUF_139;
  wire S_AXI_WDATA_25_IBUF_140;
  wire S_AXI_WDATA_24_IBUF_141;
  wire S_AXI_WDATA_23_IBUF_142;
  wire S_AXI_WDATA_22_IBUF_143;
  wire S_AXI_WDATA_21_IBUF_144;
  wire S_AXI_WDATA_20_IBUF_145;
  wire S_AXI_WDATA_19_IBUF_146;
  wire S_AXI_WDATA_18_IBUF_147;
  wire S_AXI_WDATA_17_IBUF_148;
  wire S_AXI_WDATA_16_IBUF_149;
  wire S_AXI_WDATA_15_IBUF_150;
  wire S_AXI_WDATA_14_IBUF_151;
  wire S_AXI_WDATA_13_IBUF_152;
  wire S_AXI_WDATA_12_IBUF_153;
  wire S_AXI_WDATA_11_IBUF_154;
  wire S_AXI_WDATA_10_IBUF_155;
  wire S_AXI_WDATA_9_IBUF_156;
  wire S_AXI_WDATA_8_IBUF_157;
  wire S_AXI_WDATA_7_IBUF_158;
  wire S_AXI_WDATA_6_IBUF_159;
  wire S_AXI_WDATA_5_IBUF_160;
  wire S_AXI_WDATA_4_IBUF_161;
  wire S_AXI_WDATA_3_IBUF_162;
  wire S_AXI_WDATA_2_IBUF_163;
  wire S_AXI_WDATA_1_IBUF_164;
  wire S_AXI_WDATA_0_IBUF_165;
  wire S_AXI_AWREADY_OBUF_166;
  wire \I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ;
  wire S_AXI_ARREADY_OBUF_168;
  wire \I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ;
  wire S_AXI_ACLK_IBUF_BUFG_170;
  wire S_AXI_ARESETN_IBUF_171;
  wire S_AXI_ARVALID_IBUF_172;
  wire S_AXI_BRESP_0_OBUF_173;
  wire Bus2IP_BE_3_OBUF_174;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In ;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd2-In_185 ;
  wire \I_SLAVE_ATTACHMENT/start ;
  wire \I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o ;
  wire \I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ;
  wire \I_SLAVE_ATTACHMENT/rst_190 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_208 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_209 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_210 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_211 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_11_212 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_10_213 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_9_214 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_8_215 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_7_216 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_6_217 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_5_218 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_4_219 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_220 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_221 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_222 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_223 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ;
  wire N2;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In1_226 ;
  wire \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In2_227 ;
  wire \I_SLAVE_ATTACHMENT/s_axi_bvalid_i_glue_set_466 ;
  wire \I_SLAVE_ATTACHMENT/s_axi_rvalid_i_glue_set_467 ;
  wire \I_SLAVE_ATTACHMENT/s_axi_bresp_i_1_rstpot_468 ;
  wire \I_SLAVE_ATTACHMENT/rst_rstpot ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_rstpot_470 ;
  wire \I_SLAVE_ATTACHMENT/Mmux_start11_471 ;
  wire \I_SLAVE_ATTACHMENT/Mmux_start11_cepot ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1_dpot ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0_dpot ;
  wire \I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ;
  wire \I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_dpot_477 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_dpot_478 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_dpot_479 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_dpot_480 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_dpot_481 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_dpot_482 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_dpot_483 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_dpot_484 ;
  wire S_AXI_ACLK_IBUF_485;
  wire N4;
  wire N6;
  wire VCC;
  wire GND;
  wire [1 : 1] \I_SLAVE_ATTACHMENT/s_axi_bresp_i ;
  wire [31 : 0] \I_SLAVE_ATTACHMENT/s_axi_rdata_i ;
  wire [1 : 1] \I_SLAVE_ATTACHMENT/s_axi_rresp_i ;
  wire [1 : 0] \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i ;
  wire [3 : 0] \I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt ;
  wire [3 : 0] \I_SLAVE_ATTACHMENT/Result ;
  wire [15 : 0] \I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i ;
  X_ZERO   XST_GND (
    .O(S_AXI_BRESP_0_OBUF_173)
  );
  X_ONE   XST_VCC (
    .O(Bus2IP_BE_3_OBUF_174)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In ),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt_3  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/Result [3]),
    .SRST(\I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o ),
    .O(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt_2  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/Result [2]),
    .SRST(\I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o ),
    .O(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [2]),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/Result [1]),
    .SRST(\I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o ),
    .O(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [1]),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt_0  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/Result [0]),
    .SRST(\I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o ),
    .O(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [0]),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd2  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/state_FSM_FFd2-In_185 ),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rresp_i_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Error_IBUF_56),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rresp_i [1]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_31  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_31_IBUF_18),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [31]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_30  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_30_IBUF_19),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [30]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_29  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_29_IBUF_20),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [29]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_28  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_28_IBUF_21),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [28]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_27  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_27_IBUF_22),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [27]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_26  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_26_IBUF_23),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [26]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_25  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_25_IBUF_24),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [25]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_24  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_24_IBUF_25),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [24]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_23  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_23_IBUF_26),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [23]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_22  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_22_IBUF_27),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [22]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_21  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_21_IBUF_28),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [21]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_20  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_20_IBUF_29),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [20]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_19  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_19_IBUF_30),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [19]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_18  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_18_IBUF_31),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [18]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_17  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_17_IBUF_32),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [17]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_16  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_16_IBUF_33),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [16]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_15  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_15_IBUF_34),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [15]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_14  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_14_IBUF_35),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [14]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_13  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_13_IBUF_36),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [13]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_12  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_12_IBUF_37),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [12]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_11  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_11_IBUF_38),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [11]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_10  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_10_IBUF_39),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [10]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_9  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_9_IBUF_40),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [9]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_8  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_8_IBUF_41),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [8]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_7  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_7_IBUF_42),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [7]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_6  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_6_IBUF_43),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [6]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_5  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_5_IBUF_44),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [5]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_4  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_4_IBUF_45),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [4]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_3  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_3_IBUF_46),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [3]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_2  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_2_IBUF_47),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [2]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_1_IBUF_48),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [1]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rdata_i_0  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o ),
    .I(IP2Bus_Data_0_IBUF_49),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [0]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_dpot_484 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_208 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_dpot_483 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_209 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_dpot_482 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_210 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_dpot_481 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_211 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_11  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [11]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_11_212 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_10  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [10]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_10_213 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_9  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [9]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_9_214 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_7  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [7]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_7_216 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_6  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [6]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_6_217 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_8  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [8]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_8_215 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_5  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [5]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_5_218 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_4  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/start ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [4]),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_4_219 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_dpot_480 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_220 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_dpot_479 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_221 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_dpot_478 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_222 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_dpot_477 ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_223 ),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0_dpot ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [0]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .CE(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot ),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1_dpot ),
    .SRST(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [1]),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_LUT3 #(
    .INIT ( 8'h6A ))
  \I_SLAVE_ATTACHMENT/Mcount_INCLUDE_DPHASE_TIMER.dpto_cnt_xor<2>11  (
    .ADR0(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [2]),
    .ADR1(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [0]),
    .ADR2(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [1]),
    .O(\I_SLAVE_ATTACHMENT/Result [2])
  );
  X_LUT4 #(
    .INIT ( 16'h6AAA ))
  \I_SLAVE_ATTACHMENT/Mcount_INCLUDE_DPHASE_TIMER.dpto_cnt_xor<3>11  (
    .ADR0(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .ADR1(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [0]),
    .ADR2(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [1]),
    .ADR3(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [2]),
    .O(\I_SLAVE_ATTACHMENT/Result [3])
  );
  X_LUT5 #(
    .INIT ( 32'h11111000 ))
  \I_SLAVE_ATTACHMENT/Mmux_start11  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR2(S_AXI_AWVALID_IBUF_50),
    .ADR3(S_AXI_WVALID_IBUF_51),
    .ADR4(S_AXI_ARVALID_IBUF_172),
    .O(\I_SLAVE_ATTACHMENT/start )
  );
  X_LUT2 #(
    .INIT ( 4'h9 ))
  \I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o1  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/GND_11_o_PWR_11_o_OR_13_o )
  );
  X_LUT2 #(
    .INIT ( 4'h6 ))
  \I_SLAVE_ATTACHMENT/Mcount_INCLUDE_DPHASE_TIMER.dpto_cnt_xor<1>11  (
    .ADR0(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [1]),
    .ADR1(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [0]),
    .O(\I_SLAVE_ATTACHMENT/Result [1])
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i11  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_0_IBUF_8),
    .ADR2(S_AXI_ARADDR_0_IBUF_17),
    .O(Bus2IP_Addr_0_OBUF_99)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i21  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_1_IBUF_7),
    .ADR2(S_AXI_ARADDR_1_IBUF_16),
    .O(Bus2IP_Addr_1_OBUF_98)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i31  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_2_IBUF_6),
    .ADR2(S_AXI_ARADDR_2_IBUF_15),
    .O(Bus2IP_Addr_2_OBUF_97)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i41  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_3_IBUF_5),
    .ADR2(S_AXI_ARADDR_3_IBUF_14),
    .O(Bus2IP_Addr_3_OBUF_96)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i51  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_4_IBUF_4),
    .ADR2(S_AXI_ARADDR_4_IBUF_13),
    .O(Bus2IP_Addr_4_OBUF_95)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i61  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_5_IBUF_3),
    .ADR2(S_AXI_ARADDR_5_IBUF_12),
    .O(Bus2IP_Addr_5_OBUF_94)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i71  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_6_IBUF_2),
    .ADR2(S_AXI_ARADDR_6_IBUF_11),
    .O(Bus2IP_Addr_6_OBUF_93)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i81  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_7_IBUF_1),
    .ADR2(S_AXI_ARADDR_7_IBUF_10),
    .O(Bus2IP_Addr_7_OBUF_92)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/Mmux_bus2ip_addr_i91  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_AWADDR_8_IBUF_0),
    .ADR2(S_AXI_ARADDR_8_IBUF_9),
    .O(Bus2IP_Addr_8_OBUF_91)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/state_GND_11_o_state[1]_equal_14_o1  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/GND_11_o_state[1]_equal_14_o )
  );
  X_LUT2 #(
    .INIT ( 4'hE ))
  \I_SLAVE_ATTACHMENT/rd_done1  (
    .ADR0(IP2Bus_RdAck_IBUF_55),
    .ADR1(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .O(S_AXI_ARREADY_OBUF_168)
  );
  X_LUT2 #(
    .INIT ( 4'hE ))
  \I_SLAVE_ATTACHMENT/wr_done1  (
    .ADR0(IP2Bus_WrAck_IBUF_54),
    .ADR1(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .O(S_AXI_AWREADY_OBUF_166)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<15>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_208 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_0_OBUF_133)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<14>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_209 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_1_OBUF_132)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<13>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_210 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_2_OBUF_131)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<12>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_211 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_3_OBUF_130)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<11>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_11_212 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_4_OBUF_129)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<10>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_10_213 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_5_OBUF_128)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<9>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_9_214 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_6_OBUF_127)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<8>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_8_215 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_7_OBUF_126)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<7>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_7_216 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_8_OBUF_125)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<6>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_6_217 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_9_OBUF_124)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<5>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_5_218 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_10_OBUF_123)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<4>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_4_219 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_11_OBUF_122)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<3>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_220 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_12_OBUF_121)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<2>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_221 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_13_OBUF_120)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<1>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_222 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_14_OBUF_119)
  );
  X_LUT2 #(
    .INIT ( 4'h2 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/wrce_out_i<0>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_223 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_WrCE_15_OBUF_118)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<15>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_208 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_0_OBUF_117)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<14>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_209 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_1_OBUF_116)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<13>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_210 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_2_OBUF_115)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<12>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_211 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_3_OBUF_114)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<11>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_11_212 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_4_OBUF_113)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<10>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_10_213 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_5_OBUF_112)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<9>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_9_214 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_6_OBUF_111)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<8>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_8_215 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_7_OBUF_110)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<7>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_7_216 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_8_OBUF_109)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<6>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_6_217 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_9_OBUF_108)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<5>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_5_218 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_10_OBUF_107)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<4>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_4_219 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_11_OBUF_106)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<3>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_220 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_12_OBUF_105)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<2>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_221 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_13_OBUF_104)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<1>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_222 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_14_OBUF_103)
  );
  X_LUT2 #(
    .INIT ( 4'h8 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/rdce_out_i<0>1  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_223 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .O(Bus2IP_RdCE_15_OBUF_102)
  );
  X_LUT4 #(
    .INIT ( 16'hFFFD ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr1  (
    .ADR0(S_AXI_ARESETN_IBUF_171),
    .ADR1(IP2Bus_RdAck_IBUF_55),
    .ADR2(IP2Bus_WrAck_IBUF_54),
    .ADR3(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/cs_ce_clr )
  );
  X_LUT4 #(
    .INIT ( 16'hF888 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd2-In_SW0  (
    .ADR0(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ),
    .ADR1(S_AXI_RREADY_IBUF_53),
    .ADR2(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ),
    .ADR3(S_AXI_BREADY_IBUF_52),
    .O(N2)
  );
  X_LUT5 #(
    .INIT ( 32'h00707070 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In1  (
    .ADR0(S_AXI_RREADY_IBUF_53),
    .ADR1(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ),
    .ADR2(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR3(S_AXI_BREADY_IBUF_52),
    .ADR4(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In1_226 )
  );
  X_LUT5 #(
    .INIT ( 32'h00FF0008 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In2  (
    .ADR0(S_AXI_WVALID_IBUF_51),
    .ADR1(S_AXI_AWVALID_IBUF_50),
    .ADR2(S_AXI_ARVALID_IBUF_172),
    .ADR3(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR4(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In2_227 )
  );
  X_BUF   S_AXI_ACLK_IBUF (
    .I(S_AXI_ACLK),
    .O(S_AXI_ACLK_IBUF_485)
  );
  X_BUF   S_AXI_AWADDR_8_IBUF (
    .I(S_AXI_AWADDR[8]),
    .O(S_AXI_AWADDR_8_IBUF_0)
  );
  X_BUF   S_AXI_AWADDR_7_IBUF (
    .I(S_AXI_AWADDR[7]),
    .O(S_AXI_AWADDR_7_IBUF_1)
  );
  X_BUF   S_AXI_AWADDR_6_IBUF (
    .I(S_AXI_AWADDR[6]),
    .O(S_AXI_AWADDR_6_IBUF_2)
  );
  X_BUF   S_AXI_AWADDR_5_IBUF (
    .I(S_AXI_AWADDR[5]),
    .O(S_AXI_AWADDR_5_IBUF_3)
  );
  X_BUF   S_AXI_AWADDR_4_IBUF (
    .I(S_AXI_AWADDR[4]),
    .O(S_AXI_AWADDR_4_IBUF_4)
  );
  X_BUF   S_AXI_AWADDR_3_IBUF (
    .I(S_AXI_AWADDR[3]),
    .O(S_AXI_AWADDR_3_IBUF_5)
  );
  X_BUF   S_AXI_AWADDR_2_IBUF (
    .I(S_AXI_AWADDR[2]),
    .O(S_AXI_AWADDR_2_IBUF_6)
  );
  X_BUF   S_AXI_AWADDR_1_IBUF (
    .I(S_AXI_AWADDR[1]),
    .O(S_AXI_AWADDR_1_IBUF_7)
  );
  X_BUF   S_AXI_AWADDR_0_IBUF (
    .I(S_AXI_AWADDR[0]),
    .O(S_AXI_AWADDR_0_IBUF_8)
  );
  X_BUF   S_AXI_WDATA_31_IBUF (
    .I(S_AXI_WDATA[31]),
    .O(S_AXI_WDATA_31_IBUF_134)
  );
  X_BUF   S_AXI_WDATA_30_IBUF (
    .I(S_AXI_WDATA[30]),
    .O(S_AXI_WDATA_30_IBUF_135)
  );
  X_BUF   S_AXI_WDATA_29_IBUF (
    .I(S_AXI_WDATA[29]),
    .O(S_AXI_WDATA_29_IBUF_136)
  );
  X_BUF   S_AXI_WDATA_28_IBUF (
    .I(S_AXI_WDATA[28]),
    .O(S_AXI_WDATA_28_IBUF_137)
  );
  X_BUF   S_AXI_WDATA_27_IBUF (
    .I(S_AXI_WDATA[27]),
    .O(S_AXI_WDATA_27_IBUF_138)
  );
  X_BUF   S_AXI_WDATA_26_IBUF (
    .I(S_AXI_WDATA[26]),
    .O(S_AXI_WDATA_26_IBUF_139)
  );
  X_BUF   S_AXI_WDATA_25_IBUF (
    .I(S_AXI_WDATA[25]),
    .O(S_AXI_WDATA_25_IBUF_140)
  );
  X_BUF   S_AXI_WDATA_24_IBUF (
    .I(S_AXI_WDATA[24]),
    .O(S_AXI_WDATA_24_IBUF_141)
  );
  X_BUF   S_AXI_WDATA_23_IBUF (
    .I(S_AXI_WDATA[23]),
    .O(S_AXI_WDATA_23_IBUF_142)
  );
  X_BUF   S_AXI_WDATA_22_IBUF (
    .I(S_AXI_WDATA[22]),
    .O(S_AXI_WDATA_22_IBUF_143)
  );
  X_BUF   S_AXI_WDATA_21_IBUF (
    .I(S_AXI_WDATA[21]),
    .O(S_AXI_WDATA_21_IBUF_144)
  );
  X_BUF   S_AXI_WDATA_20_IBUF (
    .I(S_AXI_WDATA[20]),
    .O(S_AXI_WDATA_20_IBUF_145)
  );
  X_BUF   S_AXI_WDATA_19_IBUF (
    .I(S_AXI_WDATA[19]),
    .O(S_AXI_WDATA_19_IBUF_146)
  );
  X_BUF   S_AXI_WDATA_18_IBUF (
    .I(S_AXI_WDATA[18]),
    .O(S_AXI_WDATA_18_IBUF_147)
  );
  X_BUF   S_AXI_WDATA_17_IBUF (
    .I(S_AXI_WDATA[17]),
    .O(S_AXI_WDATA_17_IBUF_148)
  );
  X_BUF   S_AXI_WDATA_16_IBUF (
    .I(S_AXI_WDATA[16]),
    .O(S_AXI_WDATA_16_IBUF_149)
  );
  X_BUF   S_AXI_WDATA_15_IBUF (
    .I(S_AXI_WDATA[15]),
    .O(S_AXI_WDATA_15_IBUF_150)
  );
  X_BUF   S_AXI_WDATA_14_IBUF (
    .I(S_AXI_WDATA[14]),
    .O(S_AXI_WDATA_14_IBUF_151)
  );
  X_BUF   S_AXI_WDATA_13_IBUF (
    .I(S_AXI_WDATA[13]),
    .O(S_AXI_WDATA_13_IBUF_152)
  );
  X_BUF   S_AXI_WDATA_12_IBUF (
    .I(S_AXI_WDATA[12]),
    .O(S_AXI_WDATA_12_IBUF_153)
  );
  X_BUF   S_AXI_WDATA_11_IBUF (
    .I(S_AXI_WDATA[11]),
    .O(S_AXI_WDATA_11_IBUF_154)
  );
  X_BUF   S_AXI_WDATA_10_IBUF (
    .I(S_AXI_WDATA[10]),
    .O(S_AXI_WDATA_10_IBUF_155)
  );
  X_BUF   S_AXI_WDATA_9_IBUF (
    .I(S_AXI_WDATA[9]),
    .O(S_AXI_WDATA_9_IBUF_156)
  );
  X_BUF   S_AXI_WDATA_8_IBUF (
    .I(S_AXI_WDATA[8]),
    .O(S_AXI_WDATA_8_IBUF_157)
  );
  X_BUF   S_AXI_WDATA_7_IBUF (
    .I(S_AXI_WDATA[7]),
    .O(S_AXI_WDATA_7_IBUF_158)
  );
  X_BUF   S_AXI_WDATA_6_IBUF (
    .I(S_AXI_WDATA[6]),
    .O(S_AXI_WDATA_6_IBUF_159)
  );
  X_BUF   S_AXI_WDATA_5_IBUF (
    .I(S_AXI_WDATA[5]),
    .O(S_AXI_WDATA_5_IBUF_160)
  );
  X_BUF   S_AXI_WDATA_4_IBUF (
    .I(S_AXI_WDATA[4]),
    .O(S_AXI_WDATA_4_IBUF_161)
  );
  X_BUF   S_AXI_WDATA_3_IBUF (
    .I(S_AXI_WDATA[3]),
    .O(S_AXI_WDATA_3_IBUF_162)
  );
  X_BUF   S_AXI_WDATA_2_IBUF (
    .I(S_AXI_WDATA[2]),
    .O(S_AXI_WDATA_2_IBUF_163)
  );
  X_BUF   S_AXI_WDATA_1_IBUF (
    .I(S_AXI_WDATA[1]),
    .O(S_AXI_WDATA_1_IBUF_164)
  );
  X_BUF   S_AXI_WDATA_0_IBUF (
    .I(S_AXI_WDATA[0]),
    .O(S_AXI_WDATA_0_IBUF_165)
  );
  X_BUF   S_AXI_ARADDR_8_IBUF (
    .I(S_AXI_ARADDR[8]),
    .O(S_AXI_ARADDR_8_IBUF_9)
  );
  X_BUF   S_AXI_ARADDR_7_IBUF (
    .I(S_AXI_ARADDR[7]),
    .O(S_AXI_ARADDR_7_IBUF_10)
  );
  X_BUF   S_AXI_ARADDR_6_IBUF (
    .I(S_AXI_ARADDR[6]),
    .O(S_AXI_ARADDR_6_IBUF_11)
  );
  X_BUF   S_AXI_ARADDR_5_IBUF (
    .I(S_AXI_ARADDR[5]),
    .O(S_AXI_ARADDR_5_IBUF_12)
  );
  X_BUF   S_AXI_ARADDR_4_IBUF (
    .I(S_AXI_ARADDR[4]),
    .O(S_AXI_ARADDR_4_IBUF_13)
  );
  X_BUF   S_AXI_ARADDR_3_IBUF (
    .I(S_AXI_ARADDR[3]),
    .O(S_AXI_ARADDR_3_IBUF_14)
  );
  X_BUF   S_AXI_ARADDR_2_IBUF (
    .I(S_AXI_ARADDR[2]),
    .O(S_AXI_ARADDR_2_IBUF_15)
  );
  X_BUF   S_AXI_ARADDR_1_IBUF (
    .I(S_AXI_ARADDR[1]),
    .O(S_AXI_ARADDR_1_IBUF_16)
  );
  X_BUF   S_AXI_ARADDR_0_IBUF (
    .I(S_AXI_ARADDR[0]),
    .O(S_AXI_ARADDR_0_IBUF_17)
  );
  X_BUF   IP2Bus_Data_31_IBUF (
    .I(IP2Bus_Data[31]),
    .O(IP2Bus_Data_31_IBUF_18)
  );
  X_BUF   IP2Bus_Data_30_IBUF (
    .I(IP2Bus_Data[30]),
    .O(IP2Bus_Data_30_IBUF_19)
  );
  X_BUF   IP2Bus_Data_29_IBUF (
    .I(IP2Bus_Data[29]),
    .O(IP2Bus_Data_29_IBUF_20)
  );
  X_BUF   IP2Bus_Data_28_IBUF (
    .I(IP2Bus_Data[28]),
    .O(IP2Bus_Data_28_IBUF_21)
  );
  X_BUF   IP2Bus_Data_27_IBUF (
    .I(IP2Bus_Data[27]),
    .O(IP2Bus_Data_27_IBUF_22)
  );
  X_BUF   IP2Bus_Data_26_IBUF (
    .I(IP2Bus_Data[26]),
    .O(IP2Bus_Data_26_IBUF_23)
  );
  X_BUF   IP2Bus_Data_25_IBUF (
    .I(IP2Bus_Data[25]),
    .O(IP2Bus_Data_25_IBUF_24)
  );
  X_BUF   IP2Bus_Data_24_IBUF (
    .I(IP2Bus_Data[24]),
    .O(IP2Bus_Data_24_IBUF_25)
  );
  X_BUF   IP2Bus_Data_23_IBUF (
    .I(IP2Bus_Data[23]),
    .O(IP2Bus_Data_23_IBUF_26)
  );
  X_BUF   IP2Bus_Data_22_IBUF (
    .I(IP2Bus_Data[22]),
    .O(IP2Bus_Data_22_IBUF_27)
  );
  X_BUF   IP2Bus_Data_21_IBUF (
    .I(IP2Bus_Data[21]),
    .O(IP2Bus_Data_21_IBUF_28)
  );
  X_BUF   IP2Bus_Data_20_IBUF (
    .I(IP2Bus_Data[20]),
    .O(IP2Bus_Data_20_IBUF_29)
  );
  X_BUF   IP2Bus_Data_19_IBUF (
    .I(IP2Bus_Data[19]),
    .O(IP2Bus_Data_19_IBUF_30)
  );
  X_BUF   IP2Bus_Data_18_IBUF (
    .I(IP2Bus_Data[18]),
    .O(IP2Bus_Data_18_IBUF_31)
  );
  X_BUF   IP2Bus_Data_17_IBUF (
    .I(IP2Bus_Data[17]),
    .O(IP2Bus_Data_17_IBUF_32)
  );
  X_BUF   IP2Bus_Data_16_IBUF (
    .I(IP2Bus_Data[16]),
    .O(IP2Bus_Data_16_IBUF_33)
  );
  X_BUF   IP2Bus_Data_15_IBUF (
    .I(IP2Bus_Data[15]),
    .O(IP2Bus_Data_15_IBUF_34)
  );
  X_BUF   IP2Bus_Data_14_IBUF (
    .I(IP2Bus_Data[14]),
    .O(IP2Bus_Data_14_IBUF_35)
  );
  X_BUF   IP2Bus_Data_13_IBUF (
    .I(IP2Bus_Data[13]),
    .O(IP2Bus_Data_13_IBUF_36)
  );
  X_BUF   IP2Bus_Data_12_IBUF (
    .I(IP2Bus_Data[12]),
    .O(IP2Bus_Data_12_IBUF_37)
  );
  X_BUF   IP2Bus_Data_11_IBUF (
    .I(IP2Bus_Data[11]),
    .O(IP2Bus_Data_11_IBUF_38)
  );
  X_BUF   IP2Bus_Data_10_IBUF (
    .I(IP2Bus_Data[10]),
    .O(IP2Bus_Data_10_IBUF_39)
  );
  X_BUF   IP2Bus_Data_9_IBUF (
    .I(IP2Bus_Data[9]),
    .O(IP2Bus_Data_9_IBUF_40)
  );
  X_BUF   IP2Bus_Data_8_IBUF (
    .I(IP2Bus_Data[8]),
    .O(IP2Bus_Data_8_IBUF_41)
  );
  X_BUF   IP2Bus_Data_7_IBUF (
    .I(IP2Bus_Data[7]),
    .O(IP2Bus_Data_7_IBUF_42)
  );
  X_BUF   IP2Bus_Data_6_IBUF (
    .I(IP2Bus_Data[6]),
    .O(IP2Bus_Data_6_IBUF_43)
  );
  X_BUF   IP2Bus_Data_5_IBUF (
    .I(IP2Bus_Data[5]),
    .O(IP2Bus_Data_5_IBUF_44)
  );
  X_BUF   IP2Bus_Data_4_IBUF (
    .I(IP2Bus_Data[4]),
    .O(IP2Bus_Data_4_IBUF_45)
  );
  X_BUF   IP2Bus_Data_3_IBUF (
    .I(IP2Bus_Data[3]),
    .O(IP2Bus_Data_3_IBUF_46)
  );
  X_BUF   IP2Bus_Data_2_IBUF (
    .I(IP2Bus_Data[2]),
    .O(IP2Bus_Data_2_IBUF_47)
  );
  X_BUF   IP2Bus_Data_1_IBUF (
    .I(IP2Bus_Data[1]),
    .O(IP2Bus_Data_1_IBUF_48)
  );
  X_BUF   IP2Bus_Data_0_IBUF (
    .I(IP2Bus_Data[0]),
    .O(IP2Bus_Data_0_IBUF_49)
  );
  X_BUF   S_AXI_ARESETN_IBUF (
    .I(S_AXI_ARESETN),
    .O(S_AXI_ARESETN_IBUF_171)
  );
  X_BUF   S_AXI_AWVALID_IBUF (
    .I(S_AXI_AWVALID),
    .O(S_AXI_AWVALID_IBUF_50)
  );
  X_BUF   S_AXI_WVALID_IBUF (
    .I(S_AXI_WVALID),
    .O(S_AXI_WVALID_IBUF_51)
  );
  X_BUF   S_AXI_BREADY_IBUF (
    .I(S_AXI_BREADY),
    .O(S_AXI_BREADY_IBUF_52)
  );
  X_BUF   S_AXI_ARVALID_IBUF (
    .I(S_AXI_ARVALID),
    .O(S_AXI_ARVALID_IBUF_172)
  );
  X_BUF   S_AXI_RREADY_IBUF (
    .I(S_AXI_RREADY),
    .O(S_AXI_RREADY_IBUF_53)
  );
  X_BUF   IP2Bus_WrAck_IBUF (
    .I(IP2Bus_WrAck),
    .O(IP2Bus_WrAck_IBUF_54)
  );
  X_BUF   IP2Bus_RdAck_IBUF (
    .I(IP2Bus_RdAck),
    .O(IP2Bus_RdAck_IBUF_55)
  );
  X_BUF   IP2Bus_Error_IBUF (
    .I(IP2Bus_Error),
    .O(IP2Bus_Error_IBUF_56)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_bvalid_i  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_glue_set_466 ),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_rvalid_i  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_glue_set_467 ),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_SFF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/s_axi_bresp_i_1  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/s_axi_bresp_i_1_rstpot_468 ),
    .SRST(\I_SLAVE_ATTACHMENT/rst_190 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_bresp_i [1]),
    .CE(VCC),
    .SET(GND),
    .RST(GND),
    .SSET(GND)
  );
  X_FF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/rst  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/rst_rstpot ),
    .O(\I_SLAVE_ATTACHMENT/rst_190 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND)
  );
  X_FF #(
    .INIT ( 1'b0 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg  (
    .CLK(S_AXI_ACLK_IBUF_BUFG_170),
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_rstpot_470 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .CE(VCC),
    .SET(GND),
    .RST(GND)
  );
  X_LUT6 #(
    .INIT ( 64'h2000000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[7].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_4_OBUF_95),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_3_OBUF_96),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_8_OBUF_91),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [11])
  );
  X_LUT6 #(
    .INIT ( 64'h0020000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[6].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_4_OBUF_95),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_3_OBUF_96),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_8_OBUF_91),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [10])
  );
  X_LUT6 #(
    .INIT ( 64'h0020000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[3].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_2_OBUF_97),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_3_OBUF_96),
    .ADR3(Bus2IP_Addr_4_OBUF_95),
    .ADR4(Bus2IP_Addr_8_OBUF_91),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [7])
  );
  X_LUT6 #(
    .INIT ( 64'h0000002000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[2].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_3_OBUF_96),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_8_OBUF_91),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_4_OBUF_95),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [6])
  );
  X_LUT6 #(
    .INIT ( 64'h0800000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[11].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_3_OBUF_96),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_4_OBUF_95),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_2_OBUF_97),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [15])
  );
  X_LUT6 #(
    .INIT ( 64'h0000080000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[10].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_3_OBUF_96),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_4_OBUF_95),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_2_OBUF_97),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [14])
  );
  X_LUT6 #(
    .INIT ( 64'h0000080000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[9].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_2_OBUF_97),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_4_OBUF_95),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_3_OBUF_96),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [13])
  );
  X_LUT6 #(
    .INIT ( 64'h0000000800000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[8].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_8_OBUF_91),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_4_OBUF_95),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_3_OBUF_96),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [12])
  );
  X_LUT6 #(
    .INIT ( 64'h0020000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[5].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_2_OBUF_97),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_4_OBUF_95),
    .ADR3(Bus2IP_Addr_3_OBUF_96),
    .ADR4(Bus2IP_Addr_8_OBUF_91),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [9])
  );
  X_LUT6 #(
    .INIT ( 64'h0000002000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[4].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_4_OBUF_95),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_8_OBUF_91),
    .ADR3(Bus2IP_Addr_3_OBUF_96),
    .ADR4(Bus2IP_Addr_2_OBUF_97),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [8])
  );
  X_LUT6 #(
    .INIT ( 64'h0000002000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[1].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_2_OBUF_97),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_8_OBUF_91),
    .ADR3(Bus2IP_Addr_3_OBUF_96),
    .ADR4(Bus2IP_Addr_4_OBUF_95),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [5])
  );
  X_LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[1].PER_CE_GEN[0].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(Bus2IP_Addr_8_OBUF_91),
    .ADR1(Bus2IP_Addr_5_OBUF_94),
    .ADR2(Bus2IP_Addr_3_OBUF_96),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_4_OBUF_95),
    .ADR5(\I_SLAVE_ATTACHMENT/start ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [4])
  );
  X_LUT4 #(
    .INIT ( 16'hBA8A ))
  \I_SLAVE_ATTACHMENT/s_axi_bresp_i_1_rstpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/s_axi_bresp_i [1]),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR2(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR3(IP2Bus_Error_IBUF_56),
    .O(\I_SLAVE_ATTACHMENT/s_axi_bresp_i_1_rstpot_468 )
  );
  X_LUT6 #(
    .INIT ( 64'hAAAFAAAFAAA2AAAA ))
  \I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_rstpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_224 ),
    .ADR1(S_AXI_AWVALID_IBUF_50),
    .ADR2(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR3(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR4(S_AXI_WVALID_IBUF_51),
    .ADR5(S_AXI_ARVALID_IBUF_172),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/Bus_RNW_reg_rstpot_470 )
  );
  X_LUT6 #(
    .INIT ( 64'h4440FFFF44404440 ))
  \I_SLAVE_ATTACHMENT/s_axi_bvalid_i_glue_set  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR2(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .ADR3(IP2Bus_WrAck_IBUF_54),
    .ADR4(S_AXI_BREADY_IBUF_52),
    .ADR5(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_glue_set_466 )
  );
  X_LUT6 #(
    .INIT ( 64'h4440FFFF44404440 ))
  \I_SLAVE_ATTACHMENT/s_axi_rvalid_i_glue_set  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR2(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .ADR3(IP2Bus_RdAck_IBUF_55),
    .ADR4(S_AXI_RREADY_IBUF_53),
    .ADR5(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ),
    .O(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_glue_set_467 )
  );
  X_LUT6 #(
    .INIT ( 64'h77756664FFFDEEEC ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd2-In  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR2(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .ADR3(IP2Bus_WrAck_IBUF_54),
    .ADR4(S_AXI_ARVALID_IBUF_172),
    .ADR5(N2),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd2-In_185 )
  );
  X_LUT6 #(
    .INIT ( 64'h00CA000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[0].PER_CE_GEN[3].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(S_AXI_AWADDR_2_IBUF_6),
    .ADR1(S_AXI_ARADDR_2_IBUF_15),
    .ADR2(S_AXI_ARVALID_IBUF_172),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_3_OBUF_96),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [3])
  );
  X_LUT6 #(
    .INIT ( 64'h0053000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[0].PER_CE_GEN[2].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(S_AXI_ARADDR_2_IBUF_15),
    .ADR1(S_AXI_AWADDR_2_IBUF_6),
    .ADR2(S_AXI_ARVALID_IBUF_172),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_3_OBUF_96),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [2])
  );
  X_LUT6 #(
    .INIT ( 64'h0053000000000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[0].PER_CE_GEN[1].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(S_AXI_ARADDR_3_IBUF_14),
    .ADR1(S_AXI_AWADDR_3_IBUF_5),
    .ADR2(S_AXI_ARVALID_IBUF_172),
    .ADR3(Bus2IP_Addr_8_OBUF_91),
    .ADR4(Bus2IP_Addr_2_OBUF_97),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [1])
  );
  X_LUT6 #(
    .INIT ( 64'h0000005300000000 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/MEM_DECODE_GEN[0].PER_CE_GEN[0].MULTIPLE_CES_THIS_CS_GEN.CE_I/Mmux_CS11  (
    .ADR0(S_AXI_ARADDR_8_IBUF_9),
    .ADR1(S_AXI_AWADDR_8_IBUF_0),
    .ADR2(S_AXI_ARVALID_IBUF_172),
    .ADR3(Bus2IP_Addr_2_OBUF_97),
    .ADR4(Bus2IP_Addr_3_OBUF_96),
    .ADR5(\I_SLAVE_ATTACHMENT/Mmux_start11_471 ),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [0])
  );
  X_LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF4440 ))
  \I_SLAVE_ATTACHMENT/state_FSM_FFd1-In3  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR1(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR2(IP2Bus_RdAck_IBUF_55),
    .ADR3(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [3]),
    .ADR4(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In1_226 ),
    .ADR5(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In2_227 ),
    .O(\I_SLAVE_ATTACHMENT/state_FSM_FFd1-In )
  );
  X_LUT5 #(
    .INIT ( 32'h000000EA ))
  \I_SLAVE_ATTACHMENT/Mmux_start11_1  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(S_AXI_WVALID_IBUF_51),
    .ADR2(S_AXI_AWVALID_IBUF_50),
    .ADR3(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR4(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/Mmux_start11_471 )
  );
  X_LUT4 #(
    .INIT ( 16'h5444 ))
  \I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(S_AXI_ARVALID_IBUF_172),
    .ADR2(S_AXI_AWVALID_IBUF_50),
    .ADR3(S_AXI_WVALID_IBUF_51),
    .O(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_223 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [0]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_0_dpot_477 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_222 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [1]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_1_dpot_478 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_221 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [2]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_2_dpot_479 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_220 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [3]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_3_dpot_480 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_211 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [12]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_12_dpot_481 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_210 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [13]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_13_dpot_482 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_209 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [14]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_14_dpot_483 )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_dpot  (
    .ADR0(\I_SLAVE_ATTACHMENT/Mmux_start11_rstpot1_475 ),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_208 ),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/ce_expnd_i [15]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i_15_dpot_484 )
  );
  X_CKBUF   S_AXI_ACLK_IBUF_BUFG (
    .O(S_AXI_ACLK_IBUF_BUFG_170),
    .I(S_AXI_ACLK_IBUF_485)
  );
  X_INV   \I_SLAVE_ATTACHMENT/Mcount_INCLUDE_DPHASE_TIMER.dpto_cnt_xor<0>11_INV_0  (
    .I(\I_SLAVE_ATTACHMENT/INCLUDE_DPHASE_TIMER.dpto_cnt [0]),
    .O(\I_SLAVE_ATTACHMENT/Result [0])
  );
  X_INV   \I_SLAVE_ATTACHMENT/rst_rstpot1_INV_0  (
    .I(S_AXI_ARESETN_IBUF_171),
    .O(\I_SLAVE_ATTACHMENT/rst_rstpot )
  );
  X_INV   \I_SLAVE_ATTACHMENT/Mmux_start11_cepot_INV_0  (
    .I(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot )
  );
  X_INV   \I_SLAVE_ATTACHMENT/Mmux_start11_cepot1_INV_0  (
    .I(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(\I_SLAVE_ATTACHMENT/Mmux_start11_cepot1 )
  );
  X_LUT6 #(
    .INIT ( 64'h04440444FEEE0444 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1_dpot_F  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [1]),
    .ADR2(S_AXI_AWVALID_IBUF_50),
    .ADR3(S_AXI_WVALID_IBUF_51),
    .ADR4(Bus2IP_Addr_8_OBUF_91),
    .ADR5(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .O(N4)
  );
  X_LUT6 #(
    .INIT ( 64'h044404440444FEEE ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0_dpot_F  (
    .ADR0(S_AXI_ARVALID_IBUF_172),
    .ADR1(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [0]),
    .ADR2(S_AXI_AWVALID_IBUF_50),
    .ADR3(S_AXI_WVALID_IBUF_51),
    .ADR4(\I_SLAVE_ATTACHMENT/state_FSM_FFd1_182 ),
    .ADR5(Bus2IP_Addr_8_OBUF_91),
    .O(N6)
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1_dpot1  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(N4),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [1]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_1_dpot )
  );
  X_LUT3 #(
    .INIT ( 8'hE4 ))
  \I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0_dpot1  (
    .ADR0(\I_SLAVE_ATTACHMENT/state_FSM_FFd2_183 ),
    .ADR1(N6),
    .ADR2(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [0]),
    .O(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i_0_dpot )
  );
  X_IPAD   S_AXI_ACLK_397 (
    .PAD(S_AXI_ACLK)
  );
  X_IPAD   \S_AXI_AWADDR<8>  (
    .PAD(S_AXI_AWADDR[8])
  );
  X_IPAD   \S_AXI_AWADDR<7>  (
    .PAD(S_AXI_AWADDR[7])
  );
  X_IPAD   \S_AXI_AWADDR<6>  (
    .PAD(S_AXI_AWADDR[6])
  );
  X_IPAD   \S_AXI_AWADDR<5>  (
    .PAD(S_AXI_AWADDR[5])
  );
  X_IPAD   \S_AXI_AWADDR<4>  (
    .PAD(S_AXI_AWADDR[4])
  );
  X_IPAD   \S_AXI_AWADDR<3>  (
    .PAD(S_AXI_AWADDR[3])
  );
  X_IPAD   \S_AXI_AWADDR<2>  (
    .PAD(S_AXI_AWADDR[2])
  );
  X_IPAD   \S_AXI_AWADDR<1>  (
    .PAD(S_AXI_AWADDR[1])
  );
  X_IPAD   \S_AXI_AWADDR<0>  (
    .PAD(S_AXI_AWADDR[0])
  );
  X_IPAD   \S_AXI_WDATA<31>  (
    .PAD(S_AXI_WDATA[31])
  );
  X_IPAD   \S_AXI_WDATA<30>  (
    .PAD(S_AXI_WDATA[30])
  );
  X_IPAD   \S_AXI_WDATA<29>  (
    .PAD(S_AXI_WDATA[29])
  );
  X_IPAD   \S_AXI_WDATA<28>  (
    .PAD(S_AXI_WDATA[28])
  );
  X_IPAD   \S_AXI_WDATA<27>  (
    .PAD(S_AXI_WDATA[27])
  );
  X_IPAD   \S_AXI_WDATA<26>  (
    .PAD(S_AXI_WDATA[26])
  );
  X_IPAD   \S_AXI_WDATA<25>  (
    .PAD(S_AXI_WDATA[25])
  );
  X_IPAD   \S_AXI_WDATA<24>  (
    .PAD(S_AXI_WDATA[24])
  );
  X_IPAD   \S_AXI_WDATA<23>  (
    .PAD(S_AXI_WDATA[23])
  );
  X_IPAD   \S_AXI_WDATA<22>  (
    .PAD(S_AXI_WDATA[22])
  );
  X_IPAD   \S_AXI_WDATA<21>  (
    .PAD(S_AXI_WDATA[21])
  );
  X_IPAD   \S_AXI_WDATA<20>  (
    .PAD(S_AXI_WDATA[20])
  );
  X_IPAD   \S_AXI_WDATA<19>  (
    .PAD(S_AXI_WDATA[19])
  );
  X_IPAD   \S_AXI_WDATA<18>  (
    .PAD(S_AXI_WDATA[18])
  );
  X_IPAD   \S_AXI_WDATA<17>  (
    .PAD(S_AXI_WDATA[17])
  );
  X_IPAD   \S_AXI_WDATA<16>  (
    .PAD(S_AXI_WDATA[16])
  );
  X_IPAD   \S_AXI_WDATA<15>  (
    .PAD(S_AXI_WDATA[15])
  );
  X_IPAD   \S_AXI_WDATA<14>  (
    .PAD(S_AXI_WDATA[14])
  );
  X_IPAD   \S_AXI_WDATA<13>  (
    .PAD(S_AXI_WDATA[13])
  );
  X_IPAD   \S_AXI_WDATA<12>  (
    .PAD(S_AXI_WDATA[12])
  );
  X_IPAD   \S_AXI_WDATA<11>  (
    .PAD(S_AXI_WDATA[11])
  );
  X_IPAD   \S_AXI_WDATA<10>  (
    .PAD(S_AXI_WDATA[10])
  );
  X_IPAD   \S_AXI_WDATA<9>  (
    .PAD(S_AXI_WDATA[9])
  );
  X_IPAD   \S_AXI_WDATA<8>  (
    .PAD(S_AXI_WDATA[8])
  );
  X_IPAD   \S_AXI_WDATA<7>  (
    .PAD(S_AXI_WDATA[7])
  );
  X_IPAD   \S_AXI_WDATA<6>  (
    .PAD(S_AXI_WDATA[6])
  );
  X_IPAD   \S_AXI_WDATA<5>  (
    .PAD(S_AXI_WDATA[5])
  );
  X_IPAD   \S_AXI_WDATA<4>  (
    .PAD(S_AXI_WDATA[4])
  );
  X_IPAD   \S_AXI_WDATA<3>  (
    .PAD(S_AXI_WDATA[3])
  );
  X_IPAD   \S_AXI_WDATA<2>  (
    .PAD(S_AXI_WDATA[2])
  );
  X_IPAD   \S_AXI_WDATA<1>  (
    .PAD(S_AXI_WDATA[1])
  );
  X_IPAD   \S_AXI_WDATA<0>  (
    .PAD(S_AXI_WDATA[0])
  );
  X_IPAD   \S_AXI_ARADDR<8>  (
    .PAD(S_AXI_ARADDR[8])
  );
  X_IPAD   \S_AXI_ARADDR<7>  (
    .PAD(S_AXI_ARADDR[7])
  );
  X_IPAD   \S_AXI_ARADDR<6>  (
    .PAD(S_AXI_ARADDR[6])
  );
  X_IPAD   \S_AXI_ARADDR<5>  (
    .PAD(S_AXI_ARADDR[5])
  );
  X_IPAD   \S_AXI_ARADDR<4>  (
    .PAD(S_AXI_ARADDR[4])
  );
  X_IPAD   \S_AXI_ARADDR<3>  (
    .PAD(S_AXI_ARADDR[3])
  );
  X_IPAD   \S_AXI_ARADDR<2>  (
    .PAD(S_AXI_ARADDR[2])
  );
  X_IPAD   \S_AXI_ARADDR<1>  (
    .PAD(S_AXI_ARADDR[1])
  );
  X_IPAD   \S_AXI_ARADDR<0>  (
    .PAD(S_AXI_ARADDR[0])
  );
  X_IPAD   \IP2Bus_Data<31>  (
    .PAD(IP2Bus_Data[31])
  );
  X_IPAD   \IP2Bus_Data<30>  (
    .PAD(IP2Bus_Data[30])
  );
  X_IPAD   \IP2Bus_Data<29>  (
    .PAD(IP2Bus_Data[29])
  );
  X_IPAD   \IP2Bus_Data<28>  (
    .PAD(IP2Bus_Data[28])
  );
  X_IPAD   \IP2Bus_Data<27>  (
    .PAD(IP2Bus_Data[27])
  );
  X_IPAD   \IP2Bus_Data<26>  (
    .PAD(IP2Bus_Data[26])
  );
  X_IPAD   \IP2Bus_Data<25>  (
    .PAD(IP2Bus_Data[25])
  );
  X_IPAD   \IP2Bus_Data<24>  (
    .PAD(IP2Bus_Data[24])
  );
  X_IPAD   \IP2Bus_Data<23>  (
    .PAD(IP2Bus_Data[23])
  );
  X_IPAD   \IP2Bus_Data<22>  (
    .PAD(IP2Bus_Data[22])
  );
  X_IPAD   \IP2Bus_Data<21>  (
    .PAD(IP2Bus_Data[21])
  );
  X_IPAD   \IP2Bus_Data<20>  (
    .PAD(IP2Bus_Data[20])
  );
  X_IPAD   \IP2Bus_Data<19>  (
    .PAD(IP2Bus_Data[19])
  );
  X_IPAD   \IP2Bus_Data<18>  (
    .PAD(IP2Bus_Data[18])
  );
  X_IPAD   \IP2Bus_Data<17>  (
    .PAD(IP2Bus_Data[17])
  );
  X_IPAD   \IP2Bus_Data<16>  (
    .PAD(IP2Bus_Data[16])
  );
  X_IPAD   \IP2Bus_Data<15>  (
    .PAD(IP2Bus_Data[15])
  );
  X_IPAD   \IP2Bus_Data<14>  (
    .PAD(IP2Bus_Data[14])
  );
  X_IPAD   \IP2Bus_Data<13>  (
    .PAD(IP2Bus_Data[13])
  );
  X_IPAD   \IP2Bus_Data<12>  (
    .PAD(IP2Bus_Data[12])
  );
  X_IPAD   \IP2Bus_Data<11>  (
    .PAD(IP2Bus_Data[11])
  );
  X_IPAD   \IP2Bus_Data<10>  (
    .PAD(IP2Bus_Data[10])
  );
  X_IPAD   \IP2Bus_Data<9>  (
    .PAD(IP2Bus_Data[9])
  );
  X_IPAD   \IP2Bus_Data<8>  (
    .PAD(IP2Bus_Data[8])
  );
  X_IPAD   \IP2Bus_Data<7>  (
    .PAD(IP2Bus_Data[7])
  );
  X_IPAD   \IP2Bus_Data<6>  (
    .PAD(IP2Bus_Data[6])
  );
  X_IPAD   \IP2Bus_Data<5>  (
    .PAD(IP2Bus_Data[5])
  );
  X_IPAD   \IP2Bus_Data<4>  (
    .PAD(IP2Bus_Data[4])
  );
  X_IPAD   \IP2Bus_Data<3>  (
    .PAD(IP2Bus_Data[3])
  );
  X_IPAD   \IP2Bus_Data<2>  (
    .PAD(IP2Bus_Data[2])
  );
  X_IPAD   \IP2Bus_Data<1>  (
    .PAD(IP2Bus_Data[1])
  );
  X_IPAD   \IP2Bus_Data<0>  (
    .PAD(IP2Bus_Data[0])
  );
  X_IPAD   S_AXI_ARESETN_480 (
    .PAD(S_AXI_ARESETN)
  );
  X_IPAD   S_AXI_AWVALID_481 (
    .PAD(S_AXI_AWVALID)
  );
  X_IPAD   S_AXI_WVALID_482 (
    .PAD(S_AXI_WVALID)
  );
  X_IPAD   S_AXI_BREADY_483 (
    .PAD(S_AXI_BREADY)
  );
  X_IPAD   S_AXI_ARVALID_484 (
    .PAD(S_AXI_ARVALID)
  );
  X_IPAD   S_AXI_RREADY_485 (
    .PAD(S_AXI_RREADY)
  );
  X_IPAD   IP2Bus_WrAck_486 (
    .PAD(IP2Bus_WrAck)
  );
  X_IPAD   IP2Bus_RdAck_487 (
    .PAD(IP2Bus_RdAck)
  );
  X_IPAD   IP2Bus_Error_488 (
    .PAD(IP2Bus_Error)
  );
  X_OPAD   \S_AXI_BRESP<1>  (
    .PAD(S_AXI_BRESP[1])
  );
  X_OPAD   \S_AXI_BRESP<0>  (
    .PAD(S_AXI_BRESP[0])
  );
  X_OPAD   \S_AXI_RDATA<31>  (
    .PAD(S_AXI_RDATA[31])
  );
  X_OPAD   \S_AXI_RDATA<30>  (
    .PAD(S_AXI_RDATA[30])
  );
  X_OPAD   \S_AXI_RDATA<29>  (
    .PAD(S_AXI_RDATA[29])
  );
  X_OPAD   \S_AXI_RDATA<28>  (
    .PAD(S_AXI_RDATA[28])
  );
  X_OPAD   \S_AXI_RDATA<27>  (
    .PAD(S_AXI_RDATA[27])
  );
  X_OPAD   \S_AXI_RDATA<26>  (
    .PAD(S_AXI_RDATA[26])
  );
  X_OPAD   \S_AXI_RDATA<25>  (
    .PAD(S_AXI_RDATA[25])
  );
  X_OPAD   \S_AXI_RDATA<24>  (
    .PAD(S_AXI_RDATA[24])
  );
  X_OPAD   \S_AXI_RDATA<23>  (
    .PAD(S_AXI_RDATA[23])
  );
  X_OPAD   \S_AXI_RDATA<22>  (
    .PAD(S_AXI_RDATA[22])
  );
  X_OPAD   \S_AXI_RDATA<21>  (
    .PAD(S_AXI_RDATA[21])
  );
  X_OPAD   \S_AXI_RDATA<20>  (
    .PAD(S_AXI_RDATA[20])
  );
  X_OPAD   \S_AXI_RDATA<19>  (
    .PAD(S_AXI_RDATA[19])
  );
  X_OPAD   \S_AXI_RDATA<18>  (
    .PAD(S_AXI_RDATA[18])
  );
  X_OPAD   \S_AXI_RDATA<17>  (
    .PAD(S_AXI_RDATA[17])
  );
  X_OPAD   \S_AXI_RDATA<16>  (
    .PAD(S_AXI_RDATA[16])
  );
  X_OPAD   \S_AXI_RDATA<15>  (
    .PAD(S_AXI_RDATA[15])
  );
  X_OPAD   \S_AXI_RDATA<14>  (
    .PAD(S_AXI_RDATA[14])
  );
  X_OPAD   \S_AXI_RDATA<13>  (
    .PAD(S_AXI_RDATA[13])
  );
  X_OPAD   \S_AXI_RDATA<12>  (
    .PAD(S_AXI_RDATA[12])
  );
  X_OPAD   \S_AXI_RDATA<11>  (
    .PAD(S_AXI_RDATA[11])
  );
  X_OPAD   \S_AXI_RDATA<10>  (
    .PAD(S_AXI_RDATA[10])
  );
  X_OPAD   \S_AXI_RDATA<9>  (
    .PAD(S_AXI_RDATA[9])
  );
  X_OPAD   \S_AXI_RDATA<8>  (
    .PAD(S_AXI_RDATA[8])
  );
  X_OPAD   \S_AXI_RDATA<7>  (
    .PAD(S_AXI_RDATA[7])
  );
  X_OPAD   \S_AXI_RDATA<6>  (
    .PAD(S_AXI_RDATA[6])
  );
  X_OPAD   \S_AXI_RDATA<5>  (
    .PAD(S_AXI_RDATA[5])
  );
  X_OPAD   \S_AXI_RDATA<4>  (
    .PAD(S_AXI_RDATA[4])
  );
  X_OPAD   \S_AXI_RDATA<3>  (
    .PAD(S_AXI_RDATA[3])
  );
  X_OPAD   \S_AXI_RDATA<2>  (
    .PAD(S_AXI_RDATA[2])
  );
  X_OPAD   \S_AXI_RDATA<1>  (
    .PAD(S_AXI_RDATA[1])
  );
  X_OPAD   \S_AXI_RDATA<0>  (
    .PAD(S_AXI_RDATA[0])
  );
  X_OPAD   \S_AXI_RRESP<1>  (
    .PAD(S_AXI_RRESP[1])
  );
  X_OPAD   \S_AXI_RRESP<0>  (
    .PAD(S_AXI_RRESP[0])
  );
  X_OPAD   \Bus2IP_Addr<31>  (
    .PAD(Bus2IP_Addr[31])
  );
  X_OPAD   \Bus2IP_Addr<30>  (
    .PAD(Bus2IP_Addr[30])
  );
  X_OPAD   \Bus2IP_Addr<29>  (
    .PAD(Bus2IP_Addr[29])
  );
  X_OPAD   \Bus2IP_Addr<28>  (
    .PAD(Bus2IP_Addr[28])
  );
  X_OPAD   \Bus2IP_Addr<27>  (
    .PAD(Bus2IP_Addr[27])
  );
  X_OPAD   \Bus2IP_Addr<26>  (
    .PAD(Bus2IP_Addr[26])
  );
  X_OPAD   \Bus2IP_Addr<25>  (
    .PAD(Bus2IP_Addr[25])
  );
  X_OPAD   \Bus2IP_Addr<24>  (
    .PAD(Bus2IP_Addr[24])
  );
  X_OPAD   \Bus2IP_Addr<23>  (
    .PAD(Bus2IP_Addr[23])
  );
  X_OPAD   \Bus2IP_Addr<22>  (
    .PAD(Bus2IP_Addr[22])
  );
  X_OPAD   \Bus2IP_Addr<21>  (
    .PAD(Bus2IP_Addr[21])
  );
  X_OPAD   \Bus2IP_Addr<20>  (
    .PAD(Bus2IP_Addr[20])
  );
  X_OPAD   \Bus2IP_Addr<19>  (
    .PAD(Bus2IP_Addr[19])
  );
  X_OPAD   \Bus2IP_Addr<18>  (
    .PAD(Bus2IP_Addr[18])
  );
  X_OPAD   \Bus2IP_Addr<17>  (
    .PAD(Bus2IP_Addr[17])
  );
  X_OPAD   \Bus2IP_Addr<16>  (
    .PAD(Bus2IP_Addr[16])
  );
  X_OPAD   \Bus2IP_Addr<15>  (
    .PAD(Bus2IP_Addr[15])
  );
  X_OPAD   \Bus2IP_Addr<14>  (
    .PAD(Bus2IP_Addr[14])
  );
  X_OPAD   \Bus2IP_Addr<13>  (
    .PAD(Bus2IP_Addr[13])
  );
  X_OPAD   \Bus2IP_Addr<12>  (
    .PAD(Bus2IP_Addr[12])
  );
  X_OPAD   \Bus2IP_Addr<11>  (
    .PAD(Bus2IP_Addr[11])
  );
  X_OPAD   \Bus2IP_Addr<10>  (
    .PAD(Bus2IP_Addr[10])
  );
  X_OPAD   \Bus2IP_Addr<9>  (
    .PAD(Bus2IP_Addr[9])
  );
  X_OPAD   \Bus2IP_Addr<8>  (
    .PAD(Bus2IP_Addr[8])
  );
  X_OPAD   \Bus2IP_Addr<7>  (
    .PAD(Bus2IP_Addr[7])
  );
  X_OPAD   \Bus2IP_Addr<6>  (
    .PAD(Bus2IP_Addr[6])
  );
  X_OPAD   \Bus2IP_Addr<5>  (
    .PAD(Bus2IP_Addr[5])
  );
  X_OPAD   \Bus2IP_Addr<4>  (
    .PAD(Bus2IP_Addr[4])
  );
  X_OPAD   \Bus2IP_Addr<3>  (
    .PAD(Bus2IP_Addr[3])
  );
  X_OPAD   \Bus2IP_Addr<2>  (
    .PAD(Bus2IP_Addr[2])
  );
  X_OPAD   \Bus2IP_Addr<1>  (
    .PAD(Bus2IP_Addr[1])
  );
  X_OPAD   \Bus2IP_Addr<0>  (
    .PAD(Bus2IP_Addr[0])
  );
  X_OPAD   \Bus2IP_BE<3>  (
    .PAD(Bus2IP_BE[3])
  );
  X_OPAD   \Bus2IP_BE<2>  (
    .PAD(Bus2IP_BE[2])
  );
  X_OPAD   \Bus2IP_BE<1>  (
    .PAD(Bus2IP_BE[1])
  );
  X_OPAD   \Bus2IP_BE<0>  (
    .PAD(Bus2IP_BE[0])
  );
  X_OPAD   \Bus2IP_CS<1>  (
    .PAD(Bus2IP_CS[1])
  );
  X_OPAD   \Bus2IP_CS<0>  (
    .PAD(Bus2IP_CS[0])
  );
  X_OPAD   \Bus2IP_RdCE<15>  (
    .PAD(Bus2IP_RdCE[15])
  );
  X_OPAD   \Bus2IP_RdCE<14>  (
    .PAD(Bus2IP_RdCE[14])
  );
  X_OPAD   \Bus2IP_RdCE<13>  (
    .PAD(Bus2IP_RdCE[13])
  );
  X_OPAD   \Bus2IP_RdCE<12>  (
    .PAD(Bus2IP_RdCE[12])
  );
  X_OPAD   \Bus2IP_RdCE<11>  (
    .PAD(Bus2IP_RdCE[11])
  );
  X_OPAD   \Bus2IP_RdCE<10>  (
    .PAD(Bus2IP_RdCE[10])
  );
  X_OPAD   \Bus2IP_RdCE<9>  (
    .PAD(Bus2IP_RdCE[9])
  );
  X_OPAD   \Bus2IP_RdCE<8>  (
    .PAD(Bus2IP_RdCE[8])
  );
  X_OPAD   \Bus2IP_RdCE<7>  (
    .PAD(Bus2IP_RdCE[7])
  );
  X_OPAD   \Bus2IP_RdCE<6>  (
    .PAD(Bus2IP_RdCE[6])
  );
  X_OPAD   \Bus2IP_RdCE<5>  (
    .PAD(Bus2IP_RdCE[5])
  );
  X_OPAD   \Bus2IP_RdCE<4>  (
    .PAD(Bus2IP_RdCE[4])
  );
  X_OPAD   \Bus2IP_RdCE<3>  (
    .PAD(Bus2IP_RdCE[3])
  );
  X_OPAD   \Bus2IP_RdCE<2>  (
    .PAD(Bus2IP_RdCE[2])
  );
  X_OPAD   \Bus2IP_RdCE<1>  (
    .PAD(Bus2IP_RdCE[1])
  );
  X_OPAD   \Bus2IP_RdCE<0>  (
    .PAD(Bus2IP_RdCE[0])
  );
  X_OPAD   \Bus2IP_WrCE<15>  (
    .PAD(Bus2IP_WrCE[15])
  );
  X_OPAD   \Bus2IP_WrCE<14>  (
    .PAD(Bus2IP_WrCE[14])
  );
  X_OPAD   \Bus2IP_WrCE<13>  (
    .PAD(Bus2IP_WrCE[13])
  );
  X_OPAD   \Bus2IP_WrCE<12>  (
    .PAD(Bus2IP_WrCE[12])
  );
  X_OPAD   \Bus2IP_WrCE<11>  (
    .PAD(Bus2IP_WrCE[11])
  );
  X_OPAD   \Bus2IP_WrCE<10>  (
    .PAD(Bus2IP_WrCE[10])
  );
  X_OPAD   \Bus2IP_WrCE<9>  (
    .PAD(Bus2IP_WrCE[9])
  );
  X_OPAD   \Bus2IP_WrCE<8>  (
    .PAD(Bus2IP_WrCE[8])
  );
  X_OPAD   \Bus2IP_WrCE<7>  (
    .PAD(Bus2IP_WrCE[7])
  );
  X_OPAD   \Bus2IP_WrCE<6>  (
    .PAD(Bus2IP_WrCE[6])
  );
  X_OPAD   \Bus2IP_WrCE<5>  (
    .PAD(Bus2IP_WrCE[5])
  );
  X_OPAD   \Bus2IP_WrCE<4>  (
    .PAD(Bus2IP_WrCE[4])
  );
  X_OPAD   \Bus2IP_WrCE<3>  (
    .PAD(Bus2IP_WrCE[3])
  );
  X_OPAD   \Bus2IP_WrCE<2>  (
    .PAD(Bus2IP_WrCE[2])
  );
  X_OPAD   \Bus2IP_WrCE<1>  (
    .PAD(Bus2IP_WrCE[1])
  );
  X_OPAD   \Bus2IP_WrCE<0>  (
    .PAD(Bus2IP_WrCE[0])
  );
  X_OPAD   \Bus2IP_Data<31>  (
    .PAD(Bus2IP_Data[31])
  );
  X_OPAD   \Bus2IP_Data<30>  (
    .PAD(Bus2IP_Data[30])
  );
  X_OPAD   \Bus2IP_Data<29>  (
    .PAD(Bus2IP_Data[29])
  );
  X_OPAD   \Bus2IP_Data<28>  (
    .PAD(Bus2IP_Data[28])
  );
  X_OPAD   \Bus2IP_Data<27>  (
    .PAD(Bus2IP_Data[27])
  );
  X_OPAD   \Bus2IP_Data<26>  (
    .PAD(Bus2IP_Data[26])
  );
  X_OPAD   \Bus2IP_Data<25>  (
    .PAD(Bus2IP_Data[25])
  );
  X_OPAD   \Bus2IP_Data<24>  (
    .PAD(Bus2IP_Data[24])
  );
  X_OPAD   \Bus2IP_Data<23>  (
    .PAD(Bus2IP_Data[23])
  );
  X_OPAD   \Bus2IP_Data<22>  (
    .PAD(Bus2IP_Data[22])
  );
  X_OPAD   \Bus2IP_Data<21>  (
    .PAD(Bus2IP_Data[21])
  );
  X_OPAD   \Bus2IP_Data<20>  (
    .PAD(Bus2IP_Data[20])
  );
  X_OPAD   \Bus2IP_Data<19>  (
    .PAD(Bus2IP_Data[19])
  );
  X_OPAD   \Bus2IP_Data<18>  (
    .PAD(Bus2IP_Data[18])
  );
  X_OPAD   \Bus2IP_Data<17>  (
    .PAD(Bus2IP_Data[17])
  );
  X_OPAD   \Bus2IP_Data<16>  (
    .PAD(Bus2IP_Data[16])
  );
  X_OPAD   \Bus2IP_Data<15>  (
    .PAD(Bus2IP_Data[15])
  );
  X_OPAD   \Bus2IP_Data<14>  (
    .PAD(Bus2IP_Data[14])
  );
  X_OPAD   \Bus2IP_Data<13>  (
    .PAD(Bus2IP_Data[13])
  );
  X_OPAD   \Bus2IP_Data<12>  (
    .PAD(Bus2IP_Data[12])
  );
  X_OPAD   \Bus2IP_Data<11>  (
    .PAD(Bus2IP_Data[11])
  );
  X_OPAD   \Bus2IP_Data<10>  (
    .PAD(Bus2IP_Data[10])
  );
  X_OPAD   \Bus2IP_Data<9>  (
    .PAD(Bus2IP_Data[9])
  );
  X_OPAD   \Bus2IP_Data<8>  (
    .PAD(Bus2IP_Data[8])
  );
  X_OPAD   \Bus2IP_Data<7>  (
    .PAD(Bus2IP_Data[7])
  );
  X_OPAD   \Bus2IP_Data<6>  (
    .PAD(Bus2IP_Data[6])
  );
  X_OPAD   \Bus2IP_Data<5>  (
    .PAD(Bus2IP_Data[5])
  );
  X_OPAD   \Bus2IP_Data<4>  (
    .PAD(Bus2IP_Data[4])
  );
  X_OPAD   \Bus2IP_Data<3>  (
    .PAD(Bus2IP_Data[3])
  );
  X_OPAD   \Bus2IP_Data<2>  (
    .PAD(Bus2IP_Data[2])
  );
  X_OPAD   \Bus2IP_Data<1>  (
    .PAD(Bus2IP_Data[1])
  );
  X_OPAD   \Bus2IP_Data<0>  (
    .PAD(Bus2IP_Data[0])
  );
  X_OPAD   S_AXI_AWREADY_627 (
    .PAD(S_AXI_AWREADY)
  );
  X_OPAD   S_AXI_WREADY_628 (
    .PAD(S_AXI_WREADY)
  );
  X_OPAD   S_AXI_BVALID_629 (
    .PAD(S_AXI_BVALID)
  );
  X_OPAD   S_AXI_ARREADY_630 (
    .PAD(S_AXI_ARREADY)
  );
  X_OPAD   S_AXI_RVALID_631 (
    .PAD(S_AXI_RVALID)
  );
  X_OPAD   Bus2IP_Clk_632 (
    .PAD(Bus2IP_Clk)
  );
  X_OPAD   Bus2IP_Resetn_633 (
    .PAD(Bus2IP_Resetn)
  );
  X_OPAD   Bus2IP_RNW_634 (
    .PAD(Bus2IP_RNW)
  );
  X_OBUF   S_AXI_BRESP_1_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_bresp_i [1]),
    .O(S_AXI_BRESP[1])
  );
  X_OBUF   S_AXI_BRESP_0_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(S_AXI_BRESP[0])
  );
  X_OBUF   S_AXI_RDATA_31_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [31]),
    .O(S_AXI_RDATA[31])
  );
  X_OBUF   S_AXI_RDATA_30_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [30]),
    .O(S_AXI_RDATA[30])
  );
  X_OBUF   S_AXI_RDATA_29_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [29]),
    .O(S_AXI_RDATA[29])
  );
  X_OBUF   S_AXI_RDATA_28_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [28]),
    .O(S_AXI_RDATA[28])
  );
  X_OBUF   S_AXI_RDATA_27_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [27]),
    .O(S_AXI_RDATA[27])
  );
  X_OBUF   S_AXI_RDATA_26_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [26]),
    .O(S_AXI_RDATA[26])
  );
  X_OBUF   S_AXI_RDATA_25_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [25]),
    .O(S_AXI_RDATA[25])
  );
  X_OBUF   S_AXI_RDATA_24_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [24]),
    .O(S_AXI_RDATA[24])
  );
  X_OBUF   S_AXI_RDATA_23_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [23]),
    .O(S_AXI_RDATA[23])
  );
  X_OBUF   S_AXI_RDATA_22_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [22]),
    .O(S_AXI_RDATA[22])
  );
  X_OBUF   S_AXI_RDATA_21_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [21]),
    .O(S_AXI_RDATA[21])
  );
  X_OBUF   S_AXI_RDATA_20_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [20]),
    .O(S_AXI_RDATA[20])
  );
  X_OBUF   S_AXI_RDATA_19_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [19]),
    .O(S_AXI_RDATA[19])
  );
  X_OBUF   S_AXI_RDATA_18_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [18]),
    .O(S_AXI_RDATA[18])
  );
  X_OBUF   S_AXI_RDATA_17_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [17]),
    .O(S_AXI_RDATA[17])
  );
  X_OBUF   S_AXI_RDATA_16_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [16]),
    .O(S_AXI_RDATA[16])
  );
  X_OBUF   S_AXI_RDATA_15_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [15]),
    .O(S_AXI_RDATA[15])
  );
  X_OBUF   S_AXI_RDATA_14_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [14]),
    .O(S_AXI_RDATA[14])
  );
  X_OBUF   S_AXI_RDATA_13_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [13]),
    .O(S_AXI_RDATA[13])
  );
  X_OBUF   S_AXI_RDATA_12_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [12]),
    .O(S_AXI_RDATA[12])
  );
  X_OBUF   S_AXI_RDATA_11_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [11]),
    .O(S_AXI_RDATA[11])
  );
  X_OBUF   S_AXI_RDATA_10_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [10]),
    .O(S_AXI_RDATA[10])
  );
  X_OBUF   S_AXI_RDATA_9_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [9]),
    .O(S_AXI_RDATA[9])
  );
  X_OBUF   S_AXI_RDATA_8_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [8]),
    .O(S_AXI_RDATA[8])
  );
  X_OBUF   S_AXI_RDATA_7_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [7]),
    .O(S_AXI_RDATA[7])
  );
  X_OBUF   S_AXI_RDATA_6_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [6]),
    .O(S_AXI_RDATA[6])
  );
  X_OBUF   S_AXI_RDATA_5_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [5]),
    .O(S_AXI_RDATA[5])
  );
  X_OBUF   S_AXI_RDATA_4_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [4]),
    .O(S_AXI_RDATA[4])
  );
  X_OBUF   S_AXI_RDATA_3_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [3]),
    .O(S_AXI_RDATA[3])
  );
  X_OBUF   S_AXI_RDATA_2_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [2]),
    .O(S_AXI_RDATA[2])
  );
  X_OBUF   S_AXI_RDATA_1_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [1]),
    .O(S_AXI_RDATA[1])
  );
  X_OBUF   S_AXI_RDATA_0_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rdata_i [0]),
    .O(S_AXI_RDATA[0])
  );
  X_OBUF   S_AXI_RRESP_1_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rresp_i [1]),
    .O(S_AXI_RRESP[1])
  );
  X_OBUF   S_AXI_RRESP_0_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(S_AXI_RRESP[0])
  );
  X_OBUF   Bus2IP_Addr_31_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[31])
  );
  X_OBUF   Bus2IP_Addr_30_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[30])
  );
  X_OBUF   Bus2IP_Addr_29_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[29])
  );
  X_OBUF   Bus2IP_Addr_28_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[28])
  );
  X_OBUF   Bus2IP_Addr_27_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[27])
  );
  X_OBUF   Bus2IP_Addr_26_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[26])
  );
  X_OBUF   Bus2IP_Addr_25_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[25])
  );
  X_OBUF   Bus2IP_Addr_24_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[24])
  );
  X_OBUF   Bus2IP_Addr_23_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[23])
  );
  X_OBUF   Bus2IP_Addr_22_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[22])
  );
  X_OBUF   Bus2IP_Addr_21_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[21])
  );
  X_OBUF   Bus2IP_Addr_20_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[20])
  );
  X_OBUF   Bus2IP_Addr_19_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[19])
  );
  X_OBUF   Bus2IP_Addr_18_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[18])
  );
  X_OBUF   Bus2IP_Addr_17_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[17])
  );
  X_OBUF   Bus2IP_Addr_16_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[16])
  );
  X_OBUF   Bus2IP_Addr_15_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[15])
  );
  X_OBUF   Bus2IP_Addr_14_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[14])
  );
  X_OBUF   Bus2IP_Addr_13_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[13])
  );
  X_OBUF   Bus2IP_Addr_12_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[12])
  );
  X_OBUF   Bus2IP_Addr_11_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[11])
  );
  X_OBUF   Bus2IP_Addr_10_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[10])
  );
  X_OBUF   Bus2IP_Addr_9_OBUF (
    .I(S_AXI_BRESP_0_OBUF_173),
    .O(Bus2IP_Addr[9])
  );
  X_OBUF   Bus2IP_Addr_8_OBUF (
    .I(Bus2IP_Addr_8_OBUF_91),
    .O(Bus2IP_Addr[8])
  );
  X_OBUF   Bus2IP_Addr_7_OBUF (
    .I(Bus2IP_Addr_7_OBUF_92),
    .O(Bus2IP_Addr[7])
  );
  X_OBUF   Bus2IP_Addr_6_OBUF (
    .I(Bus2IP_Addr_6_OBUF_93),
    .O(Bus2IP_Addr[6])
  );
  X_OBUF   Bus2IP_Addr_5_OBUF (
    .I(Bus2IP_Addr_5_OBUF_94),
    .O(Bus2IP_Addr[5])
  );
  X_OBUF   Bus2IP_Addr_4_OBUF (
    .I(Bus2IP_Addr_4_OBUF_95),
    .O(Bus2IP_Addr[4])
  );
  X_OBUF   Bus2IP_Addr_3_OBUF (
    .I(Bus2IP_Addr_3_OBUF_96),
    .O(Bus2IP_Addr[3])
  );
  X_OBUF   Bus2IP_Addr_2_OBUF (
    .I(Bus2IP_Addr_2_OBUF_97),
    .O(Bus2IP_Addr[2])
  );
  X_OBUF   Bus2IP_Addr_1_OBUF (
    .I(Bus2IP_Addr_1_OBUF_98),
    .O(Bus2IP_Addr[1])
  );
  X_OBUF   Bus2IP_Addr_0_OBUF (
    .I(Bus2IP_Addr_0_OBUF_99),
    .O(Bus2IP_Addr[0])
  );
  X_OBUF   Bus2IP_BE_3_OBUF (
    .I(Bus2IP_BE_3_OBUF_174),
    .O(Bus2IP_BE[3])
  );
  X_OBUF   Bus2IP_BE_2_OBUF (
    .I(Bus2IP_BE_3_OBUF_174),
    .O(Bus2IP_BE[2])
  );
  X_OBUF   Bus2IP_BE_1_OBUF (
    .I(Bus2IP_BE_3_OBUF_174),
    .O(Bus2IP_BE[1])
  );
  X_OBUF   Bus2IP_BE_0_OBUF (
    .I(Bus2IP_BE_3_OBUF_174),
    .O(Bus2IP_BE[0])
  );
  X_OBUF   Bus2IP_CS_1_OBUF (
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [0]),
    .O(Bus2IP_CS[1])
  );
  X_OBUF   Bus2IP_CS_0_OBUF (
    .I(\I_SLAVE_ATTACHMENT/I_DECODER/cs_out_i [1]),
    .O(Bus2IP_CS[0])
  );
  X_OBUF   Bus2IP_RdCE_15_OBUF (
    .I(Bus2IP_RdCE_15_OBUF_102),
    .O(Bus2IP_RdCE[15])
  );
  X_OBUF   Bus2IP_RdCE_14_OBUF (
    .I(Bus2IP_RdCE_14_OBUF_103),
    .O(Bus2IP_RdCE[14])
  );
  X_OBUF   Bus2IP_RdCE_13_OBUF (
    .I(Bus2IP_RdCE_13_OBUF_104),
    .O(Bus2IP_RdCE[13])
  );
  X_OBUF   Bus2IP_RdCE_12_OBUF (
    .I(Bus2IP_RdCE_12_OBUF_105),
    .O(Bus2IP_RdCE[12])
  );
  X_OBUF   Bus2IP_RdCE_11_OBUF (
    .I(Bus2IP_RdCE_11_OBUF_106),
    .O(Bus2IP_RdCE[11])
  );
  X_OBUF   Bus2IP_RdCE_10_OBUF (
    .I(Bus2IP_RdCE_10_OBUF_107),
    .O(Bus2IP_RdCE[10])
  );
  X_OBUF   Bus2IP_RdCE_9_OBUF (
    .I(Bus2IP_RdCE_9_OBUF_108),
    .O(Bus2IP_RdCE[9])
  );
  X_OBUF   Bus2IP_RdCE_8_OBUF (
    .I(Bus2IP_RdCE_8_OBUF_109),
    .O(Bus2IP_RdCE[8])
  );
  X_OBUF   Bus2IP_RdCE_7_OBUF (
    .I(Bus2IP_RdCE_7_OBUF_110),
    .O(Bus2IP_RdCE[7])
  );
  X_OBUF   Bus2IP_RdCE_6_OBUF (
    .I(Bus2IP_RdCE_6_OBUF_111),
    .O(Bus2IP_RdCE[6])
  );
  X_OBUF   Bus2IP_RdCE_5_OBUF (
    .I(Bus2IP_RdCE_5_OBUF_112),
    .O(Bus2IP_RdCE[5])
  );
  X_OBUF   Bus2IP_RdCE_4_OBUF (
    .I(Bus2IP_RdCE_4_OBUF_113),
    .O(Bus2IP_RdCE[4])
  );
  X_OBUF   Bus2IP_RdCE_3_OBUF (
    .I(Bus2IP_RdCE_3_OBUF_114),
    .O(Bus2IP_RdCE[3])
  );
  X_OBUF   Bus2IP_RdCE_2_OBUF (
    .I(Bus2IP_RdCE_2_OBUF_115),
    .O(Bus2IP_RdCE[2])
  );
  X_OBUF   Bus2IP_RdCE_1_OBUF (
    .I(Bus2IP_RdCE_1_OBUF_116),
    .O(Bus2IP_RdCE[1])
  );
  X_OBUF   Bus2IP_RdCE_0_OBUF (
    .I(Bus2IP_RdCE_0_OBUF_117),
    .O(Bus2IP_RdCE[0])
  );
  X_OBUF   Bus2IP_WrCE_15_OBUF (
    .I(Bus2IP_WrCE_15_OBUF_118),
    .O(Bus2IP_WrCE[15])
  );
  X_OBUF   Bus2IP_WrCE_14_OBUF (
    .I(Bus2IP_WrCE_14_OBUF_119),
    .O(Bus2IP_WrCE[14])
  );
  X_OBUF   Bus2IP_WrCE_13_OBUF (
    .I(Bus2IP_WrCE_13_OBUF_120),
    .O(Bus2IP_WrCE[13])
  );
  X_OBUF   Bus2IP_WrCE_12_OBUF (
    .I(Bus2IP_WrCE_12_OBUF_121),
    .O(Bus2IP_WrCE[12])
  );
  X_OBUF   Bus2IP_WrCE_11_OBUF (
    .I(Bus2IP_WrCE_11_OBUF_122),
    .O(Bus2IP_WrCE[11])
  );
  X_OBUF   Bus2IP_WrCE_10_OBUF (
    .I(Bus2IP_WrCE_10_OBUF_123),
    .O(Bus2IP_WrCE[10])
  );
  X_OBUF   Bus2IP_WrCE_9_OBUF (
    .I(Bus2IP_WrCE_9_OBUF_124),
    .O(Bus2IP_WrCE[9])
  );
  X_OBUF   Bus2IP_WrCE_8_OBUF (
    .I(Bus2IP_WrCE_8_OBUF_125),
    .O(Bus2IP_WrCE[8])
  );
  X_OBUF   Bus2IP_WrCE_7_OBUF (
    .I(Bus2IP_WrCE_7_OBUF_126),
    .O(Bus2IP_WrCE[7])
  );
  X_OBUF   Bus2IP_WrCE_6_OBUF (
    .I(Bus2IP_WrCE_6_OBUF_127),
    .O(Bus2IP_WrCE[6])
  );
  X_OBUF   Bus2IP_WrCE_5_OBUF (
    .I(Bus2IP_WrCE_5_OBUF_128),
    .O(Bus2IP_WrCE[5])
  );
  X_OBUF   Bus2IP_WrCE_4_OBUF (
    .I(Bus2IP_WrCE_4_OBUF_129),
    .O(Bus2IP_WrCE[4])
  );
  X_OBUF   Bus2IP_WrCE_3_OBUF (
    .I(Bus2IP_WrCE_3_OBUF_130),
    .O(Bus2IP_WrCE[3])
  );
  X_OBUF   Bus2IP_WrCE_2_OBUF (
    .I(Bus2IP_WrCE_2_OBUF_131),
    .O(Bus2IP_WrCE[2])
  );
  X_OBUF   Bus2IP_WrCE_1_OBUF (
    .I(Bus2IP_WrCE_1_OBUF_132),
    .O(Bus2IP_WrCE[1])
  );
  X_OBUF   Bus2IP_WrCE_0_OBUF (
    .I(Bus2IP_WrCE_0_OBUF_133),
    .O(Bus2IP_WrCE[0])
  );
  X_OBUF   Bus2IP_Data_31_OBUF (
    .I(S_AXI_WDATA_31_IBUF_134),
    .O(Bus2IP_Data[31])
  );
  X_OBUF   Bus2IP_Data_30_OBUF (
    .I(S_AXI_WDATA_30_IBUF_135),
    .O(Bus2IP_Data[30])
  );
  X_OBUF   Bus2IP_Data_29_OBUF (
    .I(S_AXI_WDATA_29_IBUF_136),
    .O(Bus2IP_Data[29])
  );
  X_OBUF   Bus2IP_Data_28_OBUF (
    .I(S_AXI_WDATA_28_IBUF_137),
    .O(Bus2IP_Data[28])
  );
  X_OBUF   Bus2IP_Data_27_OBUF (
    .I(S_AXI_WDATA_27_IBUF_138),
    .O(Bus2IP_Data[27])
  );
  X_OBUF   Bus2IP_Data_26_OBUF (
    .I(S_AXI_WDATA_26_IBUF_139),
    .O(Bus2IP_Data[26])
  );
  X_OBUF   Bus2IP_Data_25_OBUF (
    .I(S_AXI_WDATA_25_IBUF_140),
    .O(Bus2IP_Data[25])
  );
  X_OBUF   Bus2IP_Data_24_OBUF (
    .I(S_AXI_WDATA_24_IBUF_141),
    .O(Bus2IP_Data[24])
  );
  X_OBUF   Bus2IP_Data_23_OBUF (
    .I(S_AXI_WDATA_23_IBUF_142),
    .O(Bus2IP_Data[23])
  );
  X_OBUF   Bus2IP_Data_22_OBUF (
    .I(S_AXI_WDATA_22_IBUF_143),
    .O(Bus2IP_Data[22])
  );
  X_OBUF   Bus2IP_Data_21_OBUF (
    .I(S_AXI_WDATA_21_IBUF_144),
    .O(Bus2IP_Data[21])
  );
  X_OBUF   Bus2IP_Data_20_OBUF (
    .I(S_AXI_WDATA_20_IBUF_145),
    .O(Bus2IP_Data[20])
  );
  X_OBUF   Bus2IP_Data_19_OBUF (
    .I(S_AXI_WDATA_19_IBUF_146),
    .O(Bus2IP_Data[19])
  );
  X_OBUF   Bus2IP_Data_18_OBUF (
    .I(S_AXI_WDATA_18_IBUF_147),
    .O(Bus2IP_Data[18])
  );
  X_OBUF   Bus2IP_Data_17_OBUF (
    .I(S_AXI_WDATA_17_IBUF_148),
    .O(Bus2IP_Data[17])
  );
  X_OBUF   Bus2IP_Data_16_OBUF (
    .I(S_AXI_WDATA_16_IBUF_149),
    .O(Bus2IP_Data[16])
  );
  X_OBUF   Bus2IP_Data_15_OBUF (
    .I(S_AXI_WDATA_15_IBUF_150),
    .O(Bus2IP_Data[15])
  );
  X_OBUF   Bus2IP_Data_14_OBUF (
    .I(S_AXI_WDATA_14_IBUF_151),
    .O(Bus2IP_Data[14])
  );
  X_OBUF   Bus2IP_Data_13_OBUF (
    .I(S_AXI_WDATA_13_IBUF_152),
    .O(Bus2IP_Data[13])
  );
  X_OBUF   Bus2IP_Data_12_OBUF (
    .I(S_AXI_WDATA_12_IBUF_153),
    .O(Bus2IP_Data[12])
  );
  X_OBUF   Bus2IP_Data_11_OBUF (
    .I(S_AXI_WDATA_11_IBUF_154),
    .O(Bus2IP_Data[11])
  );
  X_OBUF   Bus2IP_Data_10_OBUF (
    .I(S_AXI_WDATA_10_IBUF_155),
    .O(Bus2IP_Data[10])
  );
  X_OBUF   Bus2IP_Data_9_OBUF (
    .I(S_AXI_WDATA_9_IBUF_156),
    .O(Bus2IP_Data[9])
  );
  X_OBUF   Bus2IP_Data_8_OBUF (
    .I(S_AXI_WDATA_8_IBUF_157),
    .O(Bus2IP_Data[8])
  );
  X_OBUF   Bus2IP_Data_7_OBUF (
    .I(S_AXI_WDATA_7_IBUF_158),
    .O(Bus2IP_Data[7])
  );
  X_OBUF   Bus2IP_Data_6_OBUF (
    .I(S_AXI_WDATA_6_IBUF_159),
    .O(Bus2IP_Data[6])
  );
  X_OBUF   Bus2IP_Data_5_OBUF (
    .I(S_AXI_WDATA_5_IBUF_160),
    .O(Bus2IP_Data[5])
  );
  X_OBUF   Bus2IP_Data_4_OBUF (
    .I(S_AXI_WDATA_4_IBUF_161),
    .O(Bus2IP_Data[4])
  );
  X_OBUF   Bus2IP_Data_3_OBUF (
    .I(S_AXI_WDATA_3_IBUF_162),
    .O(Bus2IP_Data[3])
  );
  X_OBUF   Bus2IP_Data_2_OBUF (
    .I(S_AXI_WDATA_2_IBUF_163),
    .O(Bus2IP_Data[2])
  );
  X_OBUF   Bus2IP_Data_1_OBUF (
    .I(S_AXI_WDATA_1_IBUF_164),
    .O(Bus2IP_Data[1])
  );
  X_OBUF   Bus2IP_Data_0_OBUF (
    .I(S_AXI_WDATA_0_IBUF_165),
    .O(Bus2IP_Data[0])
  );
  X_OBUF   S_AXI_AWREADY_OBUF (
    .I(S_AXI_AWREADY_OBUF_166),
    .O(S_AXI_AWREADY)
  );
  X_OBUF   S_AXI_WREADY_OBUF (
    .I(S_AXI_AWREADY_OBUF_166),
    .O(S_AXI_WREADY)
  );
  X_OBUF   S_AXI_BVALID_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_bvalid_i_167 ),
    .O(S_AXI_BVALID)
  );
  X_OBUF   S_AXI_ARREADY_OBUF (
    .I(S_AXI_ARREADY_OBUF_168),
    .O(S_AXI_ARREADY)
  );
  X_OBUF   S_AXI_RVALID_OBUF (
    .I(\I_SLAVE_ATTACHMENT/s_axi_rvalid_i_169 ),
    .O(S_AXI_RVALID)
  );
  X_OBUF   Bus2IP_Clk_OBUF (
    .I(S_AXI_ACLK_IBUF_485),
    .O(Bus2IP_Clk)
  );
  X_OBUF   Bus2IP_Resetn_OBUF (
    .I(S_AXI_ARESETN_IBUF_171),
    .O(Bus2IP_Resetn)
  );
  X_OBUF   Bus2IP_RNW_OBUF (
    .I(S_AXI_ARVALID_IBUF_172),
    .O(Bus2IP_RNW)
  );
  X_ONE   NlwBlock_axi_lite_ipif_VCC (
    .O(VCC)
  );
  X_ZERO   NlwBlock_axi_lite_ipif_GND (
    .O(GND)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

