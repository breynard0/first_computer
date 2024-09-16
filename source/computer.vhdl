library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.ComputerTypes.all;
use work.DecoderTypes.all;
use work.Program.all;

entity computer is
    port (
        clk    : in std_logic;
        reset  : in std_logic;
        output : out unsigned(BIT_WIDTH downto 0)
    );
end entity;

architecture rtl of computer is
    -- ALU and Comparator stuff
    signal ac_Op      : OPCODE;
    signal alu_Value  : unsigned(BIT_WIDTH downto 0);
    signal comp_value : std_logic;

    -- Memory Stuff
    signal mem_Set      : std_logic                    := '0';
    signal mem_Get      : std_logic                    := '0';
    signal mem_Addr     : unsigned(BIT_WIDTH downto 0) := "00000000";
    signal mem_SetValue : unsigned(BIT_WIDTH downto 0) := "00000000";
    signal mem_GetValue : unsigned(BIT_WIDTH downto 0) := "00000000";

    -- Program
    constant program   : PROGRAM_TYPE                 := SAMPLE_PROGRAM;
    signal r_PC        : unsigned(BIT_WIDTH downto 0) := "00000000";
    signal halt_queued : std_logic                    := '0';
    signal halt        : std_logic                    := '0';

    -- Decoder Stuff
    signal dec_RawBytes : RAW_BYTES;
    signal Inst         : INSTRUCTION;
    signal Regs         : REGISTERS := (
        r_A => "00000000",
        r_B => "00000000",
        r_C => "00000000",
        r_D => "00000000"
    );

    -- Output Stuff
    signal o_Dest : unsigned(BIT_WIDTH downto 0);
    type o_Loc_Type is (ALU, COMP, MEM, VALUE);
    signal o_Loc   : o_Loc_Type;
    signal o_Value : unsigned(BIT_WIDTH downto 0);

    -- Procedures and functions
    function std_logic_to_unsigned(input : std_logic) return unsigned is
    begin
        if input = '1' then
            return to_unsigned(1, BIT_WIDTH + 1);
        else
            return to_unsigned(0, BIT_WIDTH + 1);
        end if;
    end function;
begin
    memory_inst : entity work.memory
        generic map(
            BIT_WIDTH => BIT_WIDTH,
            MEM_SIZE  => 256
        )
        port map(
            i_Rst     => reset,
            i_Set     => mem_Set,
            i_Get     => mem_Get,
            i_Address => mem_Addr,
            i_Value   => mem_SetValue,
            o_Value   => mem_GetValue
        );

    alu_inst : entity work.alu
        generic map(
            BIT_WIDTH => BIT_WIDTH
        )
        port map(
            i_A     => Inst.first_param,
            i_B     => Inst.second_param,
            i_Op    => ac_Op,
            o_Value => alu_Value
        );

    comparator_inst : entity work.comparator
        generic map(
            BIT_WIDTH => BIT_WIDTH
        )
        port map(
            i_A     => Inst.first_param,
            i_B     => Inst.second_param,
            i_Op    => ac_Op,
            o_Value => comp_Value
        );

    decoder_inst : entity work.decoder
        port map(
            bytes     => dec_RawBytes,
            registers => Regs,
            inst      => Inst
        );

    process (clk)
        variable pc              : integer := to_integer(r_PC);
        variable output_temp_val : unsigned(BIT_WIDTH downto 0);
    begin
        pc := to_integer(r_PC);

        if falling_edge(clk) and halt = '0' then
            -- Update output
            case o_Loc is
                when ALU =>
                    output_temp_val := alu_Value;
                when COMP =>
                    output_temp_val := std_logic_to_unsigned(comp_Value);
                when MEM =>
                    output_temp_val := mem_GetValue;
                when VALUE =>
                    output_temp_val := o_Value;
                when others =>
                    null;
            end case;

            case o_Dest is
                when "00000001" =>
                    Regs.r_A <= output_temp_val;
                when "00000010" =>
                    Regs.r_B <= output_temp_val;
                when "00000011" =>
                    Regs.r_C <= output_temp_val;
                when "00000100" =>
                    Regs.r_D <= output_temp_val;
                when "10001000" =>
                    output <= output_temp_val;
                when others =>
                    null;
            end case;

            -- Update decoder
            if pc < 255 then
                r_PC <= r_PC + 1;
            end if;

            dec_RawBytes <= (
                program(pc * 4),
                program(pc * 4 + 1),
                program(pc * 4 + 2),
                program(pc * 4 + 3)
                );

            -- Halt program after falling edge has finished
            if halt_queued = '1' then
                halt <= '1';
            end if;
        end if;

        if rising_edge(clk) and halt = '0' then
            mem_Get <= '0';
            mem_Set <= '0';

            case inst.opcode is
                when dec_OpADD =>
                    ac_Op  <= dec_OpADD;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpSUB =>
                    ac_Op  <= dec_OpSUB;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpAND =>
                    ac_Op  <= dec_OpAND;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpOR =>
                    ac_Op  <= dec_OpOR;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpNOT =>
                    ac_Op  <= dec_OpNOT;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpXOR =>
                    ac_Op  <= dec_OpXOR;
                    o_Dest <= Inst.destination;
                    o_Loc  <= ALU;
                when dec_OpGT =>
                    ac_Op  <= dec_OpGT;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpGTE =>
                    ac_Op  <= dec_OpGTE;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpLT =>
                    ac_Op  <= dec_OpLT;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpLTE =>
                    ac_Op  <= dec_OpLTE;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpEQ =>
                    ac_Op  <= dec_OpEQ;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpNEQ =>
                    ac_Op  <= dec_OpNEQ;
                    o_Dest <= Inst.destination;
                    o_Loc  <= COMP;
                when dec_OpMOV =>
                    o_Dest  <= Inst.destination;
                    o_Loc   <= VALUE;
                    o_Value <= inst.first_param;
                when dec_OpJNZ =>
                    if inst.first_param /= 0 then
                        r_PC <= inst.destination;
                    end if;
                when dec_OpMGT =>
                    mem_Get  <= '1';
                    mem_Addr <= inst.first_param;
                    o_Dest   <= inst.destination;
                    o_Loc    <= MEM;
                when dec_OpMST =>
                    mem_Set      <= '1';
                    mem_Addr     <= inst.first_param;
                    mem_SetValue <= inst.second_param;
                when dec_OpHLT =>
                    halt_queued <= '1';
                when others =>
                    null;
            end case;
        end if;
    end process;
end architecture;