-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                       Test_bench for : Decoder                               *
-- *                                                                              *
-- *              Associated simulation script : simu_Decoder.do                  *
-- ********************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

Entity tb_Decoder is
end Entity;

Architecture Test of tb_Decoder is
  Signal Octave_In : std_logic_vector(1 downto 0) := "00";
  Signal Note_In : std_logic_vector(3 downto 0) := "0000";
  Signal Val_Out : std_logic_vector(17 downto 0);
  
  Begin
    Decoder1 : entity work.Decoder port map(Note_In, Octave_In, Val_Out);
    -- Tests all the values carried by ValOut, through incrementation.
    Note_In <= Note_In + "1" after 5 ns;
    Octave_In <= Octave_In + "1" after 70 ns; --70 ns so we can see the special value when the note is unknown
end Architecture;
    