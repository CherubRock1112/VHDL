Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PSR is --Registre 32bits stockant l'état du processeur (ici le bit de signe en sortie de l'ALU)
port(
  CLK, RST, WE : in std_logic;
  DataIn : in std_logic_vector(31 downto 0);
  DataOut : out std_logic_vector(31 downto 0)
);
end entity;

architecture RTL of PSR is
begin --Si l'écriture est autorisé, actualise la valeur du signe de sortie de l'ALU
  process(CLK, RST)
  begin
    If RST = '1' then
      DataOut <= "00000000000000000000000000000000";
    elsif RISING_EDGE(CLK) and WE = '1' then
      DataOut <= DataIn;
    end if;
  end process;
end architecture;
