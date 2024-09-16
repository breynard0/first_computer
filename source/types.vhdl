library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package ComputerTypes is
    constant BIT_WIDTH : integer := 7;
    type PROGRAM_TYPE is array (0 to 255) of unsigned(BIT_WIDTH downto 0);

    type REGISTERS is record
        r_A  : unsigned(BIT_WIDTH downto 0);
        r_B  : unsigned(BIT_WIDTH downto 0);
        r_C  : unsigned(BIT_WIDTH downto 0);
        r_D  : unsigned(BIT_WIDTH downto 0);
    end record;
    function get_reg_value (index : unsigned(BIT_WIDTH downto 0); rgs : REGISTERS) return unsigned;
    procedure get_input (variable input    : out unsigned(BIT_WIDTH downto 0));
    procedure push_output (variable output : in unsigned(BIT_WIDTH downto 0));
end package;

package body ComputerTypes is
    function get_reg_value (index : unsigned(BIT_WIDTH downto 0); rgs : REGISTERS) return unsigned is
    begin
        case index is
            when "00000001" =>
                return rgs.r_A;
            when "00000010" =>
                return rgs.r_B;
            when "00000011" =>
                return rgs.r_C;
            when "00000100" =>
                return rgs.r_D;
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
use work.ComputerTypes.all;

package DecoderTypes is
    type RAW_BYTES is array (0 to 3) of unsigned(BIT_WIDTH downto 0);

    type OPCODE is (
        dec_OpADD,
        dec_OpSUB,
        dec_opAND,
        dec_OpOR,
        dec_OpNOT,
        dec_OpXOR,
        dec_OpGT,
        dec_OpGTE,
        dec_OpLT,
        dec_OpLTE,
        dec_OpEQ,
        dec_OpNEQ,
        dec_OpMOV,
        dec_OpJNZ,
        dec_OpMGT,
        dec_OpMST,
        dec_OpHLT
    );

    type INSTRUCTION is record
        opcode       : OPCODE;
        destination  : unsigned(BIT_WIDTH downto 0);
        first_param  : unsigned(BIT_WIDTH downto 0);
        second_param : unsigned(BIT_WIDTH downto 0);
    end record;
end package;