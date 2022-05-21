----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: ssd_driver
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


entity ssd_driver is 
    port(clk_100Mhz: in std_logic;
         digits: in std_logic_vector(15 downto 0);
         an: out std_logic_vector(3 downto 0);
         cat: out std_logic_vector(6 downto 0));
end ssd_driver;

architecture Behavioral of ssd_driver is
    component SSD is
        Port ( digit : in STD_LOGIC_VECTOR(15 downto 0);
               clk : in STD_LOGIC;
               an : out STD_LOGIC_VECTOR (3 downto 0);
               cat : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    component div_frecv_ssd is
	   port (clk_100Mhz: in std_logic; -- perioada de 10ns
	  	     clk_ssd: out std_logic); -- 60Hz
    end component;
signal clk_60Hz: std_logic;
begin
    -- dintr-un clk de 100Mhz generez un clk de 60Hz = clk-ul ssd-ului 
    divizor_frecventa: div_frecv_ssd port map(clk_100Mhz => clk_100Mhz,
                                              clk_ssd => clk_60Hz);  
    -- aici il dau la ssd
    seven_segment_display: ssd port map(digit => digits, 
                      clk => clk_60Hz,
                      an => an,
                      cat => cat);   
end Behavioral;