library IEEE, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_lsr is 
port(	shift_val : in  Std_Logic_Vector(4 downto 0);
    	din       : in  Std_Logic_Vector(31 downto 0);
    	cin       : in  Std_Logic;
    	dout      : out Std_Logic_Vector(31 downto 0);
    	cout      : out Std_Logic);
end shifter_lsr;

architecture Behavioral of shifter_lsr is 
signal res1, res2, res3, res4, res5, res : STD_LOGIC_VECTOR(32 downto 0);
begin

	res1 <= din & cin;

  res2 <= "0000000000000000" & res1(32 downto 16)when shift_val(4) = '1' else res1;
  res3 <= "00000000"         & res2(32 downto 8) when shift_val(3) = '1' else res2;
  res4 <= "0000"             & res3(32 downto 4) when shift_val(2) = '1' else res3;
  res5 <= "00"               & res4(32 downto 2) when shift_val(1) = '1' else res4;
  res  <= '0'                & res5(32 downto 1) when shift_val(0) = '1' else res5;

  dout <= res(32 downto 1);
  cout <= res(0);

end Behavioral;

	 

