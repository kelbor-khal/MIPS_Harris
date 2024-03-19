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
mem load -i ../../../programs/bin_view/0_test_harris_bin.mem -format binary /mips_test_harris/dut/U_1/ram

# add all signals tu time diagramm
add wave -radix hexadecimal /mips_test_harris/*

# memory signals
# instruction memory
add wave -group command_mem -label address_instr      -radix hexadecimal sim:/mips_test_harris/dut/U_1/addr
add wave -group command_mem -label array_memory_isntr -radix hexadecimal sim:/mips_test_harris/dut/U_1/ram
add wave -group command_mem -label output_instr       -radix hexadecimal sim:/mips_test_harris/dut/U_1/instr

# data memory
add wave -group data_mem -label write_enable      -radix binary      sim:/mips_test_harris/dut/U_2/we
add wave -group data_mem -label memory_address    -radix hexadecimal sim:/mips_test_harris/dut/U_2/addr
add wave -group data_mem -label input_data        -radix hexadecimal sim:/mips_test_harris/dut/U_2/in
add wave -group data_mem -label output_data       -radix hexadecimal sim:/mips_test_harris/dut/U_2/out
add wave -group data_mem -label array_memory_data -radix hexadecimal sim:/mips_test_harris/dut/U_2/ram

# main decoder signals
add wave -group main_decoder -label opcode     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/opcode
add wave -group main_decoder -label we_mem     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/we_mem
add wave -group main_decoder -label branch     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/branch
add wave -group main_decoder -label alu_src    -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/alu_src
add wave -group main_decoder -label mem_to_reg -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/mem_to_reg
add wave -group main_decoder -label we_regf    -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/we_regf
add wave -group main_decoder -label reg_dst    -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/reg_dst
add wave -group main_decoder -label jump       -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/jump
add wave -group main_decoder -label aluop      -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/aluop
add wave -group main_decoder -label control    -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/control

# alu decoder signals
add wave -group alu_decoder -label alu_operation     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/aluop
add wave -group alu_decoder -label alu_control       -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/cntrl
add wave -group alu_decoder -label filed_instr_funct -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/funct

# program counter signals
add wave -group pc_U_0 -label next_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/in
add wave -group pc_U_0 -label crnt_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/out

# adder for next instruction
add wave -group adder_U_1 -label crnt_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/a
add wave -group adder_U_1 -label const_4   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/b
add wave -group adder_U_1 -label plus_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/rslt

# adder for branch instruction
add wave -group adder_U_2 -label plus_addr  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_2/a
add wave -group adder_U_2 -label sltimm     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_2/b
add wave -group adder_U_2 -label brnch_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_2/rslt

# slt2 for jump type instruction
add wave -group slt2_U_3 -label {6'b0,instr[25:0]} -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_3/in
add wave -group slt2_U_3 -label slt_jump           -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_3/out

# mux controlled previos result or jump
add wave -group mux_njump_or_jump_U_4 -label temp_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/a
add wave -group mux_njump_or_jump_U_4 -label jump_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/b
add wave -group mux_njump_or_jump_U_4 -label jump      -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_4/cntrl
add wave -group mux_njump_or_jump_U_4 -label next_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/out

# mux controlled next instruction or branch
add wave -group mux_next_or_branch_U_5 -label plus_addr  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/a
add wave -group mux_next_or_branch_U_5 -label brnch_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/b
add wave -group mux_next_or_branch_U_5 -label pcsrc      -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_5/cntrl
add wave -group mux_next_or_branch_U_5 -label temp_addr  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/out

# source register for I-type or R-type
add wave -group mux_I_or_R_instr_U_6 -label instr[20:16] -radix binary sim:/mips_test_harris/dut/U_0/U_1/U_6/a
add wave -group mux_I_or_R_instr_U_6 -label instr[15:11] -radix binary sim:/mips_test_harris/dut/U_0/U_1/U_6/b
add wave -group mux_I_or_R_instr_U_6 -label reg_dst      -radix binary sim:/mips_test_harris/dut/U_0/U_1/U_6/cntrl
add wave -group mux_I_or_R_instr_U_6 -label addreg3      -radix binary sim:/mips_test_harris/dut/U_0/U_1/U_6/out

# regfile signals
# register map
add wave -group regfile_U_7 -group reg_file_sp -label r0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[0]
add wave -group regfile_U_7 -group reg_file_sp -label at -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[1]
add wave -group regfile_U_7 -group reg_file_sp -label v0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[2]
add wave -group regfile_U_7 -group reg_file_sp -label v1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[3]
add wave -group regfile_U_7 -group reg_file_sp -label a0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[4]
add wave -group regfile_U_7 -group reg_file_sp -label a1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[5]
add wave -group regfile_U_7 -group reg_file_sp -label a2 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[6]
add wave -group regfile_U_7 -group reg_file_sp -label a3 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[7]
add wave -group regfile_U_7 -group reg_file_sp -label t0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[8]
add wave -group regfile_U_7 -group reg_file_sp -label t1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[9]
add wave -group regfile_U_7 -group reg_file_sp -label t2 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[10]
add wave -group regfile_U_7 -group reg_file_sp -label t3 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[11]
add wave -group regfile_U_7 -group reg_file_sp -label t4 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[12]
add wave -group regfile_U_7 -group reg_file_sp -label t5 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[13]
add wave -group regfile_U_7 -group reg_file_sp -label t6 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[14]
add wave -group regfile_U_7 -group reg_file_sp -label t7 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[15]
add wave -group regfile_U_7 -group reg_file_sp -label s0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[16]
add wave -group regfile_U_7 -group reg_file_sp -label s1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[17]
add wave -group regfile_U_7 -group reg_file_sp -label s2 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[18]
add wave -group regfile_U_7 -group reg_file_sp -label s3 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[19]
add wave -group regfile_U_7 -group reg_file_sp -label s4 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[20]
add wave -group regfile_U_7 -group reg_file_sp -label s5 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[21]
add wave -group regfile_U_7 -group reg_file_sp -label s6 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[22]
add wave -group regfile_U_7 -group reg_file_sp -label s7 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[23]
add wave -group regfile_U_7 -group reg_file_sp -label t8 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[24]
add wave -group regfile_U_7 -group reg_file_sp -label t9 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[25]
add wave -group regfile_U_7 -group reg_file_sp -label k0 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[26]
add wave -group regfile_U_7 -group reg_file_sp -label k1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[27]
add wave -group regfile_U_7 -group reg_file_sp -label gp -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[28]
add wave -group regfile_U_7 -group reg_file_sp -label sp -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[29]
add wave -group regfile_U_7 -group reg_file_sp -label fp -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[30]
add wave -group regfile_U_7 -group reg_file_sp -label ra -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[31]
# register file signals
add wave -group regfile_U_7 -label regWrite    -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_7/we
add wave -group regfile_U_7 -label addreg1     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a1
add wave -group regfile_U_7 -label addreg2     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a2
add wave -group regfile_U_7 -label addreg3     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a3
add wave -group regfile_U_7 -label wrdata3     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/wd3
add wave -group regfile_U_7 -label rdreg1      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd1
add wave -group regfile_U_7 -label rdreg2      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd2

# signing extended
add wave -group ext_sign_U_8 -label immconst -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_8/innum
add wave -group ext_sign_U_8 -label extimm   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_8/outnum

# extension of the address instruction
add wave -group slt2_U_9 -label extimm -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_9/in
add wave -group slt2_U_9 -label sltimm -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_9/out

# source B argument ALU
add wave -group mux_alu_src_B_U_10 -label rdreg2  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_10/a
add wave -group mux_alu_src_B_U_10 -label extimm  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_10/b
add wave -group mux_alu_src_B_U_10 -label alu_src -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_10/cntrl
add wave -group mux_alu_src_B_U_10 -label srcB    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_10/out

# alu signals
add wave -group alu_signals_U_11 -label srcA      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/a
add wave -group alu_signals_U_11 -label srcB      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/b
add wave -group alu_signals_U_11 -label alu_cntrl -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_11/cntrl
add wave -group alu_signals_U_11 -label rsltALU   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/result
add wave -group alu_signals_U_11 -label zero_f    -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_11/zero

# data from memory or result ALU
add wave -group mux_alurslt_or_data_U_12 -label rsltALU    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/a
add wave -group mux_alurslt_or_data_U_12 -label mem_data   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/b
add wave -group mux_alurslt_or_data_U_12 -label mem_to_reg -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_12/cntrl
add wave -group mux_alurslt_or_data_U_12 -label wrdata3    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/out 

# run simulation
run -all

# expand signals diagramm
wave zoom full
