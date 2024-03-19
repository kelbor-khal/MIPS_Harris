# author: Filin I.A.
# functional: Assembler MIPS - constants
# last revision: 05.02.2024

# mode programm
SINGLE_COMMAND = 1
ALL_PROGRAMM   = 2

# output view
BIN_VIEW = 1
HEX_VIEW = 2

# write in file or only display
WR_IN_FILE = 1
DISPLAY    = 2

# input arguments
MNEMONICA = 0
AGRUMENT  = 1

# type argument
REG_TYPE = 'R'
IMM_TYPE = 'I'
JMP_TYPE = 'J'

# symbols
COMMA = ','
ASM_COMMENT  = '#'
LEFT_BRACKET  = '('
RIGHT_BRACKET = ')'


# path to the specifications files
REGISTER_SPEC    = "../specification/register_map.txt"
INSTRUCTION_SPEC = "../specification/instruction_map.txt"