puts "Simulation script for ModelSim "
vlib work
vcom -93 ../src/memory.vhd
vcom -93 tb_memory.vhd

vsim tb_memory

add wave clk_I
add wave Adress_Note_I
add wave Note_I
add wave Octave_I
add wave Duration_I

run
