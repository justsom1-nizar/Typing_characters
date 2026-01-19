----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/29/2025
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Simplified testbench for Game of Life
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
use work.game_of_life_pkg.all;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is
    component top
        Port (
            clk                  : in  STD_LOGIC;
            reset_button         : in  STD_LOGIC;
            hsync                : out STD_LOGIC;
            vsync                : out STD_LOGIC;
            red                  : out STD_LOGIC_VECTOR(3 downto 0);
            green                : out STD_LOGIC_VECTOR(3 downto 0);
            blue                 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal clk                  : STD_LOGIC := '0';
    signal reset_button         : STD_LOGIC := '0';

    signal hsync                : STD_LOGIC;
    signal vsync                : STD_LOGIC;
    signal red                  : STD_LOGIC_VECTOR(3 downto 0);
    signal green                : STD_LOGIC_VECTOR(3 downto 0);
    signal blue                 : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin
    uut: top 
        Port map (
            clk                  => clk,
            reset_button         => reset_button,
            hsync                => hsync,
            vsync                => vsync,
            red                  => red,
            green                => green,
            blue                 => blue
        );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin		
        reset_button <= '0';
        
        reset_button <= '1';
        wait for 50 ns;
        reset_button <= '0';
        wait for 10 ms;
        
        wait for 20 ms;
    end process;
end Behavioral;