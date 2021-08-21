-- # ##############################################
-- #                                              #
-- # Designer: Sairam Bingi                       #
-- # Topic: File handling in RTL                  #
-- # Language: VHDL                               #
-- # Contents:                                    #
-- #    1. Simple file writing                    #
-- #                                              #
-- # Note: Suggestion are welcomed.               #
-- # Email: sairambingi16@gmail.com               #
-- #                                              #
-- # ##############################################

-- File handling is very common in verification for
-- faster testing, replicating design. This RTL
-- design is generic based file writing requiring,
-- file name to write, format of data in the file,
-- data width.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_textio.all;
USE std.textio.all;

entity file_write is 
generic (
    FILE_NAME         : string := "data_out";
    FORMAT            : string := "hex";
    DATA_WIDTH        : positive := 30
);
port(
    clk               : in std_logic;
    data_in           : in std_logic_vector(DATA_WIDTH-1 downto 0);
    valid_in          : in std_logic
);
end file_write;

architecture rtl of file_write is 

begin 

file_wr_pr : process(clk) is
    
    file outfile1 : text open write_mode is FILE_NAME;
    variable outline1 : line;
    
begin
    if rising_edge(clk) then 
        if valid_in = '1' then
            if FORMAT = "decimal" then
                write(outline1, integer'image(to_integer(unsigned(data_in))));
            elsif FORMAT = "bin" then
                write(outline1, data_in);
            else
                hwrite(outline1, data_in);
            end if;
            writeline(outfile1,outline1);
        end if;
    end if;
end process file_wr_pr;

end rtl;