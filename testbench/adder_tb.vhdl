library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity adder_tb is
end entity;

architecture sim of adder_tb is
    constant BIT_WIDTH : integer                      := 7;
    signal a           : unsigned(BIT_WIDTH downto 0) := to_unsigned(20, BIT_WIDTH + 1);
    signal b           : unsigned(BIT_WIDTH downto 0) := to_unsigned(30, BIT_WIDTH + 1);
    signal value       : unsigned(BIT_WIDTH downto 0) := to_unsigned(0, BIT_WIDTH + 1);
    signal carry       : std_logic                    := '0';
begin
    adder_inst : entity work.adder
        generic map(
            BIT_WIDTH => BIT_WIDTH
        )
        port map(
            i_A     => a,
            i_B     => b,
            o_Value => value,
            o_Carry => carry
        );

    process
    begin
        for x in 0 to 128 loop
            for y in 0 to 128 loop
                a <= to_unsigned(x, BIT_WIDTH + 1);
                b <= to_unsigned(y, BIT_WIDTH + 1);
                wait for 10 ns;
                assert value = a + b
                    report "Incorrect value (" & integer'image(to_integer(a)) & ", " & integer'image(to_integer(b)) & ", " & integer'image(to_integer(value)) & ")";
            end loop;
        end loop;
        wait;
    end process;
end architecture;