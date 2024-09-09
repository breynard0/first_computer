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
    procedure get_input (variable input    : out unsigned(BIT_WIDTH downto 0));
    procedure push_output (variable output : in unsigned(BIT_WIDTH downto 0));

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

    procedure get_input (variable input : out unsigned(BIT_WIDTH downto 0)) is
    begin
        -- Will improve when I get my hands on an FPGA board
        input := "00000001";
    end procedure;

    procedure push_output (variable output : in unsigned(BIT_WIDTH downto 0)) is
    begin
        report integer'image(to_integer(output));
    end procedure;
end package body ComputerTypes;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity computer is
    port (
        clk   : in std_logic;
        reset : in std_logic
    );
end entity;