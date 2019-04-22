
vlib work

vcom -93 ../src/PROJET_PROC/AUT.vhd
vcom -93 AUT_tb.vhd

vsim AUT_tb

view AUT_tb
add wave *

add wave -position end  sim:/aut_tb/C0/E_REG/Banc
add wave -position end  sim:/aut_tb/C0/E_MEM/Banc

force -freeze sim:/aut_tb/clk_tb 1 0, 0 {1000 ps} -r 2ns

run 150 ns