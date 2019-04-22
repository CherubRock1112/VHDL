puts "Simulation script for ModelSim "
vlib work
vcom -93 src/FrequencyDivider.vhd
vcom -93 simu/tb_FrequencyDivider.vhd

vsim tb_FrequencyDivider

add wave clk
add wave Reset
add wave Clear
add wave test/ms_past
add wave test/count_125ms
add wave test/count_250ms
add wave test/count_500ms
add wave test/count_1000ms
add wave Tick_125ms
add wave Tick_250ms
add wave Tick_500ms
add wave Tick_1000ms

force -freeze sim:/tb_FrequencyDivider/clk 1 0, 0 {8350 ps} -r {16.7 ns}

run 150 ms