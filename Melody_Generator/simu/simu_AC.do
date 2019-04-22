puts "Simulation script for ModelSim "
vlib work
vcom -93 src/adress_counter.vhd
vcom -93 simu/tb_adress_counter.vhd

vsim tb_adress_counter

add wave clk_i
add wave reset_i
add wave tick_next_out_i
add wave adress_note_i
add wave inst/count

force -freeze sim:/tb_adress_counter/clk_i 1 0, 0 {250 ps} -r {500 ps}

run 75 ns

