library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.typing_characters_pkg.all;

entity pixel_logic is
 
    port (
        rom_clock  : in std_logic;
        rst         : in std_logic;
        x_pixel     : in STD_LOGIC_VECTOR(9 downto 0);
        y_pixel     : in STD_LOGIC_VECTOR(9 downto 0);
        is_display_region : in STD_LOGIC;

        red         : out STD_LOGIC_VECTOR(3 downto 0);
        green       : out STD_LOGIC_VECTOR(3 downto 0);
        blue        : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity pixel_logic;

architecture rtl of pixel_logic is
signal letter_ASCII : STD_LOGIC_VECTOR(7 downto 0);
signal x_mod : INTEGER range 0 to LETTER_WIDTH-1;
signal y_mod : INTEGER range 0 to LETTER_HEIGHT-1;
signal pixel_row : STD_LOGIC_VECTOR(7 downto 0);
begin
    
    Letters_buffer_inst: entity work.Letters_buffer
     port map(
        x_pixel => x_pixel,
        y_pixel => y_pixel,
        letter => letter_ASCII
    );

    y_mod<=to_integer(unsigned(y_pixel)) mod LETTER_HEIGHT;
    
    font_rom_inst: entity work.font_rom
     port map(
        clk => rom_clock,
        char_code => letter_ASCII,
        row => y_mod,
        pixel_row => pixel_row
    );

    x_mod<=to_integer(unsigned(x_pixel)) mod LETTER_WIDTH;

    logic_inst: entity work.logic
     port map(
        pixel_row => pixel_row,
        x_pos => x_mod,
        is_display_region => is_display_region,
        red => red,
        green => green,
        blue => blue
    ); 

end architecture rtl;