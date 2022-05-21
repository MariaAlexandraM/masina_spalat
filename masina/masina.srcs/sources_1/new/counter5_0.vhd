----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: counter5_0
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity counter5_0 is	
	port (CLK: in bit;
	      PL: in bit; -- parallel load activ pe 1
	      R: in bit; -- reset activ pe 1
	      --usa_inchisa: in bit;
	      --start: in bit;
		  --I: in bit_vector(2 downto 0);	 -- val cu care se face incarcarea paralela 
		  --tcd: out bit;  -- terminal count down: activ pe 1, folosit ca si clk pt numaratorul urmator 
		  Q: out bit_vector(2 downto 0)); 
end counter5_0;				  

architecture Behavioral of counter5_0 is
    component bist_d is
        port (CLK: in bit;
              R: in bit; -- reset asincron
              D: in bit;
              Q: out bit);
    end component;

--signal cifra: bit_vector(2 downto 0);
signal D_num: BIT_VECTOR(2 downto 0) := "000";
signal Q2, Q1, Q0: BIT;
begin	
    -- extrase din tabel de adevar, dupa K map, si minimizarea functiilor
    D_num(2) <= (not(Q2) and not(Q1) and not(Q0)) or (Q2 and Q0) or (Q2 and Q1 and not(Q0));
    D_num(1) <= (Q2 and not(Q1) and not(Q0)) or (not(Q2) and Q1 and Q0);
    D_num(0) <= not(Q0) or (Q2 and Q1);

    -- bistabilele cascadate
    D2: bist_d port map(CLK => CLK, 
                        D => D_num(2), 
                        R => R, 
                        Q => Q2);  
    D1: bist_d port map(CLK => CLK, 
                        D => D_num(1), 
                        R => R, 
                        Q => Q1);  
    D0: bist_d port map(CLK => CLK, 
                        D => D_num(0), 
                        R => R, 
                        Q => Q0); 
    
    -- schimbarea de nume pentru semnale ca sa nu am multe paranteze la asignarile pentru D_num-uri
    Q(2) <= Q2;
    Q(1) <= Q1;
    Q(0) <= Q0;
    
--	process (CLK, PL, R, usa_inchisa, start)
--	begin 
--		if(PL = '1' and usa_inchisa = '1' and start = '1') then
--			cifra <= I;
--		elsif(R = '1' and usa_inchisa = '1' and start = '1') then  -- revine la 0 daca avem activ reset-ul
--			cifra <= "0000";
--		elsif(CLK'event and CLK = '1' and usa_inchisa = '1' and start = '1') then	 
--			case cifra is
--				when "0101" => cifra <= "0100";
--				when "0100" => cifra <= "0011";
--				when "0011" => cifra <= "0010";
--				when "0010" => cifra <= "0001";
--				when "0001" => cifra <= "0000";		
--				when others => cifra <= "0101";
--			end case;		
--		end if;	   
--		if (cifra = "0000") or (I = "0000" and PL = '1') then
--			tcd <= '1';
--		else
--			tcd <= '0';	
--		end if;		  
--		Q <= cifra; 	   
--	end process;	   
end Behavioral;
