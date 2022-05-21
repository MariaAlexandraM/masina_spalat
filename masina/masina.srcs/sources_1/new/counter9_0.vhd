----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: counter9_0
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

entity counter9_0 is	
	port (CLK: in bit;	   
		  PL: in bit;
	      R: in bit; -- reset activ pe 1
	      EN: in std_logic;
	      --usa_inchisa: in bit;
	      --start: in bit;
		  --I: in bit_vector(3 downto 0);	 -- val cu care se face incarcarea paralela 
		  tc: out bit;  -- terminal count down: activ pe 1, folosit ca si clk pt numaratorul urmator 
		  Q: out bit_vector(3 downto 0)); 
end counter9_0;				  

architecture Behavioral of counter9_0 is
    component bist_d is
        port (CLK: in bit;
              R: in bit; -- reset asincron
              D: in bit;
              EN: in std_logic; -- enable care atunci cand devine 0, opreste numararea si ramane acolo
              Q: out bit);
    end component;

--signal cifra: bit_vector(3 downto 0);
signal D_num: BIT_VECTOR(3 downto 0) := "0000";
signal Q3, Q2, Q1, Q0: BIT;
begin
    -- extrase din tabel de adevar, dupa K map, si minimizarea functiilor
    D_num(3) <= (not(Q3) and not(Q2) and not(Q1) and not(Q0)) or (Q3 and Q2) or (Q3 and not(Q1) and Q0) or (Q3 and Q1);
    D_num(2) <= (Q3 and not(Q2) and not(Q1) and not(Q0)) or (not(Q3) and Q2 and Q1) or (not(Q3) and Q2 and Q0);
    D_num(1) <= ((Q3 xor Q2) and not(Q1) and not(Q0)) or (not(Q3) and Q1 and Q0);
    D_num(0) <= not(Q0) or (Q3 and Q2) or (Q3 and Q1);

    -- bistabilele cascadate
    D3: bist_d port map(CLK => CLK, 
                        D => D_num(3), 
                        EN => EN,
                        R => R, 
                        Q => Q3);  
    D2: bist_d port map(CLK => CLK, 
                        D => D_num(2), 
                        EN => EN,
                        R => R, 
                        Q => Q2);  
    D1: bist_d port map(CLK => CLK, 
                        D => D_num(1), 
                        EN => EN,
                        R => R, 
                        Q => Q1);  
    D0: bist_d port map(CLK => CLK, 
                        D => D_num(0),
                        EN => EN, 
                        R => R, 
                        Q => Q0); 
    
    -- schimbarea de nume pentru semnale ca sa nu am multe paranteze la asignarile pentru D_num-uri
    Q(3) <= Q3;
    Q(2) <= Q2;
    Q(1) <= Q1;
    Q(0) <= Q0;		   
	
	process(D_num, CLK)
	begin 
		if CLK'event and CLK = '1' then 
			if Q3 = '0' and Q2 = '0' and Q1 = '0' and Q0 = '0' then 
				tc <= '1';
			else 
				tc <= '0';
			end if;
		end if;
	end process;
    
--	process (CLK, PL, R, usa_inchisa, start)
--	begin 
--			if(PL = '1' and usa_inchisa = '1' and start = '1') then
--				cifra <= I;
--			elsif(R = '1' and usa_inchisa = '1' and start = '1') then  -- revine la 0 daca avem activ reset-ul
--				cifra <= "0000";
--			elsif(CLK'event and CLK = '1' and usa_inchisa = '1' and start = '1') then	 
--				case cifra is
--					when "1001" => cifra <= "1000";
--					when "1000" => cifra <= "0111";
--					when "0111" => cifra <= "0110";
--					when "0110" => cifra <= "0101";
--					when "0101" => cifra <= "0100";
--					when "0100" => cifra <= "0011";
--					when "0011" => cifra <= "0010";
--					when "0010" => cifra <= "0001";
--					when "0001" => cifra <= "0000"; 
--					when others => cifra <= "1001";
--				end case;		
--			end if;	   
--			if (cifra = "0000") or (I = "0000" and PL = '1') then
--				tcd <= '1';
--			else
--				tcd <= '0';	
--			end if;		  
--			Q <= cifra; 	   
--	end process;	   
end Behavioral;
