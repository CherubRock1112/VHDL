-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                         Component : Wave Generator                           *
-- *                                                                              *
-- * Ins : Tick_Counter, the binary value the counter has to reach to provoke a   *
-- *       toggle of the out signal, clock, reset and an override signal that     *
-- *       cancel the sound generation when at 1.                                 *
-- * Outs : A square cyclic signal at the right frequency.                        *
-- * Use : Creates the soundwave that is played on the Tornado card               *
-- * comments : - The values are based on the Pythagorean frequencies, times 2 to *
-- *              get the octaves.                                                *
-- ********************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity Wave_Generator is port(
	CLK : in std_logic;
	RESET : in std_logic;
	Tick_Counter : in std_logic_vector (17 downto 0);
	Override : in std_logic;
	SoundWave : out std_logic);
End Wave_Generator;

Architecture Comportemental of Wave_Generator is
	
Signal Intern_Count : std_logic_vector (17 downto 0) := "000000000000000000"; --Counter of the clock's rising edges
Signal SoundEnable : std_logic := '0'; --Intern signal enabling us to read the value of SoundWave
Begin
	
	Tick : PROCESS (CLK, RESET)
	BEGIN
		if (RESET = '1') then --Resets the intern counter
			Intern_Count <= "000000000000000000";
		elsif rising_edge(clk) then --Else, synchronous events
			if (Tick_Counter = "111111111111111111" or Override = '1') then
				SoundEnable <= '0'; --If the decoder couldn't work or if the override signal is on, stop the sound transmision
			elsif Intern_Count = Tick_Counter then
				SoundEnable <= not SoundEnable; --If the value transmitted by the decoder is reached, provoke a toggle of the out signal
				Intern_Count <= "000000000000000000";-- and resets the counter
			else
			  Intern_Count <= Intern_Count + '1'; --Else, increments the count
			end if;
		end if; 
	end PROCESS;
	SoundWave <= SoundEnable;

end Architecture;
		
			
				
