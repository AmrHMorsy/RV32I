Start:
    addi x1, x0, 17
    addi x2, x0, 9
    addi x3, x0, 25
    or x4, x1, x2
    beq x4, x3, L1
    add x3, x1, x2
L1:
    add x5, x3, x2
    sw x5, 12(x0)
    lw x6, 12(x0)
    and x7, x6, x1
    sub x8, x1, x2
    add x0, x1, x2
    add x9, x0, x1

PreTest:
    addi x1, x1, -17
    addi x2, x2, -9
    addi x3, x3, -25
    addi x4, x4, -25
    addi x5, x5, -34
    addi x6, x6, -34
    addi x8, x8, -8
    addi x9, x9, -17

Test:
    bne x1, x0, Fail
    bne x2, x0, Fail
    bne x3, x0, Fail
    bne x4, x0, Fail
    bne x5, x0, Fail
    bne x6, x0, Fail
    bne x8, x0, Fail
    bne x9, x0, Fail

Pass:
    addi x10, x0, 1
    ecall

Fail:
    addi x10, x0, 0
