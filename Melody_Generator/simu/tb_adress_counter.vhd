
-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                     Test_bench for : Adress_Counter                          *
-- *                                                                              *
-- *                Associated simulation script : simu_AC.do                     *
-- ********************************************************************************

Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_adress_counter is
end entity;

architecture Test of tb_adress_counter is
 Signal Tick_next_out_I, clk_I: std_logic;
 Signal reset_I : std_logic := '0';
 Signal Adress_Note_I : std_logic_vector (9 downto 0);
 begin
   INST : entity work.adress_counter(behav) port map (Tick_next_out_I, reset_I, clk_I, Adress_Note_I);
   process
     begin
     for i in 1 to 3 loop --Simple test of the counter incrementation
      Tick_Next_Out_I <= '1';
      wait for 1 ns;
      Tick_Next_Out_I <= '0';
      wait for 1 ns;
     end loop;
     reset_I <= '1'; --When the reset signal is on, the count goes back to 0
     wait for 5 ns;
     reset_I <= '0';
     --Longer time at 1 to show that the counter restart when the end of the partition has been reached
     Tick_Next_Out_I <= '1';
     wait for 100 ns;
      
   end process; 
  end architecture;

