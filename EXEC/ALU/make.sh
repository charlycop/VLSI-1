#!/bin/bash
set -e

ghdl -a -v alu.vhdl
ghdl -a -v alu_tb.vhdl 
ghdl -e -v alu_test
ghdl -r alu_test --vcd=alu.vcd

