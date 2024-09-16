library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.DecoderTypes.all;

entity comparator_tb is
end entity;

architecture sim of comparator_tb is
    constant BIT_WIDTH : integer                      := 7;
    signal A           : unsigned(BIT_WIDTH downto 0) := to_unsigned(4, BIT_WIDTH + 1);
    signal B           : unsigned(BIT_WIDTH downto 0) := to_unsigned(4, BIT_WIDTH + 1);
    signal Op          : OPCODE                       := dec_OpGTE;
    signal Value       : std_logic;
begin
    -- Device Under Test
    comparator_inst : entity work.comparator
        generic map(
            BIT_WIDTH => BIT_WIDTH
        )
        port map(
            i_A     => A,
            i_B     => B,
            i_Op    => Op,
            o_Value => Value
        );

    -- Testbench
    process is
        constant TEST_LEN : integer := 128;
    begin
        for x in 0 to TEST_LEN loop
            for y in 0 to TEST_LEN loop
                A <= to_unsigned(x, BIT_WIDTH + 1);
                B <= to_unsigned(y, BIT_WIDTH + 1);
                wait for 0 ns;

                Op <= dec_OpEQ;
                wait for 10 ns;
                assert (Value = '1') = (A = B)
                report "Assertion failed for ET (" & integer'image(x) & ", " & integer'image(y) & ")";

                Op <= dec_OpNEQ;
                wait for 10 ns;
                assert (Value = '1') = (A /= B)
                report "Assertion failed for NET (" & integer'image(x) & ", " & integer'image(y) & ")";

                Op <= dec_OpGT;
                wait for 10 ns;
                assert (Value = '1') = (A > B)
                report "Assertion failed for GT (" & integer'image(x) & ", " & integer'image(y) & ")";

                Op <= dec_OpGTE;
                wait for 10 ns;
                assert (Value = '1') = (A >= B)
                report "Assertion failed for GTE (" & integer'image(x) & ", " & integer'image(y) & ")";

                Op <= dec_OpLT;
                wait for 10 ns;
                assert (Value = '1') = (A < B)
                report "Assertion failed for LT (" & integer'image(x) & ", " & integer'image(y) & ")";

                Op <= dec_OpLTE;
                wait for 10 ns;
                assert (Value = '1') = (A <= B)
                report "Assertion failed for LTE (" & integer'image(x) & ", " & integer'image(y) & ")";

            end loop;
        end loop;
        wait;
    end process;
end architecture;