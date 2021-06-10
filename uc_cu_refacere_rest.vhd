----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2020 12:03:41 PM
-- Design Name: 
-- Module Name: uc_cu_refacere_rest - Behavioral
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

entity uc_cu_refacere_rest is
--  Port ( );
    Generic (n: integer);
    Port (clk: in std_logic;
          rst: in std_logic;
          start: in std_logic;
          a_n: in std_logic;
          --...
          
          loada: out std_logic;
          loadb: out std_logic;
          loadq: out std_logic;
          shlaq: out std_logic;
          subb: out std_logic;
          out_q0: out std_logic;
          term: out std_logic
          );
end uc_cu_refacere_rest;

architecture Behavioral of uc_cu_refacere_rest is

type stari is (idle, init, check, scadere_contor, conditie,  adunare, scadere, shiftare, stop, setare_q_0, setare_q_1);
signal c: integer;-- := n;
signal stare: stari := idle;

signal inter_q: std_logic_vector(n-1 downto 0);

begin


process(clk)
begin
    if clk'event and clk = '1' then 
        if rst = '1' then
            stare <= idle;
        else
            case stare is
                when idle =>
                    if start = '1' then
                        stare <= init;
                    end if;
                when init => stare <= shiftare;
                when shiftare => stare <= scadere;
                when scadere => stare <= conditie;
              --  when setare_q0 => stare <= conditie;
                when conditie =>
                    if a_n = '1' then 
                        stare <= setare_q_0;
                    else 
                        stare <= setare_q_1;
                    end if;
                when setare_q_0 => stare <= adunare;   
                when adunare => stare <= scadere_contor;
                when setare_q_1 => stare <= scadere_contor;
                when scadere_contor => stare <= check;
                when check =>
                    if c = 0 then
                        stare <= stop;
                    else
                        stare <= shiftare;
                    end if;
                when others =>
                    stare <= idle;
            end case;
        end if;
    end if;
end process;



process(stare)
begin
     loada <= '0';
     loadb <= '0';
     loadq <= '0';
     shlaq <= '0';
     subb <= '0';
     term <= '0';
     out_q0 <= '0';
            
    case stare is
        when init =>
            loadb <= '1';
            loadq <= '1';
            c <= n;
                
        when adunare =>
            loada <= '1';
            
        when scadere =>
            loada <= '1';
            subb <= '1';
            
        when shiftare =>
            shlaq <= '1';
            
        when stop =>
            term <= '1'; 
            
        when setare_q_0 =>
            out_q0 <= '1';
            
        when setare_q_1 =>
            out_q0 <= '1';
            
        when scadere_contor =>
            c <= c - 1;
            
        when others =>
    end case;
end process;


end Behavioral;
