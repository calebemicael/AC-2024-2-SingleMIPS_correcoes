# MIPS Assembly code to test single-cycle MIPS operations

.data
    num1: .word 10
    num2: .word 20
    result: .word 0

.text
main:
    # Load values from memory
    lw $t0, num1
    lw $t1, num2

    # Test ADD operation
    add $t2, $t0, $t1
    sw $t2, result

    # Test SUB operation
    sub $t3, $t0, $t1
    sw $t3, result

    # Test AND operation
    and $t4, $t0, $t1
    sw $t4, result

    # Test OR operation
    or $t5, $t0, $t1
    sw $t5, result

    # Test SLT operation
    slt $t6, $t0, $t1
    sw $t6, result

    # Test LW operation
    lw $t7, num1
    sw $t7, result

    # Test SW operation
    sw $t7, result

    # Test BEQ operation
    beq $t0, $t1, equal
    j notequal

equal:
    # Code for equal case
    li $v0, 10
    syscall

notequal:
    # Code for not equal case
    li $v0, 10
    syscall