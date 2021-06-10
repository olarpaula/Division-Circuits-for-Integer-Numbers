----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2020 11:52:52 AM
-- Design Name: 
-- Module Name: impartire_fara_refacere_rest - Behavioral
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

entity impartire_fara_refacere_rest is
--  Port ( );
end impartire_fara_refacere_rest;

architecture Behavioral of impartire_fara_refacere_rest is

signal n: integer := 5;

signal clk: std_logic;
signal rst:  std_logic;
signal start: std_logic;
signal x: std_logic_vector(n-1 downto 0);
signal y: std_logic_vector(n-1 downto 0);
signal a: std_logic_vector(n-1 downto 0);
signal q: std_logic_vector(n-1 downto 0);
signal term: std_logic;

constant clk_period: time := 10 ns;

--signal m: integer := 16 - n;
--signal zero: std_logic_vector(m-1 downto 0) := (others => '0');
--signal x_ssd: std_logic_vector(15 downto 0);
--signal y_ssd: std_logic_vector(15 downto 0);
--signal q_ssd: std_logic_vector(15 downto 0);
--signal a_ssd: std_logic_vector(15 downto 0);

begin
gen_clk: process
    begin
       Clk <= '0';
        wait for clk_period;
       Clk <= '1';
        wait for clk_period;
 end process;
 
 dut: entity work.main_fara_refacere_rest generic map (n => n)
                                          port map(clk => clk,
                                           rst => rst,
                                           start => start,
                                           x => x,
                                           y => y,
                                           a => a,
                                           q => q,
                                           term => term
                                           );
                                           
gen_vec: process
    begin
        wait for clk_period;
        Rst <= '1';
        wait for clk_period;
        Rst <= '0';
        wait for clk_period;
      
        x <= "00110"; 
        y <= "00100";
        
        start<='1';
		wait for clk_period;
		start <= '0';
		--wait for 2 *clk_period;
		--start <= '1';
		--wait for clk_period;
		--wait for clk_period;
		--start <= '0';
		--wait for 2 * clk_period;
        wait;
        
end process gen_vec;

--x_ssd <= zero & x;
--y_ssd <= zero & y;
--q_ssd <= zero & q;
--a_ssd <= zero & a;

end Behavioral;
