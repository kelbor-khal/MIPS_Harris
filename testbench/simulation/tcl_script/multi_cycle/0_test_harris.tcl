#!/usr/bin/tclsh
# create working library
vlib work

# compile all SV source files
vlog -sv ../../../multi_cycle/source/alu.sv
vlog -sv ../../../multi_cycle/source/aludec.sv
vlog -sv ../../../multi_cycle/source/controller.sv
vlog -sv ../../../multi_cycle/source/datapath.sv
vlog -sv ../../../multi_cycle/source/dff_m.sv
vlog -sv ../../../multi_cycle/source/dffe_m.sv
vlog -sv ../../../multi_cycle/source/exsign.sv
vlog -sv ../../../multi_cycle/source/maindec.sv
vlog -sv ../../../multi_cycle/source/mips.sv
vlog -sv ../../../multi_cycle/source/mux2.sv
vlog -sv ../../../multi_cycle/source/mux4.sv
vlog -sv ../../../multi_cycle/source/parameters.vh
vlog -sv ../../../multi_cycle/source/regfile.sv
vlog -sv ../../../multi_cycle/source/slt2.sv
vlog -sv ../../../multi_cycle/source/top_multi_cycle.sv

# compile memory block
vlog -sv ../../../multi_cycle/source/mem.sv

# compile testbench file
vlog -sv ../../source_test/multi_cycle/0_harris_test.sv

# open the testbench
vsim work.mips_test_harris

# load software
mem load -i ../../../programs/bin_view/0_test_harris.mem -format binary /mips_test_harris/dut/U_1/mem

# add all signals tu time diagramm
add wave -radix hexadecimal /mips_test_harris/*

# display current instruction
add wave -label crnt_instr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/instr_datapath

# memory signals
add wave -group memory -label memory_sp   -radix hexadecimal sim:/mips_test_harris/dut/U_1/mem
add wave -group memory -label memWrite    -radix binary      sim:/mips_test_harris/dut/U_1/we
add wave -group memory -label mem_addr    -radix hexadecimal sim:/mips_test_harris/dut/U_1/addr
add wave -group memory -label wr_mem_data -radix hexadecimal sim:/mips_test_harris/dut/U_1/wr_data
add wave -group memory -label mem_IorD    -radix hexadecimal sim:/mips_test_harris/dut/U_1/mem_out

# main controller signals
add wave -group main_decoder -label opcode     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/opcode
add wave -group main_decoder -label pc_write   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/pc_write
add wave -group main_decoder -label branch     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/branch
add wave -group main_decoder -label memWrite   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/memWrite
add wave -group main_decoder -label iRwrite    -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/iRwrite
add wave -group main_decoder -label regWrite   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/regWrite
add wave -group main_decoder -label IorD       -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/IorD
add wave -group main_decoder -label regDst     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/regDst
add wave -group main_decoder -label memToReg   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/memToReg
add wave -group main_decoder -label aluSrc_a   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/aluSrc_a
add wave -group main_decoder -label aluSrc_b   -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/aluSrc_b
add wave -group main_decoder -label pc_src     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/pc_src
add wave -group main_decoder -label alu_op     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/alu_op
add wave -group main_decoder -label state_reg  -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/state_reg
add wave -group main_decoder -label state_next -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_0/state_next

# alu decoder
add wave -group alu_decoder -label alu_operation     -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/aluop
add wave -group alu_decoder -label alu_control       -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/cntrl
add wave -group alu_decoder -label field_instr_funct -radix binary sim:/mips_test_harris/dut/U_0/U_0/U_1/funct

# program counter signals
add wave -group pc_U_0 -label pc_value   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/in
add wave -group pc_U_0 -label crnt_aaddr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_0/out
add wave -group pc_U_0 -label en_pc      -radix binary      sim:/mips_test_harris/dut/U_0/U_1/en_pc

# mux controlled next instruction or alu out
add wave -group mux_next_or_alu_out_U_1 -label crnt_aaddr    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/a
add wave -group mux_next_or_alu_out_U_1 -label aluOut        -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/b
add wave -group mux_next_or_alu_out_U_1 -label input_cntrl   -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_1/cntrl
add wave -group mux_next_or_alu_out_U_1 -label addr_mem_data -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_1/out

# invisible dff instruction memory
add wave -group invisb_instrm_U_2 -label mem_data -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_2/in
add wave -group invisb_instrm_U_2 -label instr    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_2/out
add wave -group invisb_instrm_U_2 -label iRwrite  -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_2/en

# invisible dff data from memory
add wave -group invisb_datam_U_3 -label mem_data -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_3/in
add wave -group invisb_datam_U_3 -label data     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_3/out

# shift address for jump instruction
add wave -group slt_addr_jum_U_4 -label data -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/in
add wave -group slt_addr_jum_U_4 -label data -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_4/out
 
# source addreg3 for register file
add wave -group mux_source_addreg3_U_5 -label intstr[20:16] -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/a
add wave -group mux_source_addreg3_U_5 -label intstr[15:11] -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/b
add wave -group mux_source_addreg3_U_5 -label regDst        -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_5/cntrl
add wave -group mux_source_addreg3_U_5 -label addreg3       -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_5/out

# write data 3 for register file
add wave -group mux_source_wrdata3_U_6 -label aluOut -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_6/a
add wave -group mux_source_wrdata3_U_6 -label data   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_6/b
add wave -group mux_source_wrdata3_U_6 -label cntrl  -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_6/cntrl
add wave -group mux_source_wrdata3_U_6 -label out    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_6/out

# regfile signals
# registera map
add wave -group regfile_U_7 -group reg_file_sp -label r0  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/regf[0]
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
# registers silgnals
add wave -group regfile_U_7 -label regWrite    -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_7/we
add wave -group regfile_U_7 -label addreg1     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a1
add wave -group regfile_U_7 -label addreg2     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a2
add wave -group regfile_U_7 -label addreg3     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/a3
add wave -group regfile_U_7 -label wrdata3     -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/wd3
add wave -group regfile_U_7 -label rdreg1      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd1
add wave -group regfile_U_7 -label rdreg2      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_7/rd2

# extimm module
add wave -group exsign_U_8 -label input_number  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_8/innum
add wave -group exsign_U_8 -label output_number -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_8/outnum

# invisible dff for regfile rdreg1
add wave -group invisb_rdreg1_U_9 -label in  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_9/in
add wave -group invisb_rdreg1_U_9 -label out -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_9/out

# invisible dff for regfile rdreg2
add wave -group invisb_rdreg2_U_10 -label in  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_10/in
add wave -group invisb_rdreg2_U_10 -label out -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_10/out

# alu source argument A mux
add wave -group mux_alu_src_A_U_11 -label crnt_adrr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/a
add wave -group mux_alu_src_A_U_11 -label rd_delay1 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/b
add wave -group mux_alu_src_A_U_11 -label aluSrc_a  -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_11/cntrl
add wave -group mux_alu_src_A_U_11 -label srcA      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_11/out

# alu source argument B mux
add wave -group mux_alu_src_B_U_12 -label rd_delay2 -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/a
add wave -group mux_alu_src_B_U_12 -label 4'b0100   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/b
add wave -group mux_alu_src_B_U_12 -label extimm    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/c
add wave -group mux_alu_src_B_U_12 -label sltimm    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/d
add wave -group mux_alu_src_B_U_12 -label aluSrc_b  -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_12/cntrl
add wave -group mux_alu_src_B_U_12 -label srcB      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_12/out

# exsign for beq instruction
add wave -group exsign_U_13 -label input_number  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_13/in
add wave -group exsign_U_13 -label output_number -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_13/out

# alu signals
add wave -group alu_signals_U_14 -label srcA      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_14/a
add wave -group alu_signals_U_14 -label srcB      -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_14/b
add wave -group alu_signals_U_14 -label alu_cntrl -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_14/cntrl
add wave -group alu_signals_U_14 -label rsltALU   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_14/result
add wave -group alu_signals_U_14 -label zero_f    -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_14/zero

# mux program counter source
add wave -group mux_pc_source_U_15 -label rsltALU   -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_15/a
add wave -group mux_pc_source_U_15 -label aluOut    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_15/b
add wave -group mux_pc_source_U_15 -label jump_addr -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_15/c
add wave -group mux_pc_source_U_15 -label 32b'b0    -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_15/d
add wave -group mux_pc_source_U_15 -label pc_src    -radix binary      sim:/mips_test_harris/dut/U_0/U_1/U_15/cntrl
add wave -group mux_pc_source_U_15 -label pc_value  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_15/out

# invisible dff for alu out
add wave -group invisb_alu_out_U_16 -label in  -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_16/in
add wave -group invisb_alu_out_U_16 -label out -radix hexadecimal sim:/mips_test_harris/dut/U_0/U_1/U_16/out

# run simulation
run -all

# expand signals diagramm
wave zoom full
