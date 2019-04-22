library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controle is port( --UNITE DE CONTROLE
  clk, rst, PSRin : in std_logic;
  Instruction : in std_logic_vector (31 downto 0);
  Rn, Rd,  Rm : out std_logic_vector (3 downto 0);
  RegWr, ALUsrc, MemWr, WrSrc, nPCSel, RegSel : out std_logic;
  ALUctr : out std_logic_vector ( 1 downto 0);
  Imm : out std_logic_vector (7 downto 0);
  Offset : out std_logic_vector (23 downto 0));
end entity;
  


architecture comportemental of Controle is
  
  Signal PSRen : std_logic;
  Signal PSRout, PSRin_int : std_logic_vector (31 downto 0);
  
  
  begin
    E_SGNEXT : entity work.SGNEXT_1b port map (A => PSRin, S => PSRin_int); --Etend le signe du bit de signe en sortie de l'ALU
    E_PSR : entity work.PSR port map (CLK => clk, Rst => rst, We => PSRen, Datain => PSRin_int, Dataout => PSRout); --Registre 32 stockant le siogne de sortie de l'ALU
    E_DECOD : entity work.Instruction_decoder port map (Instruction => instruction, PSRout => PSRout, Rn => Rn, Rm => Rm, Rd => Rd, --Decodeur d'instructions, commande tous les signaux utilisés par l'unité de traitement
                                              RegWr => RegWr, ALUsrc => ALUsrc, PSREn => PSRen, MemWr => MemWr, WrSrc => WrSrc,
                                              nPCSel => nPCSel, RegSel => Regsel, Imm => Imm, ALUctr => ALUctr, Offset =>Offset);
                                              
end architecture;