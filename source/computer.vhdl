library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package ComputerTypes is
    constant BIT_WIDTH : integer := 7;
    type REGISTERS is record
        r_A  : unsigned(BIT_WIDTH downto 0);
        r_B  : unsigned(BIT_WIDTH downto 0);
        r_C  : unsigned(BIT_WIDTH downto 0);
        r_D  : unsigned(BIT_WIDTH downto 0);
        r_PC : unsigned(BIT_WIDTH downto 0);
        r_MP : unsigned(BIT_WIDTH downto 0);
    end record;
    function get_reg_value (index : unsigned(BIT_WIDTH downto 0); registers : REGISTERS) return unsigned;
end package;

package body ComputerTypes is
    function get_reg_value (index : unsigned(BIT_WIDTH downto 0); registers : REGISTERS) return unsigned is
    begin
        case index is
            when "00000001" =>
                return registers.r_A;
            when "00000010" =>
                return registers.r_B;
            when "00000011" =>
                return registers.r_C;
            when "00000100" =>
                return registers.r_D;
            when "00000101" =>
                return registers.r_PC;
            when "00000110" =>
                return registers.r_MP;
            when others =>
                return "00000000";
        end case;
    end function;
end package body ComputerTypes;