-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                       Component : Adress_Counter                             *
-- *                                                                              *
-- * Ins : Tick_Next_Note indicating if the current note is over, reset and clock *
-- * Outs : Adress of the note to be played                                       *
-- * Use : effectively acts as a counter of notes, with the count being the adress*
-- * comments :                                                                   *
-- ********************************************************************************

Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity adress_counter is port (
  Tick_next_note, reset, clk : in std_logic;     --Gets Tick-Next-Out from a frequency-divider, Start, Rest and Clk are global entries
  Adress_Note : out std_logic_vector (9 downto 0)); --Indicates which note needs to be played, gives the info to the memory
end entity;

architecture behav of adress_counter is
  signal Count : std_logic_vector (9 downto 0) := "0000000000";
  begin
    process(reset, clk)
      begin
		if (Reset = '1') then  --If the Reset signal is on, reset the counter, reseting the melody
            Count <= (others => '0');
       elsif (clk'event and clk = '1') then --Synchroneous events
        
			  if ( Tick_next_note = '1') then --If the current note is over
					Count <= Count + '1'; --Increments the counter
			  end if;
			  
			  if (Count = "0001110011") then --If the count is equal 115 (number of the last note of the test melody + 1)
					Count <= (others => '0'); --Restarts the melody
				end if;
       end if;
       
    end process;
	 Adress_Note <= Count; --The note adress take the counter as value
  end architecture;