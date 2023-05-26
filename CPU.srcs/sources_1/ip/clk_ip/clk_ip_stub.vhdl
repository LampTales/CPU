-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Fri May 26 10:47:37 2023
-- Host        : LAPTOP-GUFPQJR2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub D:/CS214/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip_stub.vhdl
-- Design      : clk_ip
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_ip is
  Port ( 
    cpu_clk : out STD_LOGIC;
    seg_clk : out STD_LOGIC;
    uart_clk : out STD_LOGIC;
    icu_clk : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_ip;

architecture stub of clk_ip is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "cpu_clk,seg_clk,uart_clk,icu_clk,clk_in1";
begin
end;
