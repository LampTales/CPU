onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_ip_for_rom_opt

do {wave.do}

view wave
view structure
view signals

do {ram_ip_for_rom.udo}

run -all

quit -force
