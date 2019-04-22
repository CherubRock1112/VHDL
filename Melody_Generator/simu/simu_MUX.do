puts "Simulation script for ModelSim "
vlib work
vcom -93 src/MUX_4v1_1bit.vhd
vcom -93 simu/MUX_4v1_1bit_tb.vhd

vsim MUX_4v1_1bit_tb

add wave clock
add wave Duration
add wave Tick_125ms
add wave Tick_250ms
add wave Tick_500ms
add wave Tick_1000ms
add wave test/tick_note
add wave Tick_Next_Note
add wave CLEAR

force -freeze sim:/MUX_4v1_1bit_tb/clock 1 0, 0 {4500 ps} -r {9 ns}

run