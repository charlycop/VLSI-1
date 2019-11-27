library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Alu is
port (   op1  : in  Std_Logic_Vector(31 downto 0);
         op2  : in  Std_Logic_Vector(31 downto 0);
         cin  : in  Std_Logic; -- std_logic en signed ??
         cmd  : in  Std_Logic_Vector(1 downto 0);
         res  : out Std_Logic_Vector(31 downto 0);
         cout : out Std_Logic;
         z    : out Std_Logic;
         n    : out Std_Logic;
         v    : out Std_Logic;
         vdd  : in  bit;
         vss  : in  bit );
end Alu;


architecture proc of Alu is
signal res_temp : STD_LOGIC_VECTOR(31 downto 0);
signal c31 : std_logic;  -- carry in  bit 32
signal c_out: std_logic; -- carry out bit 32
begin


res_temp <=  (std_logic_vector(signed(op1) + signed(op2) + ("0000000000000000000000000000000" & cin))) when cmd="00" else
				  	     (op1 AND op2) when cmd="01" else  
						 (op1 OR  op2) when cmd="10" else 
						 (op1 XOR op2) when cmd="11";


c31 <= (op1(31) xor op2(31)) xor res_temp(31); -- carry in bit 32

z <= '1' when res_temp = "00000000000000000000000000000000" else '0';
n <= res_temp(31);
c_out <=  (op1(31) and c31) xor (op2(31) and c31) xor (op1(31) and op2(31));
cout <= c_out;
v <= c31 xor c_out;

res <= res_temp;

end proc;


