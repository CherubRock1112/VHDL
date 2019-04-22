library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Instruction_decoder is port( --Décodeur d'instruction, déduit d'une instruction sur 32 bits la valeurs de tous les signaux de l'unité de traitement et de l'offset du PC
  Instruction : in std_logic_vector (31 downto 0); --Instruction sur 32 bits
  PSRout : in std_logic_vector (31 downto 0); --Valeur du PSR, l'éta tdu processeur (ici le signe de sortie de l'ALU)
  Rn, Rm, Rd : out std_logic_vector (3 downto 0); --Valeur des signaux d'adresse du banc de registre
  RegWr, ALUsrc, PSREn, MemWr, WrSrc, nPCSel, RegSel : out std_logic; --Signaux de controle des MUX et d'écriture
  ALUctr : out std_logic_vector (1 downto 0); --Signal de commande de l'ALU
  Imm : out std_logic_vector (7 downto 0); --Immédiat
  Offset : out std_logic_vector (23 downto 0) --Offset du PC
  );
end entity;

architecture comportemental of Instruction_decoder is

type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, ER);
Signal instr_courante : enum_instruction;
Signal temp_instruction : std_logic_vector (11 downto 0);
Signal temp_pf : std_logic_vector (7 downto 0);
Signal Rn_int, Rd_int, Rm_int : std_logic_vector (3 downto 0);
Signal Imm_int : std_logic_vector (7 downto 0);
Signal Offset_int : std_logic_vector (23 downto 0);

begin
  
  
  process(Instruction) --Deduit des 32 bits d'instruction le type d'instruction
    begin
      if (instruction (31 downto 20) = x"E3A") then instr_courante <= MOV;
      elsif (instruction (31 downto 20) = x"E28") then instr_courante <= ADDi;
      elsif (instruction (31 downto 20) = x"E08") then instr_courante <= ADDr;
      elsif (instruction (31 downto 20) = x"E35") then instr_courante <= CMP;
      elsif (instruction (31 downto 20) = x"E61") then instr_courante <= LDR;
      elsif (instruction (31 downto 20) = x"E60") then instr_courante <= STR;
      elsif (instruction (31 downto 24) = x"EA") then instr_courante <= BAL;
      elsif (instruction (31 downto 24) = x"BA") then instr_courante <= BLT;
      end if;
      Rn  <= instruction (19 downto 16); --Récupère la valeur des registres d'adresse du banc de registres, de l'immédiat et de l'offset
      Rd <= instruction (15 downto 12); 
      Rm <= instruction (3 downto 0);
      Imm <= instruction (7 downto 0);
      Offset <= instruction (23 downto 0);
  end process;
  
  
  process(instr_courante, instruction)
  begin
    case instr_courante is
      when MOV => --Ecrit dans Rd (RegWr = 1) la valeur de l'immédiat (ALUscr = 1, ALUctr = 01 => Y = B = Imm)
        --Rn <= Rn_int; Rm <= Rm_int; Rd <= Rd_int; Imm <= Imm_int;
        nPCSel <= '0'; RegWr <= '1'; ALUsrc <= '1'; ALUctr <= "01"; PSREn <= '1'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        
      when ADDi => --Ecrit dans Rd Ra +  Imm (ALUscr = 1 => Imm, ALUctr = 00 => Y = A + B = Rn + Imm)
        nPCSel <= '0'; RegWr <= '1'; ALUsrc <= '1'; ALUctr <= "00"; PSREn <= '1'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        
      when ADDr => --Ecrit dans Rd Ra +  Rb (ALUscr = 0 => Rm, ALUctr = 00 => Y = A + B = Rn + Rm)
        nPCSel <= '0'; RegWr <= '1'; ALUsrc <= '0'; ALUctr <= "00"; PSREn <= '1'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        
      when CMP => --Fait la soustraction Rn-Imm et actualise le flag
        nPCSel <= '0'; RegWr <= '0'; ALUsrc <= '1'; ALUctr <= "10"; PSREn <= '1'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        
      when LDR => --Ecrit dans Rd la valeur Rn de la mémoire (ALUctr = 11 => Y = A = Adresse, WrSrc = 1 pour récupérer la valeur du registre mémoire)
        nPCSel <= '0'; RegWr <= '1'; ALUsrc <= '1'; ALUctr <= "11"; PSREn <= '0'; MemWr <= '0'; WrSrc <= '1'; RegSel <= '0';

      when STR => --Ecrit dans le registre Rn de la mémoire la valeur Rd, mise dans Rb (ALUctr = 11 => Y = A = Adresse, MemWr = 1 autorise l'écriture du registre Rn de la memoire)
        nPCSel <= '0'; RegWr <= '0'; ALUsrc <= '1'; ALUctr <= "00"; PSREn <= '0'; MemWr <= '1'; WrSrc <= '0'; RegSel <= '1';

      when BAL => --Change la valeur de l'offset
        nPCSel <= '1'; RegWr <= '0'; ALUsrc <= '0'; ALUctr <= "00"; PSREn <= '0'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        
      when BLT => --Change la valeur de l'offset si flag à 1
        RegWr <= '0'; ALUsrc <= '0'; ALUctr <= "00"; PSREn <= '0'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
        if(PSRout = x"FFFFFFFF") then
          nPCSel <= '1';
        else
          nPCSel <= '0';
        end if;
        
      when others =>
		nPCSel <= '0'; RegWr <= '0'; ALUsrc <= '0'; ALUctr <= "00"; PSREn <= '0'; MemWr <= '0'; WrSrc <= '0'; RegSel <= '0';
    end case;
  end process;
end architecture;
