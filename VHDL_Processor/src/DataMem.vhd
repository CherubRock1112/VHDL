Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DMem is 
port(
  CLK, WrEn : in std_logic;
  Addr : in std_logic_vector(5 downto 0); --6 dernier bits du bus de sortie de l'ALU
  DataIn : in std_logic_vector(31 downto 0);
  DataOut : out std_logic_vector(31 downto 0));
end entity;

architecture comportemental of DMem is

-- Declaration Type Tableau Memoire
type table is array(63 downto 0) of std_logic_vector(31 downto 0);

-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is

variable result : table;

begin
  for i in 62 downto 0 loop
    result(i) := (others => '0');
  end loop;
  for i in 31 downto 0 loop
    result(30+i)(i) := '1'; --Initialise des valeurs pour les cases allant de 32 à 61
  end loop;
  result(63) := X"00000030";
  return result;
end init_banc;

-- Declaration et Initialisation du Banc de Registres 16x32bits
signal Banc : table := init_banc;

begin
  DataOut <= Banc(to_integer(unsigned(Addr)));
  process(CLK)
  begin
    If FALLING_EDGE(CLK) and WrEn = '1' Then --Si l'écriture est autorisé, écrit la valeur du bus d'entrée à la case mémoire n° Addr
      Banc(to_integer(unsigned(Addr))) <= DataIn;
    end if;
  end process;
  DataOut <= Banc(to_integer(unsigned(Addr))); --Renvoi la valeur de la case mémoire n° Addr
end architecture;
