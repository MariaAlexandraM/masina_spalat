----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: timer_ssd
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
use IEEE.STD_LOGIC_1164.ALL;  

entity timer_ssd is
    port (clk_60Hz: in bit;
          R: in bit; -- reset asincron
          PL: in bit;  
		  digit_3, digit_2, digit_1, digit_0: in bit_vector(3 downto 0); -- fiecare cifra e reprezentata pe 4 biti 
          Q3, Q2, Q1, Q0: out bit_vector(3 downto 0));																				
end timer_ssd;

architecture Behavioral of timer_ssd is
signal tc3, tc2, tc1, tc0: bit; -- terminal count pentru fiecare numarator; reprezinta clk pentru urmatorul numarator 
signal q_or: bit_vector(3 downto 0);
signal Q3_aux, Q2_aux, Q1_aux, Q0_aux: bit_vector(3 downto 0); 
signal EN: std_logic;
	component counter5_0 is	
		port (CLK: in bit;
		      PL: in bit; -- parallel load activ pe 1
		      R: in bit; -- reset activ pe 1
		      EN: in std_logic;
		      --usa_inchisa: in bit;
		      --start: in bit;
			  I: in bit_vector(2 downto 0);	 -- val cu care se face incarcarea paralela 
			  tc: out bit;  -- terminal count down: activ pe 1, folosit ca si clk pt numaratorul urmator 
			  Q: out bit_vector(2 downto 0)); 
	end component;	 
	
	component counter9_0 is	
		port (CLK: in bit;			   
			  PL: in bit; -- parallel load activ pe 1
		      R: in bit; -- reset activ pe 1
		      EN: in std_logic;
		      --usa_inchisa: in bit;
		      --start: in bit;
			  I: in bit_vector(3 downto 0);	 -- val cu care se face incarcarea paralela 
			  tc: out bit;  -- terminal count: activ pe 1, folosit ca si clk pt numaratorul urmator 
			  Q: out bit_vector(3 downto 0)); 
	end component;			

begin				
	
	num_0: counter9_0 port map(CLK => clk_60Hz,	 
							   PL => PL,
							   R => R,
							   EN => EN, 
							   I => digit_3,
							   tc => tc0,
							   Q => Q0_aux);
	
	num_1: counter5_0 port map(CLK => tc0,	
							   PL => PL,
							   R => R,
							   EN => EN, 
							   I => digit_2(2 downto 0),
							   tc => tc1,
							   Q => Q1_aux(2 downto 0));
	Q1_aux(3) <= '0';		  
	
	num_2: counter9_0 port map(CLK => tc1,	 
							   PL => PL,
							   R => R,
							   EN => EN, 
							   I => digit_1,
							   tc => tc2,
							   Q => Q2_aux);   
							   
	num_3: counter9_0 port map(CLK => tc2,	 
							   PL => PL,
							   R => R,
							   EN => EN, 
							   I => digit_0,
							   tc => tc3,
							   Q => Q3_aux);   	
							   
	Q3 <= Q3_aux; 
	Q2 <= Q2_aux;
	Q1 <= Q1_aux;
	Q0 <= Q0_aux;
	q_or <= (Q3_aux or Q2_aux or Q1_aux or Q0_aux);
	--EN <= (q_or(3) or q_or(2) or q_or(1) or q_or(0));	  
	
	process(clk_60Hz)
	begin 
		if clk_60Hz'event and clk_60Hz = '1' then 
			if q_or = "0000" then 
				EN <= '0';
			else 
				EN <= '1';
			end if;
		end if;
		
		
	end process;
	
end Behavioral;