.data 0x0000
A: .word 11
.text 0x0000
#========io����========
# �������� 16368  �������� 16372
# seg���  16376 led���  16380
#====================
# ������jump
BEGIN:	j MAIN
# handler
B_INTR:	addi $t9,$zero,1
		eret
C_INTR: 	addi $t9,$zero,2
		eret
# main
MAIN:	sw $zero,16376($zero)
		sw $zero,16380($zero)
# ======æ�Ȱ�ť�ж�========
		addi $t9,$zero,0
		addi $t8,$zero,1
WAIT1:	bne $t9,$t8,WAIT1 
#=======================
		# ������
		lw $t1,16368($zero)
		lw $t2,16372($zero)
		# ��case
		beq $t2,$zero,CASE0
		addi $t2,$t2,-1
		beq $t2,$zero,CASE1
		j CASE7

		# 127��0x7f��ȡ����λ
CASE0:	andi $t1,$t1,127
		# ���8λ�з�������oriһ��0x0000ff00����-256
		ori $t1,$t1,-256
		# ����������
		sw $t1,16376($zero)
		addi $s0,$zero,1
		addi $t0,$zero,7
LOOP1:	beq $t0,$zero,EXIT1
		andi $s1,$t1,1
		xor $s0,$s0,$s1
		srl $t1,$t1,1
		addi $t0,$t0,-1
		j LOOP1
EXIT1:	sw $s0,16380($zero)
		j RE1

CASE1:	ori $t1,$t1,-256
		sw $t1,16376($zero)
		addi $s0,$zero,1
		addi $t0,$zero,8
LOOP2:	beq $t0,$zero,EXIT1
		andi $s1,$t1,1
		xor $s0,$s0,$s1
		srl $t1,$t1,1
		addi $t0,$t0,-1
		j LOOP1
EXIT2:	sw $s0,16380($zero)
		j RE1

CASE2:	nor $s1,$t1,$t2
		sw $s1,16380($zero)
		j RE1

CASE3:	or $s1,$t1,$t2
		sw $s1,16380($zero)
		j RE1

CASE4:	xor $s1,$t1,$t2
		sw $s1,16380($zero)
		j RE1

CASE5:	sltu $s1,$t1,$t2	
		sw $s1,16380($zero)
		j RE1

CASE6:	sll $t1, $t1, 24
		sra $t1, $t1, 24
		sll $t2, $t2, 24
		sra $t2, $t2, 24
		slt $s1,$t1,$t2
		sw $t1,16376($zero)
		sw $s1,16380($zero)
		j RE1

CASE7:	ori $t0,$t1,-256
		sw $t0,16376($zero)
		addi $t9,$zero,0
		addi $t8,$zero,1
WAIT2:	bne $t9,$t8,WAIT2
		lw $t2,16368($zero)
		ori $t3,$t2,-256
		sll $t0,$t0,16
		or $t0,$t0,$t3
		sw $t0,16376($zero)
		j RE2

# 0��1�����������RE1æ�ȣ�����ť��main������
RE1:		addi $t9,$zero,0
		addi $t8,$zero,1
WAIT3:	bne $t9,$t8,WAIT3
		j MAIN
# 7�����������RE2æ�ȣ�����ť����һcase�����Ϸ��ͻ�main
RE2:		addi $t9,$zero,0
		addi $t8,$zero,1
WAIT4:	bne $t9,$t8,WAIT4
		#��case
		lw $t0,16372($zero)
		addi $t0,$t0,-2
		beq $t0,$zero,CASE2
		addi $t0,$t0,-1
		beq $t0,$zero,CASE3
		addi $t0,$t0,-1
		beq $t0,$zero,CASE4
		addi $t0,$t0,-1
		beq $t0,$zero,CASE5
		addi $t0,$t0,-1
		beq $t0,$zero,CASE6
		j MAIN
