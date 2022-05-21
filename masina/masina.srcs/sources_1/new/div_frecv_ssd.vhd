----------------------------------------------------------------------------------
-- Company: UTCN
-- Engineer: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: div_frecv_ssd
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

entity div_frecv_ssd is
	port (clk_100Mhz: in std_logic; -- perioada de 10ns
	  	  clk_ssd: out std_logic); -- 60Hz
end div_frecv_ssd;

architecture Behavioral of div_frecv_ssd is
signal clk_gate: std_logic := '0';
begin
	process(clk_100Mhz)
	variable nr: std_logic_vector(19 downto 0) := (others => '0');																																				 
	begin 	  
		if clk_100Mhz'event and clk_100Mhz = '1' then 
			if nr = "11001011011100110101" then 
				nr := (others => '0');
				clk_gate <= not(clk_gate);
			else nr := nr + 1; 
			end if;
		end if;
		clk_ssd <= clk_gate;
	end process;
end architecture;