package ALUTypes is
    type AluOperation is (Add, Sub, OpAnd, OpOr, OpNot, OpXor);

end package ALUTypes;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.ALUTypes.all;

entity alu is
    generic (
        constant BIT_WIDTH : in integer
    );
    port (
        i_A     : in unsigned(BIT_WIDTH downto 0);
        i_B     : in unsigned(BIT_WIDTH downto 0);
        i_Op    : in AluOperation;
        o_Value : out unsigned(BIT_WIDTH downto 0)
    );
end entity;

architecture rtl of alu is
begin
    process (all) is
    begin
        case i_Op is
            when Add =>
                o_Value <= i_A + i_B;
            when Sub =>
                o_Value <= i_A - i_B;
            when OpAnd =>
                o_Value <= i_A and i_B;
            when OpOr =>
                o_Value <= i_A or i_B;
            when OpNot =>
                o_Value <= not i_A;
            when OpXor =>
                o_Value <= i_A xor i_B;
            when others =>
                null;
        end case;
    end process;

end architecture;