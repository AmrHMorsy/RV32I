Start:

    lui x1, 172
    auipc x2, 12
    add x3, x1, x2
    srli x4, x3, 4
    addi x5, x0, 10
    and x6, x1, x2
    slli x7, x6, 2
    sw x7, 0(x0)
    lw x8, 0(x0)
    beq x7, x8, A
    addi x7, x7, 10
    addi x8, x8, 20

A:
    addi x10, x0, 2
    addi x11, x0, -60
    or x9, x2, x8
    sll x12, x9, x10
    srl x13, x11, x10
    sra x14, x11, x10
    addi x15, x0, 4094
    addi x16, x0, 4090
    bltu x16, x15, B
    addi x15, x15, 30
    addi x16, x16, 60

B:
    sub x17, x16, x15
    blt x17, x0, C
    addi x17, x17, 90

C:
    sb x1, 4(x0)
    lb x18, 4(x0)
    xor x19, x18, x2
    sw x19, 0(x0)
    lw x20, 0(x0)
    andi x21, x20, 3800
    ori x22, x20, 3800
    bge x22, x21, D
    addi x22, x22, 200
    addi x21, x16, 200

D:
    xori x23, x22, 100
    slti x24, x23, 4095
    jal x25, PreTest
    addi x23, x23, 100
    addi x24, x24, 5

PreTest:

    addi x26, x0, 43
    slli x26, x26, 14
    sub x1, x1, x26

    addi x26, x0, 3
    slli x26, x26, 14
    addi x26, x26, 4
    sub x2, x2, x26

    addi x26, x0, 23
    slli x26, x26, 15
    addi x26, x26, 4
    sub x3, x3, x26

    addi x26, x0, 23
    slli x26, x26, 11
    sub x4, x4, x26

    addi x5, x5, -10

    addi x26, x0, 3
    slli x26, x26, 14
    sub x6, x6, x26

    addi x26, x0, 3
    slli x26, x26, 16
    sub x7, x7, x26

    sub x8, x8, x26

    addi x26, x0, 15
    slli x26, x26, 14
    addi x26, x26, 4
    sub x9, x9, x26

    addi x10, x10, -2

    addi x11, x11, 60

    addi x26, x0, 15
    slli x26, x26, 16
    addi x26, x26, 16
    sub x12, x12, x26

    srli x13, x13, 30

    addi x14, x14, 15

    addi x15, x15, 2

    addi x16, x16, 6

    addi x17, x17, 4

    addi x18, x18, 0

    addi x21, x21, -194

    addi x22, x22, 92

    addi x23, x23, 64

    addi x24, x24, -1

    addi x25, x25, -156

    addi x26, x0, 3
    slli x26, x26, 14
    addi x26, x26, 4
    sub x20, x20, x26

    addi x26, x0, 3
    slli x26, x26, 14
    addi x26, x26, 4
    sub x19, x19, x26

Test:

    bne x1, x0, Fail
    bne x2, x0, Fail
    bne x3, x0, Fail
    bne x4, x0, Fail
    bne x5, x0, Fail
    bne x6, x0, Fail
    bne x7, x0, Fail
    bne x8, x0, Fail
    bne x9, x0, Fail
    bne x10, x0, Fail
    bne x11, x0, Fail
    bne x12, x0, Fail
    bne x13, x0, Fail
    bne x14, x0, Fail
    bne x15, x0, Fail
    bne x16, x0, Fail
    bne x17, x0, Fail
    bne x18, x0, Fail
    bne x19, x0, Fail
    bne x20, x0, Fail
    bne x21, x0, Fail
    bne x22, x0, Fail
    bne x23, x0, Fail
    bne x24, x0, Fail
    bne x25, x0, Fail

Pass:

    addi x30, x30, 1
    ecall

Fail:

    addi x30, x30, 0
