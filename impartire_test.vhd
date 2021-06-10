----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2021 10:37:04 PM
-- Design Name: 
-- Module Name: impartire_test - Behavioral
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

entity impartire_test is
    Port (clk: in std_logic;
          sw : in STD_LOGIC_VECTOR (15 downto 0);
          led : out STD_LOGIC_VECTOR (15 downto 0);
          an : out STD_LOGIC_VECTOR (3 downto 0);
          cat : out STD_LOGIC_VECTOR (6 downto 0)
          );
 end impartire_test;

architecture Behavioral of impartire_test is


-- semnale uc

signal rst: std_logic;
signal start: std_logic;
signal a:  std_logic_vector(15 downto 0);
signal q: std_logic_vector(15 downto 0);
signal term: std_logic;
signal x: std_logic_vector(15 downto 0) := x"0004";
signal y: std_logic_vector(15 downto 0) := x"0003";
signal loada: std_logic;
signal loadb: std_logic;
signal loadq: std_logic;
signal shlaq: std_logic;
signal subb: std_logic;
signal out_qn_1: std_logic;

signal sig_a: std_logic_vector(15 downto 0);
signal sig_q: std_logic_vector(15 downto 0);
signal sig_b: std_logic_vector(15 downto 0);

-- pt adder
signal in_adder_b: std_logic_vector(15 downto 0);
signal tout: std_logic;
signal suma: std_logic_vector(15 downto 0);

signal anod: STD_LOGIC_VECTOR (3 downto 0);
signal catod: STD_LOGIC_VECTOR (6 downto 0);
signal digitsToSsd: std_logic_vector(15 downto 0);

signal out_q0: std_logic;
          
begin

proc_intrare_in_sumator: process(subb, sig_b)
begin
    for i in 0 to 15 loop
        in_adder_b(i) <= subb xor sig_b(i);
    end loop;
end process;

p1: entity work.reg_n generic map (n => 16)
                    port map (Clk => Clk,
                              rst => rst,
                              ce => loadb,
                              d => y,
                              q => sig_b
                             );

p2: entity work.sumat_n generic map (n => 16) 
                     port map (x => sig_a,
                               y => in_adder_b,
                               tin => subb,
                               suma => suma, 
                               tout => tout
                               );                            
                            
p3: entity work.reg_deplasare_n generic map (n => 16)
                     port map (clk => clk,
                               rst => rst,
                               ce => shlaq,
                               sri => sig_q(15),
                               load => loada,
                               d => suma,
                               q => sig_a
                               );          
                               
p4: entity work.uc_cu_refacere_rest generic map (n => 15) 
                   port map (clk => clk,
                             rst => rst,
                             start => start,
                             a_n => tout,
                             loada => loada,
                             loadb => loadb,
                             loadq => loadq,
                             shlaq => shlaq,
                             subb => subb,
                             out_q0 => out_q0,
                             term => term
                            );
                            
p5: entity work.reg2_deplasare_n generic map (n => 16)
                     port map (clk => clk,
                               rst => rst,
                               ce => shlaq,
                               sri => '0',
                               load => loadq,
                               d => x,
                               q => sig_q,
                               a_n => tout,
                               update => out_q0
                               );                          
p6: entity work.ssd_basys3 port map (clk => clk,
                                     in_digit => digitsToSsd,
                                     cat => catod,
                                     an => anod);
             
--schimbare_a <= sig_q(0);
q <= sig_q;
a <= sig_a;

process(sw(0))
begin
    case (sw(0)) is
        when '0' => start <= '0';
        when '1' => start <= '1';
    end case;
end process;

process(sw(1))
begin
    case (sw(1)) is
        when '0' => rst <= '0';
        when '1' => rst <= '1';
    end case;
end process;

process(sw(3 downto 2)) 
begin
    case (sw(3 downto 2)) is
        when "00" => digitsToSsd <= x;
        when "01" => digitsToSsd <= y;
        when "10" => digitsToSsd <= q;
        when "11" => digitsToSsd <= a;
    end case;
end process;

an <= anod;
cat <= catod;

led(0) <= term;


end Behavioral;
