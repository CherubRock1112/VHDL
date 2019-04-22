puts "Simulation script for ModelSim "
vlib work
vcom -93 src/Decoder.vhd
vcom -93 simu/test_Decoder.vhd

vsim tb_Decoder

add wave Note_In
add wave Octave_In
add wave Val_Out

run