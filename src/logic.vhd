library ieee;
use ieee.std_logic_1164.all;

entity logic is
    port (
        pixel_row : in std_logic_vector(7 downto 0);
        x_pos     : in integer range 0 to 7;
        is_display_region : in STD_LOGIC;

        red       : out std_logic_vector(3 downto 0);
        green     : out std_logic_vector(3 downto 0);
        blue      : out std_logic_vector(3 downto 0)
    );
end entity logic;

architecture rtl of logic is
begin
    process(pixel_row, x_pos)
    begin
        if is_display_region = '1' and pixel_row(x_pos) = '1' then
            red   <= (others => '1');
            green <= (others => '1');
            blue  <= (others => '1');
        else
            red   <= (others => '0');
            green <= (others => '0');
            blue  <= (others => '0');
        end if;
    end process;
end architecture rtl;