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
    Port ( enable, presp, clatire, clk : in STD_LOGIC;
           viteza, temp : in STD_LOGIC_VECTOR(1 downto 0);
           sel : in STD_LOGIC_VECTOR(2 downto 0);
           digits : out STD_LOGIC_VECTOR(15 downto 0));
end sumator_timp;

architecture Behavioral of sumator_timp is
signal timp : STD_LOGIC_VECTOR(15 downto 0);
begin
    process(enable, presp, clatire,viteza, temp, sel)
    begin
        case sel is
            when "001" => timp(15 downto 12) <= "0100"; --4
                          timp(11 downto 8) <= "0000"; --0
                          timp(7 downto 4) <= "0011"; --3
                          timp(3 downto 0) <= "0000"; --0
            when "010" => timp(15 downto 12) <= "0100"; --4
                          timp(11 downto 8) <= "0001"; --1
                          timp(7 downto 4) <= "0011"; --3
                          timp(3 downto 0) <= "0000"; --0
            when "011" => timp(15 downto 12) <= "0101"; --5
                          timp(11 downto 8) <= "0000"; --0 
                          timp(7 downto 4) <= "0101"; --5  
                          timp(3 downto 0) <= "0000"; --0  
            when "100" => timp(15 downto 12) <= "0110"; --6
                          timp(11 downto 8) <= "0000"; --0 
                          timp(7 downto 4) <= "0101"; --5  
                          timp(3 downto 0) <= "0000"; --0  
            when "101" => timp(15 downto 12) <= "0101"; --5
                          timp(11 downto 8) <= "0010"; --2 
                          timp(7 downto 4) <= "0011"; --3  
                          timp(3 downto 0) <= "0000"; --0  
            when "000" => if temp = "00" then
                                timp(7 downto 4) <= timp(7 downto 4) + "0011"; -- + 30 sec
                          elsif temp = "01" then
                                timp(7 downto 4) <= timp(7 downto 4) + "0101"; -- + 50 sec
                          elsif temp = "10" then
                                timp(11 downto 8) <= timp(11 downto 8) + "0001"; -- + 1 min
                                timp(7 downto 4) <= timp(7 downto 4) + "0011"; -- + 30 sec
                          elsif temp = "11" then
                                timp(11 downto 8) <= timp(11 downto 8) + "0010"; -- + 2 min
                                timp(7 downto 4) <= timp(7 downto 4) + "0011"; -- + 30 sec
                          end if;
                          if presp = '1' then timp(15 downto 12) <= timp(15 downto 12) + "0010"; -- + 20 min
                          end if;
                          if clatire = '1' then timp(15 downto 12) <= timp(15 downto 12) + "0001"; -- + 10 min
                          end if;
                          timp(15 downto 12) <= timp(15 downto 12) + "0100"; -- + 40 min
             when others => timp <= X"0000";
                            timp <= X"0000";
            end case;  
    end process;

end Behavioral;