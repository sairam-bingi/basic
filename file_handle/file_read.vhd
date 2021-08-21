-- # ##############################################
-- #                                              #
-- # Designer: Sairam Bingi                       #
-- # Topic: File handling in RTL                  #
-- # Language: VHDL                               #
-- # Contents:                                    #
-- #    1. Simple file reading                    #
-- #                                              #
-- # Note: Suggestion are welcomed.               #
-- # Email: sairambingi16@gmail.com               #
-- #                                              #
-- # ##############################################

-- File handling is very common in verification for
-- faster testing, replicating design. This RTL
-- design is generic based file reading requiring,
-- file name to read    , format of data in the file,
-- data width.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_textio.all;
USE std.textio.all;

entity file_read is 
generic (
    FILE_NAME         : string := "data_out";
    FORMAT            : string := "hex";
    DATA_WIDTH        : positive := 30
);
port(
    clk               : in  std_logic;
    enable            : in  std_logic;
    data_out          : out std_logic_vector(DATA_WIDTH-1 downto 0);
    valid_out         : out std_logic
);
end file_read;

architecture rtl of file_read is 

begin 

file_rd_pr : process(clk) is
    
    file outfile1 : text open read_mode is FILE_NAME;
    variable outline1 : line;
    variable data : std_logic_vector(DATA_WIDTH-1 downto 0);
    variable data_int : integer;
    
begin
    if rising_edge(clk) then 
        if enable = '1' then
            if not endfile(outfile1) then
                readline(outfile1, outline1);
                if FORMAT = "decimal" then
                    read(outline1, data_int);
                    data_out <= std_logic_vector(to_unsigned(data_int, DATA_WIDTH));
                elsif FORMAT = "bin" then
                    read(outline1, data);
                    data_out <= data;
                else
                    hread(outline1, data);
                    data_out <= data;
                end if;
                valid_out <= '1';
            else
                data      := (others => '0');
                data_int  := 0;
                data_out  <= (others => '0');
                valid_out <= '0';
            end if;
        else
            data      := (others => '0');
            data_int  := 0;
            data_out  <= (others => '0');
            valid_out <= '0';
        end if;
    end if;
end process file_rd_pr;


end rtl;