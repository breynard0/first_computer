MOV REG_A 0
MOV REG_B 1
MOV REG_C 12
LABEL loop
SUB REG_C %REG_C 1
MOV REG_D %REG_B
ADD REG_B %REG_A %REG_B
MOV REG_A %REG_D
GT REG_D %REG_C 0
JNZ loop %REG_D
MOV OUT %REG_A
HLT