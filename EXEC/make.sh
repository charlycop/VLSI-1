ghdl -a SHIFTER/LSL/shifter_lsl.vhdl 
  738  ghdl -a SHIFTER/LSL/shifter_lsr.vhdl 
  739  ghdl -a SHIFTER/LSR/shifter_lsr.vhdl 
  740  ghdl -a SHIFTER/LSL/shifter_lsl.vhdl 
  741  ghdl -a SHIFTER/LSR/shifter_lsr.vhdl
  742  ghdl -a SHIFTER/ASR/shifter_asr.vhdl
  743  ghdl -a SHIFTER/ROR/shifter_ror.vhdl
  744  ghdl -a SHIFTER/shifter.vhdl
  745  ghdl -a ALU/alu.vhdl 
  746  ghdl -a FIFO/fifo_72b.vhdl 
  747  ghdl -a exec.vhdl 
  748  ghdl -e -v exec_tb.vhdl 
  749  ghdl -a exec_tb.vhdl 
  750  ghdl -e -v TestBenchExec
  751  ghdl -r TestBenchExec --vcd=exec.vcd
  752  gtkwave exec.vcd 

