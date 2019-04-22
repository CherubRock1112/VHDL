puts "Simulation script for ModelSim "
vlib work
vcom -93 src/Complete_Machine.vhd
vcom -93 simu/tb_Complete_machine.vhd
 
vsim tb_Complete_machine

add wave CLK
add wave RESET
add wave override
add wave SoundWave
add wave CM/Adress_Note
add wave CM/Octave
add wave CM/Note_Height
add wave CM/Duration
add wave CM/Tick_1000ms
add wave CM/Tick_500ms
add wave CM/Tick_250ms
add wave CM/Tick_125ms
add wave CM/Tick_Next_Note
add wave CM/C4/Count_125ms
add wave CM/C4/Count_250ms
add wave CM/C4/Count_500ms
add wave CM/C4/Count_1000ms

force -freeze sim:/tb_Complete_machine/clk 1 0, 0 {8350 ps} -r {16.7 ns}

run 600 ms
