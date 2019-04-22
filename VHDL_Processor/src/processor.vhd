Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is port( --PROCESSEUR ENTIER, instancie les 3 unitées, Traitement, Controle et Gestion des instructions
  Clk, rst : in std_logic);
end entity;


architecture comportemental of processor is
  
  Signal nPCsel, ALUsrc, MemWr, WrSrc, RegWr, flag, RegSel : std_logic;
  Signal instruction, W  : std_logic_vector (31 downto 0);
  Signal Rn, Rd, Rm : std_logic_vector (3 downto 0);
  Signal ALUctr : std_logic_vector (1 downto 0);
  Signal Offset : std_logic_vector (23 downto 0);
  Signal Imm : std_logic_vector (7 downto 0);
  
  begin
    
    E_GESTION : entity work.Gestion generic map ( I => 24, J => 32) port map ( Offset => Offset, nPCSel => nPCSel, clk => clk, rst => rst, Inst => Instruction);
    
    E_CONTROLE : entity work.Controle port map (clk => Clk, rst => Rst, PSRin => flag, Instruction => instruction, Rn => Rn, Rd => Rd, Rm => Rm, 
                              RegWr => RegWr, ALUsrc => ALUsrc, MemWr => MemWr, WrSrc => WrSrc, nPCSel => nPCSel, RegSel => RegSel,
                              ALUctr => ALUctr, Imm => Imm, Offset => Offset);
    E_AUT : entity work.AUT port map (Clk => clk, RegWr => RegWr, com => ALUsrc, com2 => WrSrc, WrEn => MemWr,  RegSel => RegSel, Ra => Rn, Rw => Rd, Rb => Rm, OP => ALUctr,
                              W => W, M => flag, Imm => Imm);
   
end architecture; 
  