	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	add $t0 $a0 $0
	add $t1 $a1 $0
	add $t2 $a2 $0
	add $t5 $0 $0
	li $t6 0
 	icried:
 	beq  $t1 $t6 end
 	lb $t3,($t0)
 	addi $t0 $t0 1
 	subi $t1 $t1 1
 	sub $t3 $t3 48
 	mul $t5 $t5 10
 	add $t5 $t5 $t3
 	div $t5,$t2
 	mfhi $t5
 	b icried
 		
 		
 			
	
	# TODO
	end:
	move $v0,$t5
	jr	$ra
