#!/usr/bin/tclsh
# create working library
vlib work

# compile all SV source files
vlog -sv ../../../one_cycle/source/adder.sv
vlog -sv ../../../one_cycle/source/alu.sv
vlog -sv ../../../one_cycle/source/aludec.sv
vlog -sv ../../../one_cycle/source/controller.sv
vlog -sv ../../../one_cycle/source/datapath.sv
vlog -sv ../../../one_cycle/source/exsign.sv
vlog -sv ../../../one_cycle/source/maindec.sv
vlog -sv ../../../one_cycle/source/mips.sv
vlog -sv ../../../one_cycle/source/mux2.sv
vlog -sv ../../../one_cycle/source/pc.sv
vlog -sv ../../../one_cycle/source/regfile.sv
vlog -sv ../../../one_cycle/source/slt2.sv
vlog -sv ../../../one_cycle/source/parameters.vh
vlog -sv ../../../one_cycle/source/top_one_cycle.sv

# compile memory blocks
vlog -sv ../../../one_cycle/source/datmem.sv
vlog -sv ../../../one_cycle/source/commem.sv

# compile testbench file
vlog -sv ../../source_test/one_cycle/0_harris_test.sv

# open the testbench
vsim work.mips_test_harris

# load software
mem load -i ../../../programms/bin_view/0_test_harris_bin.mem -format binary /mips_test_harris/dut/U_1/ram

# add all signals tu time diagramm
add wave -radix hexadecimal /mips_test_harris/*

# display current instruction
# add wave -label crnt_instr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/instr_datapath

# programm counter signals
add wave -group pc  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/in
add wave -group pc  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/out

# mux controlled next instruction or branch
add wave -group mux_next_or_branch  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/a
add wave -group mux_next_or_branch  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/b
add wave -group mux_next_or_branch   sim:/mips_test_harris/dut/U_0/U_1/U_5/cntrl
add wave -group mux_next_or_branch  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/out

# mux controlled previos result or jump
add wave -group mux_not_jump_or_jump -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/a
add wave -group mux_not_jump_or_jump -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/b
add wave -group mux_not_jump_or_jump sim:/mips_test_harris/dut/U_0/U_1/U_4/cntrl
add wave -group mux_not_jump_or_jump -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/out

# regfile signals
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf
add wave -group regfile -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_7/we
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a1
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a2
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a3
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/wd3
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd1
add wave -group regfile -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd2

# flags datapath singnals
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/we_regf
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/reg_dst
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/alu_src
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/mem_to_reg
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/branch
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/jump
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/zero_f
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/alu_cntrl
add wave -group flags_datapath sim:/mips_test_harris/dut/U_0/U_1/pcsrc

# alu signals
add wave -group ALU -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/a
add wave -group ALU -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/b
add wave -group ALU  sim:/mips_test_harris/dut/U_0/U_1/U_11/cntrl
add wave -group ALU -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/result
add wave -group ALU  sim:/mips_test_harris/dut/U_0/U_1/U_11/zero

# command memory signals
add wave -group command -radix hexadecimal sim:/mips_test_harris/dut/U_1/addr
add wave -group command -radix hexadecimal sim:/mips_test_harris/dut/U_1/ram
add wave -group command -radix hexadecimal sim:/mips_test_harris/dut/U_1/instr

# data memory signals
add wave -group data  sim:/mips_test_harris/dut/U_2/clk
add wave -group data  sim:/mips_test_harris/dut/U_2/we
add wave -group data -radix hexadecimal sim:/mips_test_harris/dut/U_2/addr
add wave -group data -radix hexadecimal sim:/mips_test_harris/dut/U_2/in
add wave -group data -radix hexadecimal sim:/mips_test_harris/dut/U_2/out
add wave -group data -radix hexadecimal sim:/mips_test_harris/dut/U_2/ram

# run simulation
run -all

# expand signals diagramm
wave zoom full
