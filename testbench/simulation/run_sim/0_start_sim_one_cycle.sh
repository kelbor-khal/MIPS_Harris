#!/bin/bash

echo "Set testbenches for one-cycle MIPS CPU: "
echo "0 - Simple test with Harris Harris book; "

read -p "Choose script to run: " number_script;
cd testbench/simulation/run_sim/

# start modelsim
case $number_script in
    0) vsim -do ../tcl_script/one_cycle/0_test_harris.tcl;;
    *) echo "This script is not available. Please choose a different one.";;
esac

# delete temp var sim
rm -r -v work
rm -rf $(ls | grep -E "vlog|vsim|transc|ini")
cd ../../../