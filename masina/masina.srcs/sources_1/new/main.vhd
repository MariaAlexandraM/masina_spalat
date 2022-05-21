----------------------------------------------------------------------------------
-- Company: UTCN
-- Students: Moldovan Maria si Pal Tudor 
-- 
-- Design Name:
-- Module Name: main
-- Project Name: Masina de spalat haine
-- Target Devices: Basys3
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

entity main is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end main;

architecture Behavioral of main is
signal enable : std_logic;

component debouncer is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

component SSD is
    Port ( digit : in STD_LOGIC_VECTOR(15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component SSD;

component sumator_timp is
    Port ( enable, presp, clatire, clk : in STD_LOGIC;
           viteza, temp : in STD_LOGIC_VECTOR(1 downto 0);
           sel : in STD_LOGIC_VECTOR(2 downto 0);
           led : in STD_LOGIC_VECTOR(2 downto 0);
           timp : out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal digits : STD_LOGIC_VECTOR (15 downto 0);
signal beculets : STD_LOGIC_VECTOR(2 downto 0);
signal sel : STD_LOGIC_VECTOR(2 downto 0);
signal temp, viteza : STD_LOGIC_VECTOR(1 downto 0);
signal presp, clatire : STD_LOGIC;

begin
    sel <= sw(15 downto 13);
    temp <= sw(12 downto 11);
    viteza <= sw(10 downto 9);
    presp <= sw(8);
    clatire <= sw(7);
    led(15 downto 13) <= beculets;

    DEBOUNCER1 : debouncer port map(clk,btn(0),enable);
    SUMATOR_TIMP1 : sumator_timp port map(enable, presp, clatire, clk, viteza, temp, sel, beculets, digits);
    SSD1 : SSD port map(digits, clk, an, cat);

end Behavioral;
