-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                     Test_bench for : MUX_4v1_1bit                            *
-- *                                                                              *
-- *                Associated simulation script : simu_MUX.do                    *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MUX_4v1_1bit_tb is
end MUX_4v1_1bit_tb;


architecture test_bench of MUX_4v1_1bit_tb is
  
  	--Inputs
  	signal Tick_125ms : std_logic := '1';                                         	--Sixteenth note
  	signal Tick_250ms : std_logic := '0';                                         	--Eighth note
  	signal Tick_500ms : std_logic := '0';                                         	--Quarter note
  	signal Tick_1000ms : std_logic := '0';                                        	--Half note
  	signal clock : std_logic;                                               -- Clock
 	signal Duration : std_logic_vector(1 downto 0) := (others => '0');     		--Selector
  
  	--Outputs
  	signal Tick_Next_Note : std_logic;                                            	--Main output signal
  	signal CLEAR : std_logic;                                                     	--Clear the Frequency Divider
  
  	begin
    
    	test : entity work.MUX_4v1_1bit(behave)
    	port map (Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms, clock, Duration, Tick_Next_Note, CLEAR);
      
      
    	STIMULUS : process

	begin --Clock set-up in the simulation script at 111Mhz (9ns period)
	  --In the simulation, the accurate value of Tick_Next_Note and CLEAR takes 2 raising edges to appear
    -- One for the spreading of the value on Tick_Note, and one for Tick_Next_Note and CLEAR 
    --Tick_Note <= Tick_125ms = '1' and Tock_Next_Note = '1' and clear = '1'
  		wait for 25 ns;

    Duration <= "01"; --Tick_Note <= Tick_250ms = '0' and Tock_Next_Note = '0' and clear = '0'
		Tick_125ms <= '1'; Tick_250ms <= '0'; Tick_500ms <= '1'; Tick_1000ms <= '1';
  		wait for 25 ns;
  		
  		Duration <= "10"; --Same principle, shows that all the cases on Duration work
		Tick_125ms <= '0'; Tick_250ms <= '0'; Tick_500ms <= '1'; Tick_1000ms <= '0';
  		wait for 25 ns;

    Duration <= "11";
		Tick_125ms <= '1'; Tick_250ms <= '1'; Tick_500ms <= '1'; Tick_1000ms <= '0';
  		wait for 25 ns;
  		
    end process;
end test_bench;