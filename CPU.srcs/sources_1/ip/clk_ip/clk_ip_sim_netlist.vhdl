-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu May 25 17:56:50 2023
-- Host        : DESKTOP-KMJCO78 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top clk_ip -prefix
--               clk_ip_ clk_ip_sim_netlist.vhdl
-- Design      : clk_ip
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_ip_clk_ip_clk_wiz is
  port (
    cpu_clk : out STD_LOGIC;
    seg_clk : out STD_LOGIC;
    uart_clk : out STD_LOGIC;
    icu_clk : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
end clk_ip_clk_ip_clk_wiz;

architecture STRUCTURE of clk_ip_clk_ip_clk_wiz is
  signal clk_in1_clk_ip : STD_LOGIC;
  signal clkfbout_buf_clk_ip : STD_LOGIC;
  signal clkfbout_clk_ip : STD_LOGIC;
  signal cpu_clk_clk_ip : STD_LOGIC;
  signal icu_clk_clk_ip : STD_LOGIC;
  signal seg_clk_clk_ip : STD_LOGIC;
  signal uart_clk_clk_ip : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_LOCKED_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufg : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufg : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufg : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufg : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout4_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_clk_ip,
      O => clkfbout_buf_clk_ip
    );
clkin1_ibufg: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_in1,
      O => clk_in1_clk_ip
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => cpu_clk_clk_ip,
      O => cpu_clk
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => seg_clk_clk_ip,
      O => seg_clk
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => uart_clk_clk_ip,
      O => uart_clk
    );
clkout4_buf: unisim.vcomponents.BUFG
     port map (
      I => icu_clk_clk_ip,
      O => icu_clk
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 23,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 10.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 50,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 23,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 115,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT3_DIVIDE => 50,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 90.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 2,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_clk_ip,
      CLKFBOUT => clkfbout_clk_ip,
      CLKIN1 => clk_in1_clk_ip,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => cpu_clk_clk_ip,
      CLKOUT1 => seg_clk_clk_ip,
      CLKOUT2 => uart_clk_clk_ip,
      CLKOUT3 => icu_clk_clk_ip,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => NLW_plle2_adv_inst_LOCKED_UNCONNECTED,
      PWRDWN => '0',
      RST => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_ip is
  port (
    cpu_clk : out STD_LOGIC;
    seg_clk : out STD_LOGIC;
    uart_clk : out STD_LOGIC;
    icu_clk : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clk_ip : entity is true;
end clk_ip;

architecture STRUCTURE of clk_ip is
begin
inst: entity work.clk_ip_clk_ip_clk_wiz
     port map (
      clk_in1 => clk_in1,
      cpu_clk => cpu_clk,
      icu_clk => icu_clk,
      seg_clk => seg_clk,
      uart_clk => uart_clk
    );
end STRUCTURE;
