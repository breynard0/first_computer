-- Program package, simply cleaner code to put it here
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package Program is
    -- Fibbonacci currently loaded in
    constant SAMPLE_PROGRAM : work.ComputerTypes.PROGRAM_TYPE := (
        "00000001", "00000001", "00000000", "00000000", "00000001", "00000010", "00000001", "00000000", "00000001", "00000011", "00001100", "00000000", "10100001", "00000011", "00000011", "00000001", "10000001", "00000100", "00000010", "00000000", "11100000", "00000010", "00000001", "00000010", "10000001", "00000001", "00000100", "00000000", "10010001", "00000100", "00000011", "00000000", "10000010", "00000011", "00000100", "00000000", "10000001", "10001000", "00000001", "00000000", "00000101", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000"
);

end package Program;