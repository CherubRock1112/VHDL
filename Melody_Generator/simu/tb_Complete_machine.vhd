
-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                   Test_bench for : Complete_Machine                          *
-- *                                                                              *
-- *                Associated simulation script : simu_CM.do                     *
-- ********************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

Entity tb_Complete_machine is
end Entity;

Architecture TestCM of tb_Complete_machine is
  Signal Soundwave : std_logic;
  Signal Override : std_logic := '0';
  Signal CLK : std_logic;
  Signal RESET : std_logic := '0';
  Begin --clock definition in the simulation script
    CM : entity work.Complete_Machine port map (CLK, RESET, Override, Soundwave);
    STIMULUS : process
    begin
      --First note, A# 2nd octave. The period of Soundwave is around 1 070 us, or 1/932, 932Hz being the note frequency
      --After 500 ms, the secound note will be played, a B 2nd octave, with a period on soundwave of around 1 010 us, or 1/988
      wait for 550 ms;
      Override <= '1';
      wait for 20 ms; --Shows the override works
      Override <= '0'; --Stops the sound while at '1' without reseting the partition
      wait for 10 ms; 
      Reset <= '1'; --Shows the reset works
      wait for 10 ms; --Reset the partition, the counters and stops the slound while on
      Reset <= '0';
      wait for 10 ms;
  end process;
    
  end Architecture;
