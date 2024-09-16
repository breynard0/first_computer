library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity computer_tb is
end entity;

architecture sim of computer_tb is
    constant ClockFrequency : integer   := 1000;
    constant ClockPeriod    : time      := 1000 ms / ClockFrequency;
    signal Clk              : std_logic := '1';
    signal Reset            : std_logic := '0';
    signal Output           : unsigned(work.ComputerTypes.BIT_WIDTH downto 0);
begin
    computer_inst: entity work.computer
     port map(
        clk => Clk,
        reset => Reset,
        output => Output
    );

    Clk <= not Clk after ClockPeriod / 2;

    process (Output)
    begin
        report "Computer Output: " & integer'image(to_integer(Output));
    end process;
end architecture;