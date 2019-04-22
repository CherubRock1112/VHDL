
-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                     Test_bench for : Wave_Generator                          *
-- *                                                                              *
-- *                Associated simulation script : simu_WG.do                     *
-- ********************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

Entity tb_WaveGen is
end Entity;

Architecture TestWaveGen of tb_WaveGen is
  Signal TickCounterIn : std_logic_vector (17 downto 0);
  Signal SWOut : std_logic;
  Signal Override : std_logic := '0';
  Signal CLK : std_logic;
  Signal RESET : std_logic := '0';
  Begin --clock definition in the simulation script
    --CLK <= not CLK after 8 ns;
    WaveGen1 : entity work.Wave_Generator port map (CLK, RESET, TickCounterIn, Override, SWOut);
    STIMULUS : process
    begin
      TickCounterIn <= "000111110110111100"; --A#, 2nd octave, the first note of the partition
      wait for 7 ms; --The period of SWOut is around 1 070 us, or 1/932, 932Hz being the note frequency
      TickCounterIn <= "000111011010011100"; --B, 2nd octave.
      wait for 7 ms; --Around 1 010 us, or 1/988
      RESET <= '1'; --Resets the intern counter
      wait for 1 ms;
      RESET <= '0'; -- The counter restarts and stops the sound while on
      wait for 2 ms;
      Override <= '1'; --Stops the soundwave without reseting the counter
      wait for 3 ms;
  end process;
    
  end Architecture;