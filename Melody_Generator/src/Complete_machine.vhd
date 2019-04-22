-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                      Component : Complete_Machine                            *
-- *                                                                              *
-- * Ins : Clock, Reset and Override Signals                                      *
-- * Outs : SoundWave, clock at the correct frequency giving us the correct note  *
-- * Use : Instantiate every component of the system as one global component      *
-- * comments :                                                                   *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity Complete_Machine is port(
  CLK : in std_logic;
  RESET : in std_logic;
  Override : in std_logic;
  SoundWave : out std_logic);
end Complete_Machine;

Architecture Structural of Complete_Machine is

Signal Adress_Note : std_logic_vector (9 downto 0); --Every signals used in the different components
Signal Octave : std_logic_vector (1 downto 0);
Signal Note_Height : std_logic_vector (3 downto 0);
Signal Duration : std_logic_vector (1 downto 0);
Signal Tick_1000ms : std_logic;
Signal Tick_500ms : std_logic;
Signal Tick_250ms : std_logic;
Signal Tick_125ms : std_logic;
Signal Clear_Tick : std_logic;
Signal Tick_Next_Note : std_logic;
Signal Tick_Counter : std_logic_vector (17 downto 0);


Begin
  C0 : ENTITY WORK.Adress_Counter port map (Tick_Next_Note, RESET, CLK, Adress_Note);
  C1 : ENTITY WORK.Memory port map (Adress_Note, CLK, Note_Height, Octave, Duration);
  C2 : ENTITY WORK.Decoder port map (Note_Height, Octave, Tick_Counter);
  C3 : ENTITY WORK.Wave_Generator port map (CLK, RESET, Tick_Counter, Override, SoundWave);
  C4 : ENTITY WORK.FDIV port map (CLK, RESET, Clear_Tick, Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms );
  C5 : ENTITY WORK.Mux_4v1_1bit port map (Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms, CLK, Duration, Tick_Next_Note, Clear_Tick);
  
end Structural;
