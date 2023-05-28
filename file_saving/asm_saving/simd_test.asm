.data 0x0000
A: .word 11
.text 0x0000
BEGIN:	j MAIN
# handler
B_INTR:	addi $t9,$zero,1
		eret
C_INTR: addi $t9,$zero,2
		eret
# main
MAIN: 	addi $zero, $zero, 0
		addi $t0, $zero, 1
		addi $t1, $zero, 2
		addi $t2, $zero, 3
		addi $t3, $zero, 4
		add $t0, $t0, $t0 
		sw $t0, 16368($zero)
		jal WAIT
		sw $t1, 16368($zero)
		jal WAIT
		sw $t2, 16368($zero)
		jal WAIT
		sw $t3, 16368($zero)
		jal WAIT
		add $t0, $t0, $t0 
		sw $t0, 16368($zero)
		jal WAIT
		sw $t1, 16368($zero)
		jal WAIT
		sw $t2, 16368($zero)
		jal WAIT
		sw $t3, 16368($zero)
		jal WAIT
		j TRAP
		
WAIT:	addi $v0, $v0, 1000
LOOP:	addi $v0, $v0, -1
		bne $v0, $zero, LOOP
		jr $ra
TRAP:	beq $zero, $zero, TRAP
