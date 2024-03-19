# author: Filin I.A.
# functional: Assembler MIPS - main file
# last revision: 31.01.2024

# adding output bin format in file

import constants
import preparing_file
import convert_command

reg_map   = open(constants.REGISTER_SPEC, 'r')
instr_map = open(constants.INSTRUCTION_SPEC, 'r')

cln_r_map = preparing_file.del_substr_smbl(reg_map, '//')
cln_i_map = preparing_file.del_substr_smbl(instr_map, '//')

mode_parcer = input("Choose mode translation: "
                    " 1 - one command (only R and I); "
                    " 2 - all programm : ")


if(int(mode_parcer) == constants.SINGLE_COMMAND):
    inpt_comm  = input("Write instruction on MIPS arch: ")
    splt_comm  = [j for j in (inpt_comm.split(" ")) if j]

    i_info = convert_command.check_mnemonica(splt_comm[0], cln_i_map)
    r_info = convert_command.check_argument(splt_comm[1:], i_info, cln_r_map)
    m_code = convert_command.link_instruction(i_info ,r_info)

    print("hex view: %s " % (m_code[0]).zfill(8))
    print("bin view:", ' '.join(m_code[1]).zfill(8))


elif (int(mode_parcer) == constants.ALL_PROGRAMM):
    prgrm_file = input("Write path to progtamm file on asm MIPS: ")
    prgrm_src  = open(prgrm_file, 'r')  
    
    wr_in_file = input("Wrirte in file or only display result translate: "
             " 1 - write in file; "
             " 2 - only display result: ")
    if(int(wr_in_file) == constants.WR_IN_FILE):
        output_file = input("Write path to output file: ")
        prgrm_out   = open(output_file, 'w') 
        view_mode   = input("Choose output view: 1 - binary; 2 - hexadecimal: ")
    
    no_com_prgrm = preparing_file.del_substr_smbl(prgrm_src,constants.ASM_COMMENT).split('\n')

    laybels = list('')
    clb_prgrm = list('')

    # # search laybels and add in split
    for i in range(0, len(no_com_prgrm)):
        if((no_com_prgrm[i]).find(':') == -1):
            clb_prgrm.append(no_com_prgrm[i])
        else:
            laybels.append(i)
            laybels.append((no_com_prgrm[i])[0:len(no_com_prgrm) - 1])

    print('|||')
    for i in range(0, len(clb_prgrm)):
        instr = [j for j in clb_prgrm[i].split(" ") if j]

        if not instr:
            continue
        else:
            i_info = convert_command.check_mnemonica(instr[0], cln_i_map)
        # switch laybels
        if((i_info[1] == constants.IMM_TYPE) | 
           (i_info[1] == constants.JMP_TYPE)):
           instr[-1] = convert_command.switch_laybels(instr, laybels, i, i_info[1])
        # convert command
        if((i_info[1] == constants.IMM_TYPE) | 
           (i_info[1] == constants.REG_TYPE)):
            r_info = convert_command.check_argument(instr[1:],i_info,cln_r_map)
            m_code = convert_command.link_instruction(i_info, r_info, i)
        else:
            m_code = convert_command.link_instruction(i_info, instr[-1], i)

        # display
        if(int(wr_in_file) == constants.DISPLAY):
            print(('%-10s %-10s %-25s %-50s') % ((hex(i*4)[2:]).zfill(8),
                                                 (m_code[0] [2:]).zfill(8),
                                                 (''.join(m_code [1])),
                                                 '# ' + clb_prgrm[i][4:]))
        # write in file
        elif(int(wr_in_file) == constants.WR_IN_FILE):
            if(int(view_mode) == constants.BIN_VIEW):
                prgrm_out.write(''.join(m_code [1]) + '\n')
            elif(int(view_mode) == constants.HEX_VIEW):
                prgrm_out.write((m_code[0] [2:]).zfill(8) + '\n')

    print('|||')
    prgrm_src.close()

reg_map.close()
instr_map.close()