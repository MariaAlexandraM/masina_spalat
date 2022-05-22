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
    
    component timer_ssd is
        port (clk_60Hz: in bit;
              R: in bit; -- reset asincron
              PL: in bit;  
              digit_3, digit_2, digit_1, digit_0: in bit_vector(3 downto 0); -- fiecare cifra e reprezentata pe 4 biti 
              Q3, Q2, Q1, Q0: out bit_vector(3 downto 0));																				
    end component;
    
    component div_frecv_ssd is
        port (clk_100Mhz: in std_logic; -- perioada de 10ns
              clk_ssd: out std_logic); -- 60Hz
    end component;

signal digits : BIT_VECTOR (15 downto 0);
signal beculets : STD_LOGIC_VECTOR(2 downto 0);
signal sel : STD_LOGIC_VECTOR(2 downto 0);
signal temp, viteza : STD_LOGIC_VECTOR(1 downto 0);
signal presp, clatire : STD_LOGIC;
signal clk_60hz, clk_100Mhz: BIT;
signal R, PL: bit;
-- ca sa testez pe placa cu semnalu intermediar
signal trei: bit_vector(3 downto 0) := "0011";
signal doi: bit_vector(3 downto 0) := "0010";
signal unu: bit_vector(3 downto 0) := "0001";
signal zero: bit_vector(3 downto 0) := "0000";
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
    
    divizor_frecventa: div_frecv_ssd port map(clk_100Mhz => clk_100Mhz,
                                              clk_ssd => clk_60Hz);  
                                              
    timerssd: timer_ssd port map(clk_60Hz => clk_60Hz,
                                 R => R,
                                 PL => PL,
                                 digit_3 => trei,
                                 digit_2 => doi,
                                 digit_1 => unu,
                                 digit_0 => zero,
                                 Q3 => digits(15 downto 12),
                                 Q2 => digits(11 downto 8),
                                 Q1 => digits(7 downto 4),
                                 Q0 => digits(3 downto 0));

end Behavioral;