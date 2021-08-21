library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;

entity incr_patt_gen is 
generic (
    DATA_WIDTH        : positive := 30
);
port(
    video_clk           :  in  std_logic;
    rst                 :  in  std_logic;
    Vsync               :  in  std_logic;
    Hsync               :  in  std_logic;
    data_en             :  in  std_logic;
    data_out            :  out std_logic_vector(DATA_WIDTH-1 downto 0);
    vysnc_out           :  out std_logic;
    hysnc_out           :  out std_logic;
    data_en_out         :  out std_logic
);
end incr_patt_gen;

architecture rtl of incr_patt_gen is 

signal data_gen             : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

begin

data_gen_pr : process(video_clk, rst) is
begin
    if rst = '1' then
        data_gen    <= (others => '0');
        vysnc_out   <= '0';
        hysnc_out   <= '0';
        data_en_out <= '0';
    elsif rising_edge(video_clk) then
        if Vsync = '0' or Hsync = '0' then
            data_gen <= (others => '0');
        elsif data_en = '1' then
            data_gen <= data_gen + '1';
        end if;
        vysnc_out   <= Vsync;
        hysnc_out   <= Hsync;
        data_en_out <= data_en;
    end if;
end process data_gen_pr;

data_out <= data_gen;

end rtl;