package alu_types is
    type AluOperation is (Add, Sub, OpAnd, OpOr, OpNot, OpXor);

end package alu_types;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.alu_types.all;

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
    signal Carry : std_logic;
    signal AdderOut : unsigned(BIT_WIDTH downto 0);
begin
    adder_inst: entity work.adder
     generic map(
        BIT_WIDTH => BIT_WIDTH
    )
     port map(
        i_A => i_A,
        i_B => i_B,
        o_Value => AdderOut,
        o_Carry => Carry
    );

    process (all) is
    begin
        case i_Op is
            when Add =>
                o_Value <= AdderOut;
            when Sub =>
                o_Value <= i_A - i_B;
            when OpAnd =>
            when OpOr =>
            when OpNot =>
            when OpXor =>
            when others =>
                null;
        end case;
    end process;

end architecture;