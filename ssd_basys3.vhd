----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2020 12:49:14 PM
-- Design Name: 
-- Module Name: ssd_basys3 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd_basys3 is
    Port ( 
        clk : in std_logic;
        in_digit: in std_logic_vector(15 downto 0);
        cat : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0)
        );
end ssd_basys3;

architecture Behavioral of ssd_basys3 is

signal out_ssd : std_logic_vector(6 downto 0) := "0000000"; 
signal out_mux1 : std_logic_vector(3 downto 0) := "0000"; --catre catozi
signal out_mux2 : std_logic_vector(3 downto 0) := "0000" ; --catre anozi
signal sel : std_logic_vector(1 downto 0) := "00";
signal count: std_logic_vector(15 downto 0) := "0000000000000000";


begin

process(clk)
begin
  if clk'event and clk = '1' then
    count <= count + 1;
  end if;
end process;

sel <= count(15 downto 14);

process(in_digit, sel)
begin
  case sel is
    when "00" => out_mux1 <= in_digit(3 downto 0);
    when "01" => out_mux1 <= in_digit(7 downto 4);
    when "10" => out_mux1 <= in_digit(11 downto 8);
    when "11" => out_mux1 <= in_digit(15 downto 12);
  end case;
end process;

process(sel)
begin
  case sel is
    when "00" => out_mux2 <= "1110";
    when "01" => out_mux2 <= "1101";
    when "10" => out_mux2 <= "1011";
    when "11" => out_mux2 <= "0111";
  end case;
end process;

process(out_mux1)
begin
  case out_mux1 is           --abcdefg gfedcba 
    when "0000" => out_ssd <= "1000000";    --0
    when "0001" => out_ssd <= "1111001";    --1
    when "0010" => out_ssd <= "0100100";    --2
    when "0011" => out_ssd <= "0110000";    --3
    when "0100" => out_ssd <= "0011001";    --4
    when "0101" => out_ssd <= "0010010";    --5
    when "0110" => out_ssd <= "0000010";    --6
    when "0111" => out_ssd <= "1111000";    --7
    when "1000" => out_ssd <= "0000000";    --8
    when "1001" => out_ssd <= "0010000";    --9
    when "1010" => out_ssd <= "0001000";    --A
    when "1011" => out_ssd <= "0000011";    --b
    when "1100" => out_ssd <= "1000110";    --C
    when "1101" => out_ssd <= "0100001";    --d
    when "1110" => out_ssd <= "0000110";    --E
    when "1111" => out_ssd <= "0001110";    --F
    when others => out_ssd <= "1000000";    --0
  end case;
end process;

cat <= out_ssd;
an <= out_mux2;

end Behavioral;
