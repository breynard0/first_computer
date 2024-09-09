library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity memory_tb is
end entity;

architecture sim of memory_tb is
    constant BIT_WIDTH : integer := 7;
    constant MEM_SIZE  : integer := 256;

    signal Rst     : std_logic                    := '0';
    signal Set     : std_logic                    := '0';
    signal Get     : std_logic                    := '0';
    signal Address : unsigned(BIT_WIDTH downto 0) := to_unsigned(0, BIT_WIDTH + 1);
    signal Value   : unsigned(BIT_WIDTH downto 0) := to_unsigned(0, BIT_WIDTH + 1);
    signal Output  : unsigned(BIT_WIDTH downto 0);
begin
    -- Device Under Test
    memory_inst : entity work.memory
        generic map(
            BIT_WIDTH => BIT_WIDTH,
            MEM_SIZE  => MEM_SIZE
        )
        port map(
            i_Rst     => Rst,
            i_Set     => Set,
            i_Get     => Get,
            i_Address => Address,
            i_Value   => Value,
            o_Value   => Output
        );

    -- Testbench
    process is
    begin
        wait for 10 ns;
        Address <= to_unsigned(16, BIT_WIDTH + 1);
        Get <= '1';
        wait for 10 ns;
        Get <= '0';
        Set <= '1';
        Address <= to_unsigned(32, BIT_WIDTH + 1);
        Value <= to_unsigned(136, BIT_WIDTH + 1);
        wait for 10 ns;
        Set <= '0';
        wait for 10 ns;
        Set <= '1';
        Value <= to_unsigned(12, BIT_WIDTH + 1);
        Address <= to_unsigned(64, BIT_WIDTH + 1);
        wait for 10 ns;
        Set <= '0';
        Get <= '1';
        Address <= to_unsigned(32, BIT_WIDTH + 1);
        wait for 10 ns;
        Get <= '1';
        Address <= to_unsigned(64, BIT_WIDTH + 1);
        wait for 10 ns;
        Rst <= '1';
        wait for 10 ns;
        wait;
    end process;
end architecture;