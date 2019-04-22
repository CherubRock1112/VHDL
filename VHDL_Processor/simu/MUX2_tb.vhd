Library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;
  
  entity MUX2_TB is
  end entity;
  
  architecture TB of MUX2_tb is
    
    Signal N_tb : integer := 20;
    Signal A_tb, B_tb, S_tb : std_logic_vector (N_tb-1 downto 0);
    Signal COM_tb : std_logic;
    
    begin
      test : entity work.MUX2
      generic map (N => N_tb)
      port map (A => A_tb, B => B_tb, COM => COM_tb, S => S_tb);
        STIMULUS : process
        begin
          COM_tb <= '0';
          A_tb <= (others => '1');
          B_tb <= (others => '0');
          wait for 5 ns;
          
          COM_tb <= '1';
          A_tb <= (others => '1');
          B_tb <= (others => '0');
          wait for 5 ns;
        end process;
      end architecture;
          
