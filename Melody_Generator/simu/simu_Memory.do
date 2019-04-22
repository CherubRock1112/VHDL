puts "Simulation script for ModelSim "
vlib work
vcom -93 src/memory.vhd
vcom -93 simu/tb_memory.vhd

vsim tb_memory

add wave Adress_Note_I
add wave Note_i
add wave Octave_i
add wave Duration_I


run

