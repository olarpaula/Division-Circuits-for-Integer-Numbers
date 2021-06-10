----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2020 04:01:25 PM
-- Design Name: 
-- Module Name: sumator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity sumator is
    Generic (n: integer);
    Port (x: in std_logic_vector(n-1 downto 0);
          y: in std_logic_vector(n-1 downto 0);
          tin: in std_logic;
          suma: out std_logic_vector(n-1 downto 0);
          tout: out std_logic
          );
--  Port ( );
end sumator;

architecture Behavioral of sumator is

component full_adder 
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);  
end component;

signal t: std_logic_vector(n downto 0);

begin

t(0) <= tin;
tout <= t(n);

p1: for i in 0 to n-1 generate
  p2: full_adder port map (x(i), y(i), t(i), suma(i), t(i+1));
end generate;

end Behavioral;

