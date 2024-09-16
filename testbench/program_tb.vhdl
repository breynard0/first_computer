use work.Program.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity program_tb is
end entity;

architecture sim of program_tb is
    signal value : unsigned(7 downto 0);
begin

    process
    begin
        for i in 0 to 255 loop
            value <= SAMPLE_PROGRAM(i);
            wait for 1 ns;
        end loop;
        wait;
    end process;

end architecture;