.text
    .globl main

main:
    # Initialize registers with hardcoded values
    addi $t0, $zero, 12     # $t0 = 12
    addi $t1, $zero, 7      # $t1 = 7
    addi $t2, $zero, 5      # $t2 = 5
    addi $t3, $zero, 3      # $t3 = 3

    # Perform arithmetic operations
    add $t4, $t0, $t1      # $t4 = $t0 + $t1 (12 + 7 = 19)
    sub $t5, $t4, $t2      # $t5 = $t4 - $t2 (19 - 5 = 14)
    addi $t6, $t5, -2      # $t6 = $t5 - 2 (14 - 2 = 12)

    # Perform logical operations
    and $t7, $t0, $t1      # $t7 = $t0 AND $t1 (12 AND 7 = 4)
    or $t8, $t2, $t3       # $t8 = $t2 OR $t3 (5 OR 3 = 7)

    # Conditional branch (beq)
    addi $t9, $zero, 7     # $t9 = 7
    beq $t8, $t9, branch_target  # If $t8 == $t9, jump to branch_target

    # This block will be skipped if the branch is taken
    addi $t6, $t6, 10      # $t6 = $t6 + 10 (12 + 10 = 22)

branch_target:
    # Unconditional jump (j)
    j end_program           # Jump to end_program

    # This block will never be executed
    addi $t6, $t6, 100     # $t6 = $t6 + 100 (unreachable code)

end_program: