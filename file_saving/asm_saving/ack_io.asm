.data 0x0000
A: .word 11
.text 0x0000
BEGIN:	sll $zero, $zero, 0
        # select the io_port to read
        addi $v0, $zero, 0
        jal READ
        # when return, the io_value is in $v0

        #  . . . the rest of the code


READ:   beq $26, $27, READ
        addi $27, $27, 1
        sll $v0, $v0, 2
        lw $v0, 16368($v0)
        jr $ra


