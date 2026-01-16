library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.typing_characters_pkg.all;

entity pixel_logic is

    port (
        clk         : in std_logic;
        rst         : in std_logic;
        x_pixel     : in unsigned(9 downto 0);
        y_pixel     : in unsigned(9 downto 0);
        is_display_region : in STD_LOGIC;

        red         : out STD_LOGIC_VECTOR(3 downto 0);
        green       : out STD_LOGIC_VECTOR(3 downto 0);
        blue        : out STD_LOGIC_VECTOR(3 downto 0)
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