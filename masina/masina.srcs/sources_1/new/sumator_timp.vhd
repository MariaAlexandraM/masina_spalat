----------------------------------------------------------------------------------
-- Company: UTCN
-- Student: Pal Tudor 
-- 
-- Design Name: 
-- Module Name: sumator_timp
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator_timp is
    Port ( enable, presp, clatire, clk : in BIT;
           viteza, temp : in BIT_VECTOR(1 downto 0);
           sel : in BIT_VECTOR(2 downto 0);
           led : in BIT_VECTOR(2 downto 0);
           timp : out STD_LOGIC_VECTOR(15 downto 0));
end sumator_timp;

architecture Behavioral of sumator_timp is
signal count : STD_LOGIC_VECTOR(15 downto 0);
begin
    timp <= count;
    process(enable, presp, clatire,viteza, temp, sel)
    begin
        case sel is
            when "001" => count <= X"097E"; --2430 secunde
            when "010" => count <= X"09BA"; --2490 secunde
            when "011" => count <= X"0BEA"; --3050 secunde
            when "100" => count <= X"0E42"; --3650 secunde
            when "101" => count <= X"0C4E"; --3150 secunde
            when "000" => if temp = "00" then
                                count <= count + X"001E"; --30 sec
                          elsif temp = "01" then
                                count <= count + X"0032"; --50 sec
                          elsif temp = "10" then
                                count <= count + X"005A"; --90 sec
                          elsif temp = "11" then
                                count <= count + X"0096"; --150 sec
                          end if;
                          if presp = '1' then count <= count + X"0480"; -- 20 min
                          end if;
                          if clatire = '1' then count <= count + X"0258"; -- 10 min
                          end if;
                          count <= count + X"0960"; -- 40 min
             when others => count <= X"0000";
            end case;  
    end process;
end Behavioral;
