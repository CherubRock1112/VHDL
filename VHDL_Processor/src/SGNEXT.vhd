Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  use IEEE.std_logic_arith.all;
  

  entity SGNEXT is
    generic (
      N : integer := 32
      );
    port (
      A : in std_logic_vector(N-1 downto 0);
      S : out std_logic_vector (31 downto 0)
    );
  end entity;

  architecture comportemental of SGNEXT is
  begin
    S <= sxt(A,S'length); --Etend le dernier bit de A jusqu'à eteindre 32bits
  end architecture;