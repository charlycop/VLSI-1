library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXec is
	port(
	-- Decode interface synchro
			dec2exe_empty	: in Std_logic;
			exe_pop			: out Std_logic;

	-- Decode interface operands
			dec_op1			: in Std_Logic_Vector(31 downto 0); -- first alu input
			dec_op2			: in Std_Logic_Vector(31 downto 0); -- shifter input
			dec_exe_dest	: in Std_Logic_Vector(3 downto 0); -- Rd destination
			dec_exe_wb		: in Std_Logic; -- Rd destination write back
			dec_flag_wb		: in Std_Logic; -- CSPR modifiy

	-- Decode to mem interface 
			dec_mem_data	: in Std_Logic_Vector(31 downto 0); -- data to MEM W
			dec_mem_dest	: in Std_Logic_Vector(3 downto 0); -- Destination MEM R
			dec_pre_index 	: in Std_logic;

			dec_mem_lw		: in Std_Logic;
			dec_mem_lb		: in Std_Logic;
			dec_mem_sw		: in Std_Logic;
			dec_mem_sb		: in Std_Logic;

	-- Shifter command
			dec_shift_lsl	: in Std_Logic;
			dec_shift_lsr	: in Std_Logic;
			dec_shift_asr	: in Std_Logic;
			dec_shift_ror	: in Std_Logic;
			dec_shift_rrx	: in Std_Logic;
			dec_shift_val	: in Std_Logic_Vector(4 downto 0);
			dec_cy			: in Std_Logic;

	-- Alu operand selection
			dec_comp_op1	: in Std_Logic;
			dec_comp_op2	: in Std_Logic;
			dec_alu_cy 		: in Std_Logic;

	-- Alu command
			dec_alu_cmd		: in Std_Logic_Vector(1 downto 0);

	-- Exe bypass to decod
			exe_res			: out Std_Logic_Vector(31 downto 0);

			exe_c				: out Std_Logic;
			exe_v				: out Std_Logic;
			exe_n				: out Std_Logic;
			exe_z				: out Std_Logic;

			exe_dest			: out Std_Logic_Vector(3 downto 0); -- Rd destination
			exe_wb			: out Std_Logic; -- Rd destination write back
			exe_flag_wb		: out Std_Logic; -- CSPR modifiy

	-- Mem interface
	        -- pour la compilation, utilisé 2 fois dans l'inst
			exe_mem_adr		: inout Std_Logic_Vector(31 downto 0); -- Alu res register
			exe_mem_data	: out Std_Logic_Vector(31 downto 0);
			exe_mem_dest	: out Std_Logic_Vector(3 downto 0);

			exe_mem_lw		: out Std_Logic;
			exe_mem_lb		: out Std_Logic;
			exe_mem_sw		: out Std_Logic;
			exe_mem_sb		: out Std_Logic;

			exe2mem_empty	: out Std_logic;
			mem_pop			: in Std_logic;

	-- global interface
			ck					: in Std_logic;
			reset_n			: in Std_logic;
			vdd				: in bit;
			vss				: in bit);
end EXec;

----------------------------------------------------------------------

architecture Behavior OF EXec is

signal s_shifter_dout, s_alu_op1, s_alu_op2, s_alu_res : STD_LOGIC_VECTOR(31 downto 0);
signal s_shifter_cout, s_alu_cout :           STD_LOGIC;

signal s_dec_comp_op1, s_dec_comp_op2 :       STD_LOGIC_VECTOR(31 downto 0);

-- pour que ca compile
signal exe2mem_push, exe2mem_full:            STD_LOGIC;



begin



--  Component instantiation.

	shifter_inst: entity work.Shifter port
	map(shift_lsl => dec_shift_lsl,
		  shift_lsr => dec_shift_lsr,
		  shift_asr => dec_shift_asr, 
		  shift_ror => dec_shift_ror,
		  shift_val => dec_shift_val,
		  din       => dec_op2,
		  cin       => dec_cy,
		  dout      => s_shifter_dout,
		  cout      => s_shifter_cout,
		  vdd       => vdd,
		  vss		    => vss);


	alu_inst : entity work.Alu port
	map(op1   => s_alu_op1,
		  op2	  => s_alu_op2,
      cin   => dec_alu_cy,
      cmd   => dec_alu_cmd,
      res   => s_alu_res,
      cout  => s_alu_cout,
      z     => exe_z,
      n     => exe_n,
      v     => exe_v,
      vdd   => vdd,
			vss		 => vss);

	exec2mem : entity work.fifo
	port map (	din(71)	 => dec_mem_lw,
					din(70)	 => dec_mem_lb,
					din(69)	 => dec_mem_sw,
					din(68)	 => dec_mem_sb,

					din(67 downto 64) => dec_mem_dest,
					din(63 downto 32) => dec_mem_data,
					din(31 downto 0)	 => exe_mem_adr,

					dout(71)	 => exe_mem_lw,
					dout(70)	 => exe_mem_lb,
					dout(69)	 => exe_mem_sw,
					dout(68)	 => exe_mem_sb,

					dout(67 downto 64) => exe_mem_dest,
					dout(63 downto 32) => exe_mem_data,
					dout(31 downto 0)	 => exe_mem_adr,

					push		 => exe2mem_push,
					pop		 => mem_pop,

					empty		 => exe2mem_empty,
					full		 => exe2mem_full,

					reset_n	 => reset_n,
					ck			 => ck,
					vdd		 => vdd,
					vss		 => vss);


-- Car signal va sur 2 sorties
exe_res <= s_alu_res;

-- Extension du signe
s_dec_comp_op1 <= X"FFFFFFFF" WHEN dec_comp_op1 = '1' else (others=>'0');
s_dec_comp_op2 <= X"FFFFFFFF" WHEN dec_comp_op2 = '1' else (others=>'0');

-- Opérandes de l'ALU
s_alu_op1  <= dec_op1 XOR s_dec_comp_op1;
s_alu_op2  <= s_shifter_dout XOR s_dec_comp_op2;

-- Flag exe_c
with dec_alu_cmd select
	exe_c <= s_alu_cout     when "00",
             s_shifter_cout when others;



end Behavior;

