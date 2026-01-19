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

    hsync : out STD_LOGIC;          -- Horizontal sync signal for VGA
    vsync : out STD_LOGIC;          -- Vertical sync signal for VGA
    red   : out STD_LOGIC_VECTOR(3 downto 0); -- Red
    green : out STD_LOGIC_VECTOR(3 downto 0); -- Green
    blue  : out STD_LOGIC_VECTOR(3 downto 0)  -- Blue
  );
end top;

architecture Behavioral of top is
    signal divided_clk : STD_LOGIC; 
    signal is_display_region : STD_LOGIC;
    signal x_pixel :std_logic_vector (9 downto 0);
    signal y_pixel :std_logic_vector (9 downto 0);    
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
    vga_controller_inst: entity work.vga_controller
     port map(
        divided_clk => divided_clk,
        rst => reset_button,
        is_display_region => is_display_region,
        x_pixel => x_pixel,
        y_pixel => y_pixel,
        hsync => hsync,
        vsync => vsync
    );
    pixel_logic_inst: entity work.pixel_logic
     port map(
        rom_clock => clk,
        rst => reset_button,
        x_pixel => x_pixel,
        y_pixel => y_pixel,
        is_display_region => is_display_region,
        red => red,
        green => green,
        blue => blue
    );
end Behavioral;
