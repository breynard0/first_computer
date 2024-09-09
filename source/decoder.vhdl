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
        dec_OpJNZ
    );

    type INSTRUCTION is record
        opcode       : OPCODE;
        destination  : unsigned(BIT_WIDTH downto 0);
        first_param  : unsigned(BIT_WIDTH downto 0);
        second_param : unsigned(BIT_WIDTH downto 0);
    end record;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.DecoderTypes.all;
use work.ComputerTypes.all;

entity decoder is
    port (
        bytes : in RAW_BYTES;
        inst  : out INSTRUCTION;
        registers: in REGISTERS
    );
end entity;

architecture rtl of decoder is
    impure function gen_inst(opcode : Opcode; fa: boolean; sa: boolean) return INSTRUCTION is
        variable fp : unsigned(BIT_WIDTH downto 0) := bytes(2);
        variable sp : unsigned(BIT_WIDTH downto 0) := bytes(3);
    begin
        if fa then
            
        end if;
        
        return (
        opcode       => opcode,
        destination  => bytes(1),
        first_param  => fp,
        second_param => sp
        );
    end function;
begin
    process (all)
        variable fp : boolean := bytes(0)(BIT_WIDTH) = '1';
        variable sp : boolean := bytes(0)(BIT_WIDTH - 1) = '1';
    begin


        case shift_left(bytes(0), 2) is
            when "10000000" =>
                inst <= gen_inst(dec_OpADD, fp, sp);
            when "10000100" =>
                inst <= gen_inst(dec_OpSUB, fp, sp);
            when "10001000" =>
                inst <= gen_inst(dec_OpAND, fp, sp);
            when "10001100" =>
                inst <= gen_inst(dec_OpOR, fp, sp);
            when "10010000" =>
                inst <= gen_inst(dec_OpNOT, fp, sp);
            when "10011100" =>
                inst <= gen_inst(dec_OpXOR, fp, sp);
            when "01000100" =>
                inst <= gen_inst(dec_OpGT, fp, sp);
            when "01001000" =>
                inst <= gen_inst(dec_OpGTE, fp, sp);
            when "01001100" =>
                inst <= gen_inst(dec_OpLT, fp, sp);
            when "01010000" =>
                inst <= gen_inst(dec_OpLTE, fp, sp);
            when "01010100" =>
                inst <= gen_inst(dec_OpEQ, fp, sp);
            when "01011000" =>
                inst <= gen_inst(dec_OpNEQ, fp, sp);
            when "00000100" =>
                inst <= gen_inst(dec_OpMOV, fp, sp);
            when "00001000" =>
                inst <= gen_inst(dec_OpJNZ, fp, sp);
            when others =>
                null;
        end case;
    end process;
end architecture;