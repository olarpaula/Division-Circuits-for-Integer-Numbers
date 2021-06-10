----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2020 05:42:11 PM
-- Design Name: 
-- Module Name: uc_fara_refacere - Behavioral
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


entity uc_fara_refacere is
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
end uc_fara_refacere;

architecture Behavioral of uc_fara_refacere is

type stari is (idle, init, last_add, conditie_bs_last, setare_bs_1, setare_bs_0, conditie_bs, conditie_q0, check, scadere_contor, conditie,  adunare, scadere, shiftare, stop, setare_q_0, setare_q_1);
signal c: integer;-- := n;
signal bs: integer;
signal stare: stari := idle;

signal bs1: std_logic;
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
                when shiftare => stare <= conditie;
                
                when conditie => 
                    if bs1 = '1' then
                        stare <= adunare;
                    else
                        stare <= scadere;
                    end if;
                
                when adunare => stare <= conditie_q0;
                when scadere => stare <= conditie_q0;
                
                when conditie_q0 =>
                    if a_n = '1' then 
                        stare <= setare_q_0;
                    else
                        stare <= setare_q_1;
                    end if;
                    
                when setare_q_0 => stare <= conditie_bs;
                when setare_q_1 => stare <= conditie_bs;
                
                when conditie_bs =>
                    if a_n = '1' then 
                        stare <= setare_bs_1;
                    else
                        stare <= setare_bs_0;
                    end if;
                    
                when setare_bs_1 => stare <= scadere_contor;
                when setare_bs_0 => stare <= scadere_contor;
                
                when scadere_contor => stare <= check;
                when check =>
                    if c = 0 then
                        stare <= conditie_bs_last;
                    else
                        stare <= shiftare;
                    end if;
                    
                when conditie_bs_last => 
                    if bs1 = '1' then
                        stare <= last_add;
                    else
                        stare <= stop;
                    end if;
                    
                when last_add => stare <= stop;
                    
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
            bs <= 0;
            bs1 <= '0';
                
        when adunare =>
            loada <= '1';
            
        when last_add =>
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
            
        when setare_bs_1 =>
            bs1 <= '1';
            
        when setare_bs_0 =>
            bs1 <= '0';
            
        when scadere_contor =>
            c <= c - 1;
            
        when others =>
    end case;
end process;


end Behavioral;


