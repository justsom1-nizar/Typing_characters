----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2025 02:17:04 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.typing_characters_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
 Port (
    clk   : in  STD_LOGIC;          -- System clock
    reset_button : in  STD_LOGIC;          -- Reset signal
    next_state_button : in  STD_LOGIC;          -- Button to trigger next state
    change_mode_button : in  STD_LOGIC;          -- Button to change mode
    move_cursor_left : in  STD_LOGIC;          -- Button to move cursor left
    move_cursor_down : in  STD_LOGIC;          -- Button to move cursor down
    hsync : out STD_LOGIC;          -- Horizontal sync signal for VGA
    vsync : out STD_LOGIC;          -- Vertical sync signal for VGA
    red   : out STD_LOGIC_VECTOR(3 downto 0); -- Red
    green : out STD_LOGIC_VECTOR(3 downto 0); -- Green
    blue  : out STD_LOGIC_VECTOR(3 downto 0)  -- Blue
  );
end top;

architecture Behavioral of top is
    signal divided_clk : STD_LOGIC; -- Divided clock signal for VGA timing

begin



    clock_divider_inst: entity work.clock_divider
    generic map (
        DIV_FACTOR => DIV_FACTOR_CLOCK  -- Use the defined constant for clock division
    )
    port map(
        clk_in => clk,
        reset => reset_button,
        clk_out => divided_clk
    );
    -- Instantiate the VGA controller
    vga_controller_inst : entity work.VGA_controller
        Port map (
            divided_clk => divided_clk,
            rst => reset_button,
            game_mode => game_mode,
            cursor_x => cursor_x, 
            cursor_y => cursor_y, 
            display_finished => display_finished,
            hsync => hsync,
            vsync => vsync,
            red => red,
            green => green,
            blue => blue
        );
end Behavioral;
