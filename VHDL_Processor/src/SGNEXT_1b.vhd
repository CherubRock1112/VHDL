Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  use IEEE.std_logic_arith.all;
  
  entity SGNEXT_1b is
    port (
      A : in std_logic;
      S : out std_logic_vector (31 downto 0)
    );
  end entity;

  architecture comportemental of SGNEXT_1b is
  begin
    process(A) --Etend le signe quand l'entrée est un seul bit
      begin
        if (A = '1') then
          S <= x"FFFFFFFF";
        else
          S <= x"00000000";
        end if;
      end process;
  end architecture;
