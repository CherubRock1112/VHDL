-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                      Component : Frequency Divider                           *
-- *                                                                              *
-- * Ins : Clk, global signal reset, local signal clear                           *
-- * Outs : S4 Different time Ticks sending 1 after 125, 250, 500 or 1000ms       *
-- * Use : Creates a 1kHz frequency clock and uses it to count miliseconds        *
-- *       and send ticks accordingly to the MUX_4v1                              *
-- * comments :                                                                   *
-- ********************************************************************************


Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  
  
  
-- ---------------------------------------
    Entity FDIV is
-- ---------------------------------------
   Generic (  Fclock  : positive := 60E6); -- System Clock Freq in Hertz
      Port (  Clk  : In    std_logic;
              Reset : In    std_logic; --Global signal, switch on the card
				      Clear : In std_logic; --Signal sent by the MUX_4v1 to reset all counters
              Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms : out std_logic);	--Time ticks
end entity FDIV;

-- ---------------------------------------
    Architecture dataflow of FDIV is
-- ---------------------------------------

constant Divisor_ms : positive := Fclock/1000; --Number of clock ticks needed to atteign 1ms
signal Count     : integer range 0 to Divisor_ms+1; --Count the system clock ticks until 1ms is past
signal ms_past : std_logic; --Tick to signify that 1ms has past,
signal rst : std_logic;
signal Count_125ms : integer range 0 to 125; --Counts of how many ms have passed, one for each of the 4 Time-Ticks
signal Count_250ms : integer range 0 to 250;
signal Count_500ms : integer range 0 to 500;
signal Count_1000ms : integer range 0 to 1000;

-----
Begin
-----
rst <= reset or Clear; --Simplify the process, resets the counters if either the clear or the reset is on
process (Clk,rst)
begin

 
 if rst='1'  then --Resets every counters
    Count <= 0;
    Count_500ms <= 0;
    Count_125ms <= 0;
    Count_250ms <= 0;
    Count_1000ms <= 0;
 elsif clk'event and clk = '1' then --else, synchronous actions
  Count <= Count + 1; --Counts system clock ticks
  tick_125ms <= '0'; -- Resets every Time-Tick at 0
  tick_250ms <= '0';
  tick_500ms <= '0';
  tick_1000ms <= '0';

  
  
  if Count = Divisor_ms then --If the system clock count hits Divisor_ms
    Count <= 0; --Reset the counter
    ms_past <= '1'; --Signifies that one ms has passed
  end if;
  
  
  if ms_past = '1' then --If one ms has been passed
    Count_125ms <= Count_125ms + 1; --	Increments all time-tick ms counters
    Count_250ms <= Count_250ms + 1;
    Count_500ms <= Count_500ms + 1;
    Count_1000ms <= Count_1000ms + 1;
    ms_past <= '0'; --Resets the ms_past tick
  end if;
  
    
  if Count_125ms = 125 then --If a limit has been reached on a ms counter
    tick_125ms <= '1'; --Sets the according time-tick to 1
    Count_125ms <= 0; -- Resets the according counter
  end if;
  
  if Count_250ms = 250 then
    tick_250ms <= '1';
    Count_250ms <= 0;
  end if;
  
  if Count_500ms = 500 then
    tick_500ms <= '1';
    Count_500ms <= 0;
  end if;
  
  if Count_1000ms = 1000 then
    tick_1000ms <= '1';
    Count_1000ms <= 0;
  end if;
end if;
  
end process;

end architecture dataflow;
