Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  
  entity ALU_TB is
  end entity;
  
  architecture TB of ALU_tb is
    
    Signal OP_tb : std_logic_vector (1 downto 0);
    Signal A_tb, B_tb, S_tb : std_logic_vector (31 downto 0);
    Signal N_tb : std_logic;
    
    begin
      test : entity work.ALU
      port map (OP => OP_tb, A => A_tb, B => B_tb, S => S_tb, N => N_tb);
        STIMULUS : process
        begin
          OP_tb <= "00";
          A_tb <= "00010000000100000000000000000000";
          B_tb <= "00001000000000000100000000000000";
          wait for 5 ns;
          
          OP_tb <= "01";
          A_tb <= "00010000000100000000000000000000";
          B_tb <= "00001000000000000100000000000000";
          wait for 5 ns;
          
          OP_tb <= "10";
          A_tb <= "00010000000100000000000000000000";
          B_tb <= "00001000000000000100000000000000";
          wait for 5 ns;
          
          OP_tb <= "11";
          A_tb <= "00010000000100000000000000000000";
          B_tb <= "00001000000000000100000000000000";
          wait for 5 ns;
          
          OP_tb <= "10";
          A_tb <= "00000000000100000000000000000000";
          B_tb <= "01110000000000000100000000000000";
          wait for 5 ns;
        end process;
      end architecture;
          
          
          
      
    
