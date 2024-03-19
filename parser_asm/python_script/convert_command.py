# author: Filin I.A.
# functional: Assembler MIPS - converting functions 
# inputs instructions to hex or bin
# last revision: 05.02.2024

import constants
import parcer_exceptions

# two's complement positive and negative number
def two_compl (n, bits):
    mask = (1 << bits) - 1
    if n < 0:
        n = ((abs(n) ^ mask) + 1)
    return int(n & mask)


# delete set end symbol in string
def delete_endsymbol (strng, symbol):
    # if (strng.find(symbol)):
    if symbol in strng:
        return (strng)[:-1]
    else:
        return  strng

# switching labels to numbers for instructions
def switch_laybels(instr, laybels, num_instr, type_i):
    if (instr[-1] + ':') in laybels:
        for i in range (1, len(laybels), 2):
            if ((instr[-1] + ':') == laybels[i]):
                if(type_i == constants.IMM_TYPE):
                    return laybels[i - 1] - num_instr - 2
                elif(type_i == constants.JMP_TYPE):
                    return laybels[i - 1] - 2
    else:
        return instr[-1]
           

# checking correct input mnenonica or arguments
def presence_str (inpt, file, type):
    if not inpt in file:
        if(type == constants.MNEMONICA):
            raise parcer_exceptions.UnknownMnemonica(inpt)
        elif(type == constants.AGRUMENT):
            raise parcer_exceptions.UnknownArgument(inpt)


# searching fora string in list
def search_str_in_split (elemt, file, symbl = '\n'):
    index_in  = file.find(elemt)
    index_out = file.find(symbl, index_in)
    return (file[index_in : index_out]).split()


# return instruction specification
def check_mnemonica(command, instr_map):
    presence_str(command, instr_map, constants.MNEMONICA)
    return search_str_in_split(command, instr_map)


# return split nased register and constant
def second_arg_based_addr(argument):
    index_in  = argument.find(constants.LEFT_BRACKET)
    index_out = argument.find(constants.RIGHT_BRACKET)
    return (argument[:index_in], argument[index_in + 1 : index_out])


# checking correct input arguments
def check_argument (arg, instr_info, reg_map):
    arg_return = list()

    if(int(instr_info[-1]) != len(arg)):
        raise parcer_exceptions.InvalidNumArgument(len(arg))

    if(instr_info[1] == constants.REG_TYPE):
        for i in range(0, len(arg)):
            argument = delete_endsymbol(arg[i],constants.COMMA)
            presence_str(argument,reg_map,constants.AGRUMENT)
            arg_return.append((search_str_in_split(argument, reg_map)[1]))

    if(instr_info[1] == constants.IMM_TYPE): # base addressing
        if constants.LEFT_BRACKET in arg[1]:
            argument = delete_endsymbol(arg[0],constants.COMMA)
            arg_return.append(search_str_in_split(argument, reg_map)[1])
            # split second cunstrustion
            scnd_arg = second_arg_based_addr(arg[1])
            num_scnd_arg = (search_str_in_split(scnd_arg[1],reg_map))[1]
            # adding in list
            arg_return.append(num_scnd_arg)
            arg_return.append(scnd_arg[0])

        else: # immidiate addressing
            for i in range(0, len(arg) - 1):
                argument = delete_endsymbol(arg[i],constants.COMMA)
                presence_str(argument,reg_map,constants.AGRUMENT)
                arg_return.append((search_str_in_split(argument, reg_map)[1]))
            arg_return.append(arg[-1]) # add immidiate constant
    return arg_return


# convert list of mnemonics and arguments to machine code
def link_instruction (instr, reg, num = 0):
    asm_command = list()
    
    if(instr[1] == constants.REG_TYPE):
        asm_command = (instr[2],                          # op - 6 b
                      (format(int(reg[1]),'b')).zfill(5), # rs - 5 b
                      (format(int(reg[2]),'b')).zfill(5), # rt - 5 b
                      (format(int(reg[0]),'b')).zfill(5), # rd - 5 b
                       instr[3],                          # sh - 5 b
                       instr[4])                          # fn - 6 b

    if(instr[1] == constants.IMM_TYPE):
        if(int(reg[2]) >= 0):
            asm_command = (instr[2],                           # op - 6 b
                          (format(int(reg[1]),'b')).zfill(5),  # rs - 5 b
                          (format(int(reg[0]),'b')).zfill(5),  # rd - 5 b
                          (format(int(reg[2]),'b')).zfill(16)) # im - 16 b
        else:
            asm_command = (instr[2],                              # op - 6 b
                          (format(int(reg[1]),'b')).zfill(5),     # rs - 5 b
                          (format(int(reg[0]),'b')).zfill(5),     # rd - 5 b
                           format(two_compl(int(reg[2]),16),'b')) # im - 16 b

    if(instr[1] == constants.JMP_TYPE):
        if(reg > 0):
            asm_command = (instr[2],                          # op - 6 b
                          format((int(reg)),'b').zfill(26))   # ad - 26 b
        else:
            asm_command = (instr[2],                          # op - 6 b
                          format(two_compl(int(reg),26),'b')) # ad - 26 b

    command = hex(int(''.join(asm_command), 2))
    return (command, asm_command)