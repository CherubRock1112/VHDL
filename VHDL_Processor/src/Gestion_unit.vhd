Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gestion is --UNITE DE GESTION
generic(
  I : integer := 24;
  J : integer := 32
);
port(
  Offset : in std_logic_vector(23 downto 0); --Offset du PC
  nPCsel, clk, rst : in std_logic; --Signal de controle du multiplexeur, clk, rst
  Inst : out std_logic_vector(31 downto 0) --Valeur sur 32bits de l'instruction choisie
);
end entity;


architecture comportemental of gestion is
  
  Signal EXTout, PCin, PCout : std_logic_vector(31 downto 0);
  Signal Min1 : std_logic_vector(31 downto 0);
  Signal Min2 : std_logic_vector(31 downto 0);
  
begin
  Ext : entity work.SGNEXT generic map(N => I) port map(A => Offset, S => EXTout); --Etend le signe de l'offset pour atteidnre 32 bits
  Mux : entity work.MUX2 generic map(N => J) port map(A => Min1, B => Min2, COM => nPCsel, S => PCin); --Choisi entre PC+1 et PC+Offset+1
  Ins : entity work.instruction_memory port map(PC => PCout, Instruction => Inst); --Mémoire d'instruction
  PC : entity work.PC port map(CLK => clk, RST => rst, A => PCin, S => PCout); --Changement synchrone de l'instruction selon le bus de sortie du MUX 
  
  Min1 <= std_logic_vector(unsigned(PCout) + 1); --PC+1
  Min2 <= std_logic_vector(unsigned(PCout) + unsigned(EXTout) + 1); --PC + Offset + 1
end architecture;