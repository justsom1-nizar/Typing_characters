library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.typing_characters_pkg.all;
entity vga_controller is
    Port (

        divided_clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;

        is_display_region : out STD_LOGIC;
        x_pixel     : out STD_LOGIC_VECTOR(9 downto 0);
        y_pixel     : out STD_LOGIC_VECTOR(9 downto 0);
        hsync       : out STD_LOGIC;
        vsync       : out STD_LOGIC
    );
end vga_controller;

architecture Behavioral of vga_controller is

    signal sig_h_count : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal sig_v_count : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal h_sync_pulse : STD_LOGIC := '0';
    signal v_sync_pulse : STD_LOGIC := '0';
    signal h_tc : STD_LOGIC := '0';
    signal is_display_region_h : STD_LOGIC := '0';
    signal is_display_region_v : STD_LOGIC := '0';

    begin
    -- Instantiate the horizontal counter
    x_pixel <= sig_h_count - H_DISPLAY_START - to_unsigned(x_margin,10);
    y_pixel <= sig_v_count - V_DISPLAY_START - to_unsigned(y_margin,10);
    horizental_counter_inst : entity work.horizental_counter
        Port map (
            clk       => divided_clk,
            reset     => rst,
            count     => sig_h_count,
            tc        => h_tc
        );
    -- Instantiate the vertical counter
    vertical_counter_inst : entity work.vertical_counter
        Port map (
            clk         => divided_clk,
            reset       => rst,
            TC_enable   => h_tc,
            count       => sig_v_count
        );
    -- Generate horizontal sync pulse
    interval_comparator_inst_h : entity work.interval_comparator
        Port map (
            lower_bound_first  => H_SYNC_START, 
            upper_bound_first  => H_SYNC_END,
            lower_bound_second => H_SYNC_START,
            upper_bound_second => H_SYNC_END,
            input_value        => sig_h_count,
            is_within          => h_sync_pulse
        );
    hsync <= h_sync_pulse;    
    -- Generate vertical sync pulse
    interval_comparator_inst_v : entity work.interval_comparator
        Port map (
            lower_bound_first  => V_SYNC_START, 
            upper_bound_first  => V_SYNC_END,
            lower_bound_second => V_SYNC_START,
            upper_bound_second => V_SYNC_END,
            input_value        => sig_v_count,
            is_within          => v_sync_pulse
        );
    vsync <= v_sync_pulse;
    -- Is it at horizental display area?
    interval_comparator_inst_display_h: entity work.interval_comparator
     port map(
        lower_bound_first  => H_DISPLAY_START,
        upper_bound_first  => H_DISPLAY_END,
        lower_bound_second => H_DISPLAY_START,
        upper_bound_second => H_DISPLAY_END,
        input_value        => sig_h_count,
        is_within          => is_display_region_h
    );
    -- IS it at vertical display area?
    interval_comparator_inst_display_v: entity work.interval_comparator
        port map(
        lower_bound_first  => V_DISPLAY_START,
        upper_bound_first  => V_DISPLAY_END,
        lower_bound_second => V_DISPLAY_START,
        upper_bound_second => V_DISPLAY_END,
        input_value        => sig_v_count,
        is_within          => is_display_region_v
        );
    is_display_region <= is_display_region_h and is_display_region_v;

end architecture Behavioral;