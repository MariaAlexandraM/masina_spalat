----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Moldovan Maria
-- 
-- Design Name: 
-- Module Name: bist_d
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

entity bist_d is
    port (CLK: in bit;
          R: in bit; -- reset asincron
          D: in bit;
          Q: out bit);
end bist_d;

architecture Behavioral of bist_d is
begin
    process(CLK, R) -- depinde doar de clk si reset
    begin 
        if R = '1' then 
            Q <= '0';
        elsif CLK'event and CLK = '1' then 
            Q <= D;
        end if;
    end process;
end Behavioral;