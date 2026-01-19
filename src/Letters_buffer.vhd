library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.typing_characters_pkg.all;
entity Letters_buffer is
    port (
        x_pixel : in STD_LOGIC_VECTOR(9 downto 0);
        y_pixel : in STD_LOGIC_VECTOR(9 downto 0);
        letter  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity Letters_buffer;

architecture rtl of Letters_buffer is
    signal letters_buffer : T_LETTER_BUFFER := (others => x"00");
    signal char_x : natural range 0 to NUMBER_OF_LETTERS_IN_ROW-1;
    signal char_y : natural range 0 to NUMBER_of_ROWS_OF_LETTERS-1;
    signal position : natural range 0 to NUMBER_of_ROWS_OF_LETTERS*NUMBER_OF_LETTERS_IN_ROW-1;
begin
    char_x <= to_integer(unsigned(x_pixel)) / LETTER_WIDTH;
    char_y <= to_integer(unsigned(y_pixel)) / LETTER_HEIGHT;

    position <= char_y * NUMBER_OF_LETTERS_IN_ROW + char_x;
    letter <= letters_buffer(position);
end architecture rtl;