library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity memory is
    generic (
        constant BIT_WIDTH : in integer;
        constant MEM_SIZE  : in integer
    );
    port (
        i_Rst     : in std_logic;
        i_Set     : in std_logic;
        i_Get     : in std_logic;
        i_Address : in unsigned(BIT_WIDTH downto 0);
        i_Value   : in unsigned(BIT_WIDTH downto 0);
        o_Value   : out unsigned(BIT_WIDTH downto 0)
    );
end entity;

architecture rtl of memory is
    type MEM_BLOCK is array (0 to MEM_SIZE) of unsigned(BIT_WIDTH downto 0);
    signal r_MemBlock : MEM_BLOCK := (others => to_unsigned(0, BIT_WIDTH + 1));
begin
    process (all) is
        
    begin
        if i_Rst = '1' then
            r_MemBlock <= (others => to_unsigned(0, BIT_WIDTH + 1)); 
        end if;

        if i_Set = '1' then
            r_MemBlock(to_integer(i_Address)) <= i_Value;
        end if;

        if i_Get = '1' then
            report integer'image(to_integer(i_Address));
            o_Value <= r_MemBlock(to_integer(i_Address));
        end if;
    end process;
end;