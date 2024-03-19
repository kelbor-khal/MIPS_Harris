# author: Filin I.A.
# functional: Assembler MIPS - exceptions
# last revision: 05.02.2024

class UnknownMnemonica(Exception):
    def __init__(self, *args):
        if args:
            self.message = args [0]
        else:
            self.message = None

    def __str__(self):
        if self.message:
            return ("Unknown mnemonica, {0}, check "
                   "instructions MIPS map!".format(self.message))

class UnknownArgument(Exception):
    def __init__(self, *args):
        if args:
            self.message = args [0]
        else:
            self.message = None

    def __str__(self):
        if self.message:
            return ("Unknown argument, {0}, check "
                   "registers MIPS map!".format(self.message))

class InvalidNumArgument(Exception):
    def __init__(self, *args):
        if args:
            self.message = args [0]
        else:
            self.message = None

    def __str__(self):
        if self.message:
            return ("Invalid number of arguments, {0}, check "
                   "instructions MIPS map".format(self.message))