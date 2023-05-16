# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a100tfgg484-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv {
      D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
      D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog {
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/realtime/ram_ip_stub.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/realtime/rom_ip_stub.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/realtime/clk_ip_stub.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/realtime/uart_bmpg_0_stub.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/ALU.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/CTRL.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/CXK.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/Expander.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/MUX.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/PC.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/PCctrl.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/REG.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/led_block.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/seg_block.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/test.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/main.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/ROM.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/RAM.v}
      {D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/CPU.srcs/sources_1/new/SIMD_ALU.v}
    }
      rt::read_vhdl -lib xpm D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top main
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "D:/Sustech/2023 Spring/CS214 Computer Organizations/Project/CPU/.Xil/Vivado-14792-Haoson-PC/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}