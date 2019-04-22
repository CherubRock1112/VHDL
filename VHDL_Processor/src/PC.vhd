Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is 
port(
  CLK, RST : in std_logic;
  A : in std_logic_vector(31 downto 0);
  S : out std_logic_vector(31 downto 0)
);
end entity;

architecture rtl of PC is
begin
  process(CLK)
  begin
    if RST = '1' then
      S <= "00000000000000000000000000000000";
    elsif RISING_EDGE(CLK) then
      S <= A;
    end if;
  end process;
end architecture;