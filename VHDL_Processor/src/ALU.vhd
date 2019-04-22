Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  
entity ALU is port(
  OP : in std_logic_vector (1 downto 0); --Signal de Commande
  A, B : in std_logic_vector (31 downto 0); --bus de 32 bits
  S : out std_logic_vector (31 downto 0); --Resultat
  N : out std_logic); --Signe (1 si négatif, 0 si positif
end entity;

architecture comportemental of ALU is

Signal temp : std_logic_vector (31 downto 0);
begin
  with OP select --selon la valeur du signal de commande
  temp <= std_logic_vector(signed(A) + signed(B)) when "00", --Addition quand 00
          B when "01", -- B quand 01
          std_logic_vector(signed(A)-signed(B)) when "10", --Soustraction quand 10
          A when "11", -- A quand 11
          (others =>'0') when others;
  N <= temp(31); --N prend la valeur du signe du résultat
  S <= temp;
  end architecture;
    
    