Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AUT is --UNITE DE TRAITEMENT
generic(
  I : integer := 8;
  I2 : integer := 32
);
port(
  clk, RegWr, com, com2, WrEn, RegSel : in std_logic; --com : ALUsrc, com2 : WrSrc
  Ra, Rb, Rw: in std_logic_vector (3 downto 0);
  Op  : in std_logic_vector (1 downto 0);
  W : inout std_logic_vector (31 downto 0);
  M : out std_logic;
  Imm : in std_logic_vector(7 downto 0)
  );
end entity;
  
architecture comportemental of AUT is 
  
Signal BusA, BusB, MUXout32, ALUout, SXTout, Dout : std_logic_vector (31 downto 0);
Signal Muxout4 : std_logic_vector (3 downto 0);
Signal N_temp : std_logic;

begin
  E_MUX2_1 : entity work.MUX2 generic map (N => 4) port map (A => Rb, B => Rw, COM => RegSel, S => Muxout4); --Choix de Rd ou Rm pour Rb
  E_REG : entity work.registre port map ( CLK => clk, W => W, RA => Ra, RB => MuxOut4, RW => Rw, We => RegWr, A => BusA, B => BusB); --banc de registres
  E_ALU : entity work.ALU port map (Op => Op, A => BusA, B => MUXout32, S => ALUout, N => M);
  E_MUX_IMM : entity work.MUX2 generic map (N => I2) port map (COM => com, A => BusB, B => SXTout , S => MUXout32); --Choix du bus B ou de l'immédiat pourl'ALU
  E_MEM : entity work.DMem port map (DataIn => BusB, CLK => clk, WrEn => WrEn, Addr => ALUout(5 downto 0), DataOut => Dout); --Mémoire
  E_SGEXT : entity work.SGNEXT generic map (N => I) port map (A => Imm, S => SXTout); --Etend le signe de l'immédiat pour atteindre 32bits
  E_MUX_MEM : entity work.MUX2 generic map (N => I2) port map(COM => com2, A => ALUout, B => Dout, S => W); --Choix du bus de sortie de l'ALU ou de la mémoire pour le bus W
end architecture;