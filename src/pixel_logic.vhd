library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_logic is
    generic (
        WIDTH  : integer := 640;
        HEIGHT : integer := 480
    );
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        pixel_x     : in unsigned(9 downto 0);
        pixel_y     : in unsigned(8 downto 0);
        pixel_data  : out std_logic_vector(23 downto 0)  -- RGB 8-bit each
    );
end entity pixel_logic;

architecture rtl of pixel_logic is

begin

    process(clk, rst)
    begin
        if rst = '1' then
            pixel_data <= (others => '0');
        elsif rising_edge(clk) then
            -- TODO: Implement pixel logic here
            pixel_data <= (others => '0');
        end if;
    end process;

end architecture rtl;