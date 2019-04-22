
vlib work

vcom -93 ../src/processor.vhd

vsim processor

view processor
add wave *

force -freeze sim:/processor/Clk 1 0, 0 {500 ps} -r {1 ns}
force -freeze sim:/processor/rst 1 0 -cancel {3 ns}
add wave -position end  sim:/processor/E_CONTROLE/E_DECOD/instr_courante
add wave -position end  sim:/processor/E_AUT/E_REG/Banc
add wave -position end  sim:/processor/E_AUT/E_MEM/Banc
run  30 ns