.data
    numbers: .word 10, 20, 30, 40    
    result:  .word 0  

.text
.globl main
main:
    
    la $s0, numbers
    
    
    lw $t0, 0($s0)    
    lw $t1, 4($s0)    
    
    
    add $t2, $t0, $t1    
    
    
    addi $t3, $t2, 5    
    
   
    la $s1, result
    sw $t3, 0($s1)    
    
    
    addi $t4, $zero, 0
    
    
    beq $t0, $t1, equal    
    beq $zero, $zero, exit 
    
equal:
    addi $t4, $zero, 1 
    
exit:
    li $v0, 10
    syscall