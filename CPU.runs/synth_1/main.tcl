# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Wiman/VivadoSaving/CPU/CPU.cache/wt [current_project]
set_property parent.project_path C:/Users/Wiman/VivadoSaving/CPU/CPU.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths c:/Users/Wiman/VivadoSaving/CPU/file_saving/SEU_CSE_507_user_uart_bmpg_1.3 [current_project]
set_property ip_output_repo c:/Users/Wiman/VivadoSaving/CPU/CPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/ALU.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/CTRL.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/CXK.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/Expander.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/MUX.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/PC.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/PCctrl.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/REG.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/led_block.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/seg_block.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/test.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/main.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/ROM.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/RAM.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/SIMD_ALU.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/IO_block.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/button.v
  C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/new/ICU.v
}
read_ip -quiet C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/ram_ip/ram_ip.xci
set_property used_in_implementation false [get_files -all c:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/ram_ip/ram_ip_ooc.xdc]

read_ip -quiet C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip.xci
set_property used_in_implementation false [get_files -all c:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/clk_ip/clk_ip_ooc.xdc]

read_ip -quiet C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/sources_1/ip/uart_bmpg_0/uart_bmpg_0.xci

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/constrs_1/new/empty.xdc
set_property used_in_implementation false [get_files C:/Users/Wiman/VivadoSaving/CPU/CPU.srcs/constrs_1/new/empty.xdc]


synth_design -top main -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef main.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb"
