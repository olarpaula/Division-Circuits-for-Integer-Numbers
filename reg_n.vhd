----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2020 05:36:16 PM
-- Design Name: 
-- Module Name: reg_n - Behavioral
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

entity reg_n is
--  Port ( );
    Generic (n: integer);
    Port (Clk: in std_logic;
          rst: in std_logic;
          ce: in std_logic;
          d: in std_logic_vector(n-1 downto 0);
          q: out std_logic_vector(n-1 downto 0)
          );
end reg_n;

architecture Behavioral of reg_n is
begin

process(clk)
begin
    if clk'event and clk = '1' then
        if rst = '1' then
            q <= (others => '0');
        else
            if ce = '1' then 
                q <= d;
            end if;
        end if;
    end if;
end process;

end Behavioral;

