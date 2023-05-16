// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Apr 24 15:16:27 2023
// Host        : LAPTOP-5FTFKB8F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip_stub.v
// Design      : clk_ip
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_ip(cpu_clk, seg_clk, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="cpu_clk,seg_clk,clk_in1" */;
  output cpu_clk;
  output seg_clk;
  input clk_in1;
endmodule