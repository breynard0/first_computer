library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.DecoderTypes.all;
use work.ComputerTypes.all;

entity decoder is
    port (
        bytes     : in RAW_BYTES;
        registers : in REGISTERS;
        inst      : out INSTRUCTION
    );
end entity;

architecture rtl of decoder is
    impure function gen_inst(opcode : Opcode; fa : boolean; sa : boolean) return INSTRUCTION is
        variable fp : unsigned(BIT_WIDTH downto 0) := bytes(2);
        variable sp : unsigned(BIT_WIDTH downto 0) := bytes(3);
    begin
        if fa then
            if fp(BIT_WIDTH) = '1' then
                case fp is
                    when "10000111" =>
                        get_input(fp);
                    when "10001000" => 
                        report "Error: Tried to set parameter to output";
                    when others =>
                        null;
                end case;
            else
                fp := get_reg_value(fp, registers);
            end if;
        end if;

        if sa then
            if sp(BIT_WIDTH) = '1' then
                case sp is
                    when "10000111" =>
                        get_input(sp);
                    when "10001000" => 
                        report "Error: Tried to set parameter to output";
                    when others =>
                        null;
                end case;
            else
                sp := get_reg_value(sp, registers);
            end if;
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
        fp := bytes(0)(BIT_WIDTH) = '1';
        sp := bytes(0)(BIT_WIDTH - 1) = '1';
        -- report std_logic'image(bytes(0)(BIT_WIDTH)) & " + " & boolean'image(fp);
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
            when "00001100" =>
                inst <= gen_inst(dec_OpMGT, fp, sp);
            when "00010000" =>
                inst <= gen_inst(dec_OpMST, fp, sp);
            when "00010100" =>
                inst <= gen_inst(dec_OpHLT, fp, sp);
            when others =>
                null;
        end case;
    end process;
end architecture;