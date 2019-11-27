library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity shifter_test_lsr is
end shifter_test_lsr;

architecture test of shifter_test_lsr is
    signal shift_val :   Std_Logic_Vector(4 downto 0);
    signal din       :   Std_Logic_Vector(31 downto 0);
    signal cin       :   Std_Logic;
    signal dout      :   Std_Logic_Vector(31 downto 0);
    signal cout      :   Std_Logic;

begin
	shift_val <= "00001", "10000" after 100 ns;
	din <= "00000000000000000000000000000110", "11000000000000010000000000000011" after 50 ns, "10101010101010100000000000000000" after 100 ns;

	cin <= '0', '1' after 75 ns;

	shifter: entity work.shifter_lsr
	port map(shift_val, din, cin, dout, cout);
end test;

