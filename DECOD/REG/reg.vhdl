library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is
	port(
	-- Write Port 1 prioritaire - Vient de l'EXEC (Rd)
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1		: in Std_Logic_Vector(3 downto 0);
		wen1		: in Std_Logic;

	-- Write Port 2 non prioritaire
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2		: in Std_Logic_Vector(3 downto 0);
		wen2		: in Std_Logic;

	-- Write CSPR Port
		wcry		: in Std_Logic;
		wzero		: in Std_Logic;
		wneg		: in Std_Logic;
		wovr		: in Std_Logic;
		cspr_wb		: in Std_Logic;
		
	-- Read Port 1 32 bits   -- OP 1 Rn
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1		: in Std_Logic_Vector(3 downto 0); -- Read address Rn
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits   -- OP2 -> Rm quand pas immediat
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2		: in Std_Logic_Vector(3 downto 0); -- Rm
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits   -- Rs -> quand decalage et bit 4 = 1
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3		: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port
		reg_cry		: out Std_Logic;
		reg_zero	: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_cznv	: out Std_Logic; -- ??
		reg_ovr		: out Std_Logic;
		reg_vv		: out Std_Logic;
		
	-- Invalidate Port -- Pour les ecritures
		inval_adr1	: in Std_Logic_Vector(3 downto 0);
		inval1		: in Std_Logic; 

		inval_adr2	: in Std_Logic_Vector(3 downto 0);
		inval2		: in Std_Logic;

		inval_czn	: in Std_Logic;
		inval_ovr	: in Std_Logic;

	-- PC
		reg_pc		: out Std_Logic_Vector(31 downto 0);
		reg_pcv		: out Std_Logic;
		inc_pc		: in Std_Logic;
	
	-- global interface
		ck			: in Std_Logic;
		reset_n		: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end Reg;

architecture Behavior OF Reg is

type reg_arr is array (0 to 15) of std_logic_vector(31 downto 0);
signal registers : reg_arr; 
signal regs_inval : std_logic_vector(15 downto 0); -- inval de chaque reg
-- Je vais rajouter les signaux 
signal s_reg_rd1 : std_logic_vector(31 downto 0);


begin

    process(ck, reset_n)
    begin

        if reset_n = '0' then -- Au reset tous les registres sont considérés comme valides même si ils ne contiennent alors aucune valeur pertinente. 
            regs_inval(15 downto 0) <= (others =>'0');

		elsif rising_edge(ck) then
			
			-- Inval bits
            regs_inval(to_integer(unsigned(inval_adr1))) <= inval1; -- Rn
            regs_inval(to_integer(unsigned(inval_adr2))) <= inval2; -- Rm

            -- Reg sig update
            reg_rd1 <= registers (to_integer(unsigned(radr1)));
            reg_v1  <= regs_inval(to_integer(unsigned(radr1)));

            reg_rd2 <= registers (to_integer(unsigned(radr2)));
            reg_v2  <= regs_inval(to_integer(unsigned(radr2)));

            reg_rd3 <= registers (to_integer(unsigned(radr3)));
			reg_v3  <= regs_inval(to_integer(unsigned(radr3)));
			


            if wen1 = '1' and regs_inval(to_integer(unsigned(wadr1))) = '1' then
                reg_rd1 <= wdata1; -- Ecriture de la data dans le reg
                regs_inval(to_integer(unsigned(wadr1))) <= '0';   -- Remet le bit a valid
			end if;
			
			-- PC inc
			if inc_pc = '1' and regs_inval(15) = '1' then -- est-ce qu'on doit vérifier pc_inval ?
				reg_pc <= std_logic_vector(to_integer(unsigned(reg_pc)) + 4);
				-- Est_ce qu'on doit valider apres l'écriture de +4 du coup ?
			end if;

			-- Update des flags
			if inval_czn = '1' then
				reg_zero <= wzero;
				reg_cry  <= wcry;
				reg_neg  <= wneg;

			end if;
            

        end if;

    end process;
end Behavior;
