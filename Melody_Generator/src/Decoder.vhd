-- ********************************************************************************
-- *                              MusicGen                                        *
-- *                         Component : Decoder                                  *
-- *                                                                              *
-- * Ins : Note on 4bits and it's octave on 2bits                                 *
-- * Outs : Value of the count necessary to have half the period necessary to     *
-- *        create the note, on 18bits                                            *
-- * Use : Gives the value that the counter in the Wave_Generator needs to attain *
-- *       to toggle its Out signal, creating a square signal at the correct      *
-- *       frequency depending on the note and its octave.                        *
-- * comments : - The values are based on the Pythagorean frequencies, times 2 to *
-- *              get the octaves.                                                *
-- ********************************************************************************


LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Decoder is port(
	Note_Height : in std_logic_vector(3 downto 0);
	Octave : in std_logic_vector(1 downto 0);
	Val : out std_logic_vector(17 downto 0));
end Decoder;

Architecture Comportemental of Decoder is

	
Begin
	Val_Calcul : PROCESS (Note_Height, Octave) --"Val" is re-evaluated when the note has changed
	Begin
		CASE Note_Height is --Simple, long mix of a case..when and ifs to enumarate all the possible cases
			When "0000" => --When the note is an A
				if (Octave = "00") then --if the A is at the first octave
					Val <= "010000101001010110"; --68182, or 1.135ms for a Tornado card running at 60Mhz. This is the half-period of a 440Hz A note.
				elsif (Octave = "01") then
					Val <= "001000010100101011"; --
				elsif (Octave = "10") then
					Val <= "000100001010010101";
				else
					Val <= "000010000101001010";
				end if;
			when "0001" =>
				if (Octave = "00") then
					Val <= "001111101101111001";
				elsif (Octave = "01") then
					Val <= "000111110110111100";
				elsif (Octave = "10") then
					Val <= "000011111011011110";
				else
					Val <= "000001111101101111";
				end if;
			when "0010" =>
				if (Octave = "00") then
					Val <= "001110110100111000";
				elsif (Octave = "01") then
					Val <= "000111011010011100";
				elsif (Octave = "10") then
					Val <= "000011101101001110";
				else
					Val <= "000001110110100111";
				end if;
			when "0011" =>	
				if (Octave = "00") then
					Val <= "011011111101000111";
				elsif (Octave = "01") then
					Val <= "001101111110100011";
				elsif (Octave = "10") then
					Val <= "000110111111010001";
				else
					Val <= "000011011111101000";
				end if; 
			when "0100" =>
				if (Octave = "00") then
					Val <= "011010011100001111";
				elsif (Octave = "01") then
					Val <= "001101001110000111";
				elsif (Octave = "10") then
					Val <= "000110100111000011";
				else
					Val <= "000011010011100001";
				end if;
			when "0101" =>
				if (Octave = "00") then
					Val <= "011000111010011001";
				elsif (Octave = "01") then
					Val <= "001100011101001100";
				elsif (Octave = "10") then
					Val <= "000110001110100110";
				else
					Val <= "000011000111010011";
				end if;
			when "0110" =>
				if (Octave = "00") then
					Val <= "010111100011001111";
				elsif (Octave = "01") then
					Val <= "001011110001100111";
				elsif (Octave = "10") then
					Val <= "000101111000110011";
				else
					Val <= "000010111100011001";
				end if; 
			when "0111" =>
				if (Octave = "00") then
					Val <= "010110001100011101";
				elsif (Octave = "01") then
					Val <= "001011000110001110";
				elsif (Octave = "10") then
					Val <= "000101100011000111";
				else
					Val <= "000010110001100011";
				end if; 
			when "1000" =>
				if (Octave = "00") then
					Val <= "010100111111001000";
				elsif (Octave = "01") then
					Val <= "001010011111100100";
				elsif (Octave = "10") then
					Val <= "000101001111110010";
				else
					Val <= "000010100111111001";
				end if;
			when "1001" =>
				if (Octave = "00") then
					Val <= "010011110010111001";
				elsif (Octave = "01") then
					Val <= "001001111001011100";
				elsif (Octave = "10") then
					Val <= "000100111100101110";
				else
					Val <= "000010011110010111";
				end if; 
			when "1010" =>
				if (Octave = "00") then
					Val <= "010010101011110011";
				elsif (Octave = "01") then
					Val <= "001001010101111001";
				elsif (Octave = "10") then
					Val <= "000100101010111100";
				else
					Val <= "000010010101011110";
				end if;
			when "1011" =>
				if (Octave = "00") then
					Val <= "010001101001100010";
				elsif (Octave = "01") then
					Val <= "001000110100110001";
				elsif (Octave = "10") then
					Val <= "000100011010011000";
				else
					Val <= "000010001101001100";
				end if;
			when others =>
				Val <= "111111111111111111";
					
		end CASE;
	end PROCESS;
end Comportemental;
	
				

			

