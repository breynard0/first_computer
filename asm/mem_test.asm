; Assembly code
MOV REG_A 0
MOV REG_B 0
LABEL loopastart
MST _ %REG_A %REG_B
ADD REG_A 1 %REG_A
ADD REG_B 2 %REG_B
LT REG_C %REG_A 16
JNZ loopastart %REG_C
LABEL loopbstart
MGT OUT %REG_A
SUB REG_A %REG_A 1
NEQ REG_D %REG_A 0
JNZ loopbstart %REG_D
HLT