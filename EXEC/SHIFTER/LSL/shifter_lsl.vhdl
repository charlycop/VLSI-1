library IEEE, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_lsl is 
port(	shift_val : in  Std_Logic_Vector(4 downto 0);
    	din       : in  Std_Logic_Vector(31 downto 0);
    	cin       : in  Std_Logic;
    	dout      : out Std_Logic_Vector(31 downto 0);
    	cout      : out Std_Logic);
end shifter_lsl;

architecture Behavioral of shifter_lsl is 
signal res1, res2, res3, res4, res5, res: STD_LOGIC_VECTOR(32 downto 0);

begin
	res1 <= cin & din;

	res2 <= res1(16 downto 0) & "0000000000000000" when shift_val(4) = '1' else res1;
	res3 <= res2(24 downto 0) & "00000000"         when shift_val(3) = '1' else res2;
	res4 <= res3(28 downto 0) & "0000" 						 when shift_val(2) = '1' else res3;
	res5 <= res4(30 downto 0) & "00"               when shift_val(1) = '1' else res4;
	res  <= res5(31 downto 0) & '0'                when shift_val(0) = '1' else res5;

	dout <= res(31 downto 0);
	cout <= res(32);

end Behavioral;
