library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity shifter_test is
end shifter_test;

architecture test of shifter_test is
		signal shift_lsl :   Std_Logic;
    signal shift_lsr :   Std_Logic;
    signal shift_asr :   Std_Logic;
    signal shift_ror :   Std_Logic;
    --signal shift_rrx :   Std_Logic;
    signal shift_val :   Std_Logic_Vector(4 downto 0);
    signal din       :   Std_Logic_Vector(31 downto 0);
    signal cin       :   Std_Logic;
    signal dout      :   Std_Logic_Vector(31 downto 0);
    signal cout      :   Std_Logic;
    -- global interface
    signal vdd       :   bit;
    signal vss       :   bit; 


begin
	shift_lsl <= '1' ,'0' after 50 ns;
	shift_lsr <= '0', '1' after 75 ns;
	shift_asr <= '0';
	shift_ror <= '0', '1' after 50 ns, '0' after 75 ns;
	--shift_rrx <= '1' after 50 ns;	
	shift_val <= "10000", "00011" after 100 ns;
	din <= "10011111000000000000000000000111", "10101010101010100101010101010101" after 50 ns, "00000000000000000000000000000011" after 100 ns;

	cin <= '1', '1' after 75 ns;

	shifter: entity work.Shifter
	-- rrx a rajouter dans la map
	port map(shift_lsl, shift_lsr, shift_asr, shift_ror, shift_val, din, cin, dout, cout, vdd, vss);
end test;

