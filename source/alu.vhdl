library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.DecoderTypes.all;

entity alu is
    generic (
        constant BIT_WIDTH : in integer
    );
    port (
        i_A     : in unsigned(BIT_WIDTH downto 0);
        i_B     : in unsigned(BIT_WIDTH downto 0);
        i_Op    : in OPCODE;
        o_Value : out unsigned(BIT_WIDTH downto 0)
    );
end entity;

architecture rtl of alu is
begin
    process (all) is
    begin
        case i_Op is
            when dec_OpADD =>
                o_Value <= i_A + i_B;
            when dec_OpSUB =>
                o_Value <= i_A - i_B;
            when dec_OpAND =>
                o_Value <= i_A and i_B;
            when dec_OpOR =>
                o_Value <= i_A or i_B;
            when dec_OpNOT =>
                o_Value <= not i_A;
            when dec_OpXOR =>
                o_Value <= i_A xor i_B;
            when others =>
                null;
        end case;
    end process;

end architecture;