----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: mux2_1
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

entity mux2_1 is
    port(PL: in bit; -- folosit ca selectie 
         X: in bit_vector(1 downto 0);
         Y: out bit);
end mux2_1;

architecture Behavioral of mux2_1 is
begin
	Y <= (not(PL) and X(0)) or (PL and X(1));
end Behavioral;