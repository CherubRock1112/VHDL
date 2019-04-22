
-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                   Test_bench for : FrequencyDivider                          *
-- *                                                                              *
-- *                Associated simulation script : simu_FD.do                     *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_FrequencyDivider is
end tb_FrequencyDivider;


architecture test_bench of tb_FrequencyDivider is
      Signal Clk  : std_logic;
      Signal Reset : std_logic := '0';
	    Signal Clear : std_logic := '0'; 
	    Signal Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms : std_logic;
 
  
  	begin
    
    	test : entity work.FDIV port map (Clk, Reset, Clear, Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms);
      
      
    	STIMULUS : process --Clock set in the script simulation at 60MHz (16.7ns period), like the Tornado Card.
	     begin 
	       wait for 135 ms; --To show the intern count that leads to the 1kHz, that leads to the 125ms tick. also, when the tick_125ms gets activated, it doesn't reset the other counters
	       Reset <= '1';
	       wait for 5 ms; -- To show the Reset Signal working
	       Reset <= '0';
	       wait for 5 ms; -- To show the Clear signal working
	       Clear <= '1';
	       wait for 5 ms;
	       Clear <= '0';
  		
    end process;
end test_bench;
