Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre is port(
  CLK : in std_logic;
  W : in std_logic_vector(31 downto 0);
  RA : in std_logic_vector(3 downto 0);
  RB : in std_logic_vector(3 downto 0);
  RW : in std_logic_vector(3 downto 0);
  WE : in std_logic;
  A : out std_logic_vector(31 downto 0);
  B : out std_logic_vector(31 downto 0));
end entity;

architecture comportemental of registre is

-- Declaration Type Tableau Memoire
type table is array(15 downto 0) of std_logic_vector(31 downto 0);

-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is

variable result : table;

begin
  for i in 14 downto 0 loop
    result(i) := (others => '0');
    result(i)(i) := '1'; --Initilialise des valeurs
  end loop;
  result(15) := X"00000030";
  return result;
end init_banc;

-- Declaration et Initialisation du Banc de Registres 16x32bits
signal Banc : table := init_banc;

begin
  A <= Banc(to_integer(unsigned(RA))); -- le Bus A prend la valeur contenu dans le registre n°RA
  B <= Banc(to_integer(unsigned(RB)));
  process (CLK)
  begin
    if (WE = '1') and FALLING_EDGE(CLK) then --Si l'écriture est autorisé, écritdu front descendant pour  quetoute l'instruction puisse êtrréalisé en moins d'un coup d'horloge
        Banc(to_integer(unsigned(RW))) <= W; --Ecrit la valeur du bus d'entrée W dans le registre n°RW
    end if;
  end process;
end architecture;
