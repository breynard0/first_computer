package ComparatorTypes is
    type CompOperation is (GT, GTE, LT, LTE, ET, NET);
end package ComparatorTypes;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.ComparatorTypes.all;

entity comparator is
    generic (
        constant BIT_WIDTH : in integer
    );
    port (
        i_A     : in unsigned(BIT_WIDTH downto 0);
        i_B     : in unsigned(BIT_WIDTH downto 0);
        i_Op    : in CompOperation;
        o_Value : out std_logic
    );
end entity;

architecture rtl of comparator is
    function eq (a : unsigned(BIT_WIDTH downto 0); b : unsigned(BIT_WIDTH downto 0)) return std_logic is
    begin
        if (a xor b) = to_unsigned(0, BIT_WIDTH + 1) then
            return '1';
        else
            return '0';
        end if;
    end function;

    function gt (a : unsigned(BIT_WIDTH downto 0); b : unsigned(BIT_WIDTH downto 0)) return std_logic is
        variable index : integer := BIT_WIDTH;
    begin
        while a(index) xnor b(index) loop
            -- Edge case where both are equal to zero
            if index = 0 then
                return '0';
            end if;

            index := index - 1;
        end loop;

        if a(index) = '1' and b(index) = '0' then
            return '1';
        else
            return '0';
        end if;
    end function;
begin

    process (all) is
    begin
        case i_Op is
            when GT =>
                o_Value <= gt(i_A, i_B);
            when GTE =>
                o_Value <= gt(i_A, i_B) or eq(i_A, i_B);
            when LT =>
                o_Value <= (not gt(i_A, i_B)) and (not eq(i_A, i_B));
            when LTE =>
                o_Value <= (not gt(i_A, i_B)) or eq(i_A, i_B);
            when ET =>
                o_Value <= eq(i_A, i_B);
            when NET =>
                o_Value <= not eq(i_A, i_B);
            when others =>
                null;
        end case;
    end process;

end architecture;
