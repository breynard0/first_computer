library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity a_tb is
end entity;

architecture rtl of a_tb is
    signal x : unsigned(7 downto 0) := to_unsigned(0, 8);
begin

    process
    begin
        report integer'image(to_integer(x));
        x <= x + 1;
        wait for 10 ms;
    end process;

end architecture;