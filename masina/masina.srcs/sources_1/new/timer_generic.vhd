----------------------------------------------------------------------------------
-- Company: UTCN
-- Engineer: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: timer_generic
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
											
entity timer_generic is						   
	generic(n: integer);
	port(clk_1Hz: in std_logic; -- 1min in proiect inseamna 1s reala adica 1Hz
		 en: in std_logic;
		 gata: out std_logic);
end timer_generic;

architecture Behavioral of timer_generic is 		
signal gata_aux: std_logic; -- semnal intermediar pt gata
--signal n: integer := 10;
begin  	  
	process(clk_1Hz)
		variable nr: integer := 0; -- numar pana la n - 1 		   			  
	begin			
		if en = '1' then 
			if clk_1Hz'event and clk_1Hz = '1' then
				if (nr = n - 1) then 
					gata_aux <= '1'; 
					nr := 0;
				else 
					nr := nr + 1;
					gata_aux <= '0';
				end if;
			end if;	
		end if;
	end process;
	
	gata <= gata_aux;
end Behavioral;