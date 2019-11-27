library IEEE, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
port( 
			shift_lsl : in  Std_logic;
			shift_lsr : in  Std_logic;
			shift_asr : in  Std_logic;
			shift_ror : in  Std_logic;
			shift_val : in  Std_Logic_Vector(4 downto 0);
      din       : in  Std_Logic_Vector(31 downto 0);
      cin       : in  Std_Logic;
      dout      : out Std_Logic_Vector(31 downto 0);
      cout      : out Std_Logic;
			vdd       : in  bit;
			vss				: in bit);
end shifter;

architecture Behavioral of shifter is
signal lsl_dout : std_logic_vector(31 downto 0);
signal lsl_cout : std_logic;

signal lsr_dout : std_logic_vector(31 downto 0);
signal lsr_cout : std_logic;

signal asr_dout : std_logic_vector(31 downto 0);
signal asr_cout : std_logic;

signal ror_dout : std_logic_vector(31 downto 0);
signal ror_cout : std_logic;

signal sel      : std_logic_vector(4 downto 0);

begin

	lsl_ent : entity work.shifter_lsl port
						map(shift_val, din, cin, lsl_dout, lsl_cout);

	lsr_ent : entity work.shifter_lsr port
						map(shift_val, din, cin, lsr_dout, lsr_cout);

	asr_ent : entity work.shifter_asr port
						map(shift_val, din, cin, asr_dout, asr_cout);

	ror_ent : entity work.shifter_ror port
						map(shift_val, din, cin, ror_dout, ror_cout);

	sel <= '0' & shift_ror & shift_asr & shift_lsr & shift_lsl;

	dout <= lsl_dout when sel = "00001" else
					lsr_dout when sel = "00010" else
					asr_dout when sel = "00100" else  -- rrx a  rajouter
					ror_dout when sel = "01000" else
					x"00000000";

	cout <= lsl_cout when sel = "00001" else
					lsr_cout when sel = "00010" else
					asr_cout when sel = "00100" else
					ror_cout when sel = "01000" else
					'0';
 
end Behavioral;


