puts "Simulation script for ModelSim "
vlib work
vcom -93 src/Wave_Generator.vhd
vcom -93 simu/test_WaveGen.vhd

vsim tb_WaveGen

add wave CLK
add wave RESET
add wave Override
add wave TickCounterIn
add wave wavegen1/intern_count
add wave SWOut

force -freeze sim:/tb_wavegen/clk 1 0, 0 {8350 ps} -r {16.7 ns}

run 20 ms