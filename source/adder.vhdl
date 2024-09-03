library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity adder is
    generic (
        constant BIT_WIDTH : in integer
    );
    port (
        i_A     : in unsigned(BIT_WIDTH downto 0);
        i_B     : in unsigned(BIT_WIDTH downto 0);
        o_Value : out unsigned(BIT_WIDTH downto 0);
        o_Carry : out std_logic
    );
end entity;

architecture rtl of adder is
    procedure full_adder (
        a    : in std_logic;
        b    : in std_logic;
        cin  : in std_logic;
        sum  : out std_logic;
        cout : out std_logic
    ) is
    begin
        sum  := (a xor b) xor cin;
        cout := (cin and (a xor b)) or (a and b);
    end procedure;

begin
    process (i_A, i_B) is
        variable cout_in    : std_logic                    := '0';
        variable last_cout  : std_logic                    := '0';
        variable value_temp : unsigned(BIT_WIDTH downto 0) := to_unsigned(0, BIT_WIDTH + 1);
    begin
        last_cout := '0';

        for i in 0 to BIT_WIDTH loop
            cout_in := last_cout;

            full_adder(
            i_A(i),
            i_B(i),
            cout_in,
            value_temp(i),
            last_cout
            );
        end loop;

        o_Value <= value_temp;
        o_Carry <= last_cout;
    end process;
end architecture;