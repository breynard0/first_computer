library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.ALUTypes.all;

entity alu_tb is
end entity;

architecture sim of alu_tb is
    constant BIT_WIDTH : integer := 7;
    signal A           : unsigned(BIT_WIDTH downto 0);
    signal B           : unsigned(BIT_WIDTH downto 0);
    signal Op          : AluOperation := Add;
    signal Value       : unsigned(BIT_WIDTH downto 0);
begin
    alu_inst : entity work.alu
        generic map(
            BIT_WIDTH => BIT_WIDTH
        )
        port map(
            i_A     => A,
            i_B     => B,
            i_Op    => Op,
            o_Value => Value
        );

    process
        constant TEST_WIDTH : integer := 128;
    begin
        for x in 0 to TEST_WIDTH loop
            for y in 0 to TEST_WIDTH loop
                A <= to_unsigned(x, BIT_WIDTH + 1);
                B <= to_unsigned(y, BIT_WIDTH + 1);

                wait for 10 ns;

                Op <= Add;
                wait for 10 ns;
                assert Value = (A + B)
                report "Assertion failed for Add (" & integer'image(to_integer(unsigned(A))) & ", " & integer'image(to_integer(unsigned(B))) & ")";

                Op <= Sub;
                wait for 10 ns;
                assert Value = (A - B)
                report "Assertion failed for Sub (" & integer'image(to_integer(unsigned(A))) & ", " & integer'image(to_integer(unsigned(B))) & ")";

                Op <= OpAnd;
                wait for 10 ns;
                assert Value = (A and B)
                report "Assertion failed for AND (" & integer'image(to_integer(unsigned(A))) & ", " & integer'image(to_integer(unsigned(B))) & ")";

                Op <= OpOr;
                wait for 10 ns;
                assert Value = (A or B)
                report "Assertion failed for OR (" & integer'image(to_integer(unsigned(A))) & ", " & integer'image(to_integer(unsigned(B))) & ")";

                Op <= OpNot;
                wait for 10 ns;
                assert Value = (not A)
                report "Assertion failed for NOT (" & integer'image(to_integer(unsigned(A))) & ")";

                Op <= OpXor;
                wait for 10 ns;
                assert Value = (A xor B)
                report "Assertion failed for XOR (" & integer'image(to_integer(unsigned(A))) & ", " & integer'image(to_integer(unsigned(B))) & ")";

            end loop;
        end loop;
        wait;
    end process;

end architecture;