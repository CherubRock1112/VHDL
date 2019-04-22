-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                     Test_bench for : Memory, rom2                            *
-- *                                                                              *
-- *              Associated simulation script : simu_Memory.do                   *
-- ********************************************************************************

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity tb_memory is
end entity;

architecture Test of tb_memory is
  Signal Adress_Note_I : std_logic_vector (9 downto 0) := "0000000000";
  Signal Note_I: std_logic_vector (3 downto 0);
  Signal Clk_I :std_logic;
  Signal Octave_I, Duration_I : std_logic_vector (1 downto 0);
  begin
    
    INST : entity work.memory(behav) port map (Adress_Note_I, Clk_I, Note_I, Octave_I, Duration_I);
    
    process
      begin --Serves as a test-bench for both rom2 and memory. Tests the first 10 values of the roms, and thus the working of the memory component
        for i in 1 to 10 loop
          wait for 10 ns;
          Adress_Note_I <= Adress_Note_I + 1; --"1"?
        end loop;
      end process;
    end architecture;
        
         
