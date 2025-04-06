.text

	addi $t0, $zero, 10  # $t0 = 10
    	addi $t1, $zero, 5   # $t1 = 5
    	
    	sw $t0, 0($zero)
    	
    	lw $t2, 0($zero)
    	
    	add $t3, $t0, $t1 # $t3 = 10 + 5 = 15
    	
    	sub $t4, $t0, $t1 # $t4 = 10 - 5 = 5
    	
    	beq $t1, $t4, fim 
    	
    	jump:
    		addi $t5, $zero, 42
    		
    	fim:
    		and $t6, $t0, $t1
    		or $t7, $t0, $t1
    		slt $t8, $t0, $1
    		j jump
    	
    	