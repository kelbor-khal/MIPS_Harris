# author: Filin I.A.
# functional: checking correct work processor
# last revision: 05.02.24


main:
    addi $t2, $0, 5
    addi $t3, $0, 12
    addi $t7, $t3, -9
    or   $t4, $t7, $t2
    and  $t5, $t3, $t4
    add  $t5, $t5, $t4
    beq  $t5, $t7, end
    slt  $t4, $t3, $t4
    beq  $t4, $0, around
    addi $t5, $0,  0

around:
    slt  $t4, $t7, $t2
    add  $t7, $t4, $t5
    sub  $t7, $t7, $t2
    sw   $t7, 68($t3)
    lw   $t2, 80($0)
    j    end
    addi $t2, $0, 1

end:
    sw   $t2, 84($0)