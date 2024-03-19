# author: Filin I.A.
# functional: Assembler MIPS - cleaning file at symbols and comments
# and searching substrings
# last revision: 05.02.2024

# deleting a string from the list, if the string contains a substring
def del_substr_smbl (file, comm):
    temp = ''
    while True:
        line = file.readline()
        if not line:
            break
        if ((line[0:len(comm)] != comm) & ((len(line) - 1) != 0 )):
            temp += line
    return temp