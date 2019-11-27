library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_ror is
port( shift_val : in  Std_Logic_Vector(4 downto 0);
      din       : in  Std_Logic_Vector(31 downto 0);
      cin       : in  Std_Logic;
      dout      : out Std_Logic_Vector(31 downto 0);
      cout      : out Std_Logic);
end shifter_ror;

architecture Behavioral of shifter_ror is
signal res1, res2, res3, res4, res5, res : STD_LOGIC_VECTOR(32 downto 0);

begin

  res1 <= din & cin;

  res2 <= res1(16 downto 1) & res1(32 downto 17) & res1(17) when shift_val(4) = '1' else res1;-- res_temp(17) -> devient la carry (res_temp(0))
  res3 <= res2(8 downto 1)  & res2(32 downto 9)  & res2(9)  when shift_val(3) = '1' else res2;
  res4 <= res3(4 downto 1)  & res3(32 downto 5)  & res3(5)  when shift_val(2) = '1' else res3;
  res5 <= res4(2 downto 1)  & res4(32 downto 3)  & res4(3)  when shift_val(1) = '1' else res4;
  res  <= res5(1)           & res5(32 downto 2)  & res5(2)  when shift_val(0) = '1' else res5;

  dout <= res(32 downto 1);
  cout <= res(0);

end Behavioral;              
