.data 0x0000
A: .word 11
.text 0x0000

# ========io����========
# �������� 16368  �������� 16372
# seg���  16376 led���  16380
# ====================
BEGIN:
    j       MAIN
B_INTR:
    addi    $t9,        $zero,          1
    eret    
C_INTR:
    addi    $t9,        $t9,            -1
    eret    
MAIN:
    sw      $zero,      16376($zero)
    sw      $zero,      16380($zero)
    addi    $t9,        $zero,          0
    addi    $t8,        $zero,          1
WAIT1:
    bne     $t9,        $t8,            WAIT1
    lw      $t1,        16368($zero)
    lw      $t2,        16372($zero)
    beq     $t2,        $zero,          CASE0
    addi    $t2,        $t2,            -1
    beq     $t2,        $zero,          CASE1
    addi    $t2,        $t2,            -1
    beq     $t2,        $zero,          CASE2
    addi    $t2,        $t2,            -1
    beq     $t2,        $zero,          CASE3
    j       CASE8

CASE0:
    sll     $t1,        $t1,            24
    sra     $t1,        $t1,            24
    slt     $t0,        $t1,            $zero
    addi    $s1,        $zero,          0
    bne     $t0,        $zero,          IF1a
    j       IF1b

# t1<0
IF1a:
    addi    $t0,        $t1,            0
LOOP2:
    beq     $t0,        $zero,          EXIT1
    add     $s1,        $s1,            $t0
    addi    $t0,        $t0,            1
    j       LOOP2
EXIT2:
    j       IF_EXIT1

# t1>=0
IF1b:
    addi    $t0,        $t1,            0
LOOP1:
    beq     $t0,        $zero,          EXIT1
    add     $s1,        $s1,            $t0
    addi    $t0,        $t0,            -1
    j       LOOP1
EXIT1:
    j       IF_EXIT1

IF_EXIT1:
    lui     $t0,        255
    andi    $s1,        $s1,            -1
    or      $t0,        $s1,            $t0
    sw      $t0,        16376($zero)
    j       RE1

CASE1:
    addi    $t0,        $zero,          0
    addi    $v0,        $zero,          0
    jal     CASE1_FUNC
    sw      $t0,        16376($zero)

    j       RE1

CASE2:
    addi    $t0,        $zero,          0
    addi    $v0,        $zero,          0
    jal     CASE2_FUNC

    j       RE1

CASE3:
    addi    $t0,        $zero,          0
    addi    $v0,        $zero,          0
    jal     CASE3_FUNC

    j       RE1

CASE4:
    add     $s1,        $t1,            $t2
    addi    $t3,        $zero,          -128
    slt     $s2,        $s1,            $t3
    addi    $t3,        $zero,          127
    slt     $s3,        $t3,            $s1
    or      $s2,        $s2,            $s3
    lui     $t0,        255
    andi    $s1,        $s1,            -1
    or      $s1,        $s1,            $t0
    sw      $s1,        16376($zero)
    sw      $s2,        16380($zero)
    j       RE1

CASE5:
    sub     $s1,        $t1,            $t2
    addi    $t3,        $zero,          -128
    slt     $s2,        $s1,            $t3
    addi    $t3,        $zero,          127
    slt     $s3,        $t3,            $s1
    or      $s2,        $s2,            $s3
    lui     $t0,        255
    andi    $s1,        $s1,            -1
    or      $s1,        $s1,            $t0
    sw      $s1,        16376($zero)
    sw      $s2,        16380($zero)
    j       RE1


CASE6:
    add     $s1,        $t1,            $t2
    lui     $t0,        255
    andi    $s1,        $s1,            -1
    or      $s1,        $s1,            $t0
    sw      $s1,        16376($zero)
    j       RE1


CASE7:
    add     $s1,        $t1,            $t2

    j       RE3

CASE8:
    ori     $t0,        $t1,            -256
    sw      $t0,        16376($zero)
    sll     $t1,        $t1,            24
    sra     $t1,        $t1,            24
    addi    $t9,        $zero,          0
    addi    $t8,        $zero,          1
WAIT2:
    bne     $t9,        $t8,            WAIT2
    lw      $t2,        16368($zero)
    ori     $t3,        $t2,            -256
    sll     $t2,        $t2,            24
    sra     $t2,        $t2,            24
    sll     $t0,        $t0,            16
    or      $t0,        $t0,            $t3
    sw      $t0,        16376($zero)
    j       RE2

RE1:
    addi    $t9,        $zero,          0
    addi    $t8,        $zero,          1
WAIT3:
    bne     $t9,        $t8,            WAIT3
    j       MAIN

RE2:
    addi    $t9,        $zero,          0
    addi    $t8,        $zero,          1
WAIT4:
    bne     $t9,        $t8,            WAIT4
    lw      $t0,        16372($zero)
    addi    $t0,        $t0,            -4
    beq     $t0,        $zero,          CASE4
    addi    $t0,        $t0,            -1
    beq     $t0,        $zero,          CASE5
    addi    $t0,        $t0,            -1
    beq     $t0,        $zero,          CASE6
    addi    $t0,        $t0,            -1
    beq     $t0,        $zero,          CASE7
    j       MAIN

RE3:
    lui     $t0,        255
    andi    $s2,        $s1,            -1
    srl     $s1,        $s1,            16
    andi    $s1,        $s1,            -1
    or      $s2,        $s2,            $t0
    or      $s1,        $s1,            $t0
    #       s1,         quotient                    ; s2 remainder
D_LOOP:
    sw      $s1,        16376($zero)
    addi    $t9,        $zero,          5
    addi    $t8,        $zero,          2
    addi    $t7,        $zero,          1
D_WAIT1:
    beq     $t9,        $t7,            RE3_EXIT
    bne     $t9,        $t8,            D_WAIT1
    sw      $s2,        16376($zero)
    addi    $t9,        $zero,          5
    addi    $t8,        $zero,          2
    addi    $t7,        $zero,          1
D_WAIT2:
    beq     $t9,        $t7,            RE3_EXIT
    bne     $t9,        $t8,            D_WAIT2
    j       D_LOOP

RE3_EXIT:
    j       MAIN


CASE1_FUNC: 
    bne $t1, $zero, CASE1_FUNC_NEXT
    jr      $ra                                     # return

CASE1_FUNC_NEXT:
                                                    # save ra
    sw      $ra,        0($sp)
    addi    $sp,        $sp,            -4
    addi    $t0,        $t0,            1
                                                    # save t1
    sw      $t1,        0($sp)
    addi    $sp,        $sp,            -4
    addi    $t0,        $t0,            1

    addi    $t1,        $t1,            -1
    jal     CASE1_FUNC
                                                    # load back t1
    addi    $sp,        $sp,            4
    lw      $t1,        0($sp)
    addi    $t0,        $t0,            1
                                                    # load back ra
    addi    $sp,        $sp,            4
    lw      $ra,        0($sp)
    addi    $t0,        $t0,            1

    add     $v0,        $v0,            $t1
    jr      $ra                                     # return



CASE2_FUNC: bne $t1, $zero, CASE2_FUNC_NEXT
    jr      $ra                                     # return

CASE2_FUNC_NEXT:
                                                    # save ra
    sw      $ra,        0($sp)
    addi    $sp,        $sp,            -4
                                                    # save t1
    sw      $t1,        0($sp)
    addi    $sp,        $sp,            -4

# show t1
    sw      $t1,        16376($zero)
    addi    $t9,        $zero,          4
CLK1:
    bne     $t9,        $zero,          CLK1

    addi    $t1,        $t1,            -1
    jal     CASE2_FUNC
                                                    # load back t1
    addi    $sp,        $sp,            4
    lw      $t1,        0($sp)
                                                    # load back ra
    addi    $sp,        $sp,            4
    lw      $ra,        0($sp)

    add     $v0,        $v0,            $t1
    jr      $ra                                     # return



CASE3_FUNC: bne $t1, $zero, CASE3_FUNC_NEXT
    jr      $ra                                     # return

CASE3_FUNC_NEXT:
                                                    # save ra
    sw      $ra,        0($sp)
    addi    $sp,        $sp,            -4
                                                    # save t1
    sw      $t1,        0($sp)
    addi    $sp,        $sp,            -4

    addi    $t1,        $t1,            -1
    jal     CASE3_FUNC
                                                    # load back t1
    addi    $sp,        $sp,            4
    lw      $t1,        0($sp)
                                                    # show t1
    sw      $t1,        16376($zero)
    addi    $t9,        $zero,          4
CLK2:
    bne     $t9,        $zero,          CLK2

# load back ra
    addi    $sp,        $sp,            4
    lw      $ra,        0($sp)

    add     $v0,        $v0,            $t1
    jr      $ra                                     # return