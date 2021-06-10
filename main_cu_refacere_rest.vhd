----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2020 12:06:39 PM
-- Design Name: 
-- Module Name: main_cu_refacere_rest - Behavioral
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

entity main_cu_refacere_rest is
--  Port ( );
Generic (n: integer);
    Port (clk: in std_logic;
          rst: in std_logic;
          start: in std_logic;
          x: in std_logic_vector(n-1 downto 0);
          y: in std_logic_vector(n-1 downto 0);
          a: out std_logic_vector(n-1 downto 0);
          q: out std_logic_vector(n-1 downto 0);
          term: out std_logic
          );
end main_cu_refacere_rest;

architecture Behavioral of main_cu_refacere_rest is

-- semnale uc
signal loada: std_logic;
signal loadb: std_logic;
signal loadq: std_logic;
signal shlaq: std_logic;
signal subb: std_logic;
signal out_qn_1: std_logic;

signal sig_a: std_logic_vector(n-1 downto 0);
signal sig_q: std_logic_vector(n-1 downto 0);
signal sig_b: std_logic_vector(n-1 downto 0);

-- pt adder
signal in_adder_b: std_logic_vector(n-1 downto 0);
signal tout: std_logic;
signal suma: std_logic_vector(n-1 downto 0);

signal out_q0: std_logic;
          
begin

proc_intrare_in_sumator: process(subb, sig_b)
begin
    for i in 0 to n-1 loop
        in_adder_b(i) <= subb xor sig_b(i);
    end loop;
end process;

p1: entity work.reg_n generic map (n => n)
                    port map (Clk => Clk,
                              rst => rst,
                              ce => loadb,
                              d => y,
                              q => sig_b
                             );

p2: entity work.sumat_n generic map (n => n) 
                     port map (x => sig_a,
                               y => in_adder_b,
                               tin => subb,
                               suma => suma, 
                               tout => tout
                               );                            
                            
p3: entity work.reg_deplasare_n generic map (n => n)
                     port map (clk => clk,
                               rst => rst,
                               ce => shlaq,
                               sri => sig_q(n-1),
                               load => loada,
                               d => suma,
                               q => sig_a
                               );          
                               
p4: entity work.uc_cu_refacere_rest generic map (n => n) 
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
                            
p5: entity work.reg2_deplasare_n generic map (n => n)
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
             
--schimbare_a <= sig_q(0);
q <= sig_q;
a <= sig_a;

end Behavioral;

