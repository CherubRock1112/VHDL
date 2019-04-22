-- *******************************************************************************
-- *                              MusicGen                                       *
-- *                       Component : MUX_4v1                                   *
-- *                                                                             *
-- * Ins : 4 Time-Ticks from the FreqDiv, clock, 2-bits Duration from the Memory *
-- * Outs : Tick_Next_Note to the Adress_Counter, Clear to the FreqDiv           *
-- * Use : Assign the correct Time-Tick signal to the Adress_Counter,            *
-- *       depending on the duration of the note.                                *
-- * comments : - When the Time_Tick assigned to Tick_Next_Note hits one,        *
-- *           triggers the switch to the next note and clears the counters of   *
-- *           the frequency divider                                             *
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity MUX_4v1_1bit is port(

  Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms, clk : in std_logic;     --Inputs
  Duration : in std_logic_vector(1 downto 0);                         --Selector
  Tick_Next_Note : out std_logic;                                     --Outputs, going to the Adress_Counter
  CLEAR : out std_logic);                                             --Signal used to clear the Frequency Divider
end MUX_4v1_1bit;


architecture behave of MUX_4v1_1bit is

signal Tick_Note : std_logic;

begin 
  process(clk) is 
  begin
    if (clk'event and clk = '1') then 
      case Duration is --Assign the correct Time-Tick to Tick_Note
        when  "00" => Tick_Note <= Tick_125ms;                 --Sixteenth note
        when  "01" => Tick_Note <= Tick_250ms;                 --Eighth note
        when  "10" => Tick_Note <= Tick_500ms;                 --Quarter note
        when  "11" => Tick_Note <= Tick_1000ms;                --Half note
        when others => Tick_Note <= '0'; 
      end case;
      
      if (Tick_Note = '1') then --If the Tick assigned hits one, sends a one to the AC and clears the FD
        Tick_Next_Note <= '1';
        CLEAR <= '1';
      elsif (Tick_Note = '0') then  -- else, sends 0
        Tick_Next_Note <= '0';
        CLEAR <= '0';
      end if;
    end if;
  end process;
end behave;