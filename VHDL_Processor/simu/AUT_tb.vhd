library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AUT_tb is
end entity AUT_tb;

architecture STRUCT_TB of AUT_tb is

  Signal I_tb : integer := 8;
  Signal I2_tb : integer := 32;
  Signal clk_tb, We_tb, com_tb, com2_tb, WrEn_tb : std_logic;
  Signal Ra_tb, Rb_tb, Rw_tb: std_logic_vector (3 downto 0);
  Signal Op_tb  :  std_logic_vector (1 downto 0);
  Signal W_out_tb :  std_logic_vector (31 downto 0);
  Signal M_tb, RegSel_tb : std_logic;
  Signal Imm_tb :  std_logic_vector(7 downto 0);
  begin
    C0 : entity work.AUT generic map (I => I_tb, I2 => I2_tb) 
    port map (CLK => clk_tb, RegWr => We_tb, com => com_tb, com2 => com2_tb, WrEn => WrEn_tb, Ra => Ra_tb, Rb => Rb_tb, Rw => Rw_tb, Op => Op_tb, W => W_out_tb, M => M_tb, Imm => Imm_tb, RegSel => RegSel_tb);
  STIMULUS : process
  begin
    
    RegSel_tb <= '0';
	WrEn_tb <= '0';
    -- Addition de 2 registres R1
    
    Ra_tb <= "0001"; --R(1) + R(2) = R(0)
    Rb_tb <= "0010";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    com_tb <= '0'; --Pas la valeur imm
    
    Op_tb <= "00"; --addition
    
    com2_tb <='0'; --Valeur de sortie de l'UAL
    wait for 20 ns;
    
    
    -- Addition de 1 registre + Val im
    
    Ra_tb <= "0010"; --R(0) = R(2) + 72
    Rb_tb <= "0001";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    Imm_tb <= "01001000";
    
    com_tb <= '1'; --Valeur imm choisie
    
    Op_tb <= "00"; --addition
    
    com2_tb <='0'; --Valeur de sortie de l'UAL
    wait for 20 ns;
    
    
    -- Soustraction de 2 registres
    
    Ra_tb <= "0010"; --R(2) - R(1) = R(0)
    Rb_tb <= "0001";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    com_tb <= '0'; --Pas la valeur imm
    
    Op_tb <= "10"; --soustraction
    
    com2_tb <='0'; --Valeur de sortie de l'UAL
    wait for 20 ns;
    
    
    -- Soustraction de 1 registre + Val im
    
    Ra_tb <= "0011"; --R(0) = R(3) - 4
    Rb_tb <= "0001";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    Imm_tb <= "00000100";
    
    com_tb <= '1'; --Valeur imm choisie
    
    Op_tb <= "10"; --soustraction
    
    com2_tb <='0'; --Valeur de sortie de l'UAL
    
	wait for 20 ns;
    
    
    -- Copie de la valeur d'un registre dans un autre Copie de R(7) dans R(1); 
    
    Ra_tb <= "1000"; --R(0) = R(8)
    Rb_tb <= "0010";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    com_tb <= '0'; --Pas la valeur imm
    
    Op_tb <= "11"; --S=A
    
    com2_tb <='0'; --Valeur de sortie de l'UAL
    wait for 20 ns;
    
    
    --Lecture d'un mot de la memoire
    
    Ra_tb <= "0101"; --Lit DATAMEM(R5) = DATAMEM(32)
    Rb_tb <= "0010";
    Rw_tb <= "0000";
    We_tb <= '1';
    
    com_tb <= '0'; --Pas la valeur imm
    
    Op_tb <= "11"; --S=A
    
    WrEn_tb <= '0'; --Pas d'ecriture dans la memoire
    
    com2_tb <= '1'; --Selectionne la valeur issu de la memoire, lecture du mot 4
    wait for 20 ns;
    
    
    -- Ecriture d'un mot du registre dans la memoire
    
    Ra_tb <= "0101"; --Ecrit dans DATAMEM(R5) = DATAMEM(32)
    Rb_tb <= "0001";
    Rw_tb <= "0000";
    We_tb <= '0';
    
    com_tb <= '0'; --Pas la valeur imm
    
    Op_tb <= "11"; --S=A
    
    WrEn_tb <= '1'; --Autorise l'ecriture dans la memoire
    
    com2_tb <= '1'; --Selectionne la valeur issu de la memoire, lecture du mot 4
    wait for 20 ns;
    
  end process;
end architecture;