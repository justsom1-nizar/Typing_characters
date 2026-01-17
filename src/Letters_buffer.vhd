library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.typing_characters_pkg.all;
entity Letters_buffer is
    port (
        x_pixel : in unsigned(9 downto 0);
        y_pixel : in unsigned(9 downto 0);
        letter  : out T_LETTER
    );
end entity Letters_buffer;

architecture rtl of Letters_buffer is
    signal letters_buffer  T_LETTER_BUFFER := (others => SPACE);

begin
    
    letter <= letters_buffer(y_pixel / 64, x_pixel / 64);
    
end architecture rtl;