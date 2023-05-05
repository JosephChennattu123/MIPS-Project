	.data
    temp: .space 24
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
    # move the first four characters to the end of the IBAN
    add $t9 $a0 $zero
    la $t8 temp
    li $t7 18
    lb $t0, 0($a0)
    lb $t1, 1($a0)
    lb $t2, 2($a0)
    lb $t3, 3($a0)
    addi $t9 $t9 4
    digitloading:
    lb $t4,($t9)
    sb $t4, ($t8)
    addi $t9 $t9 1
    addi $t8 $t8 1
    subi $t7 $t7 1
    beqz $t7 digitloading
    li $t4 10   
    subi $t0 $t0 55
    div $t0 $t4
    mflo $t5
    mfhi $t6
    addi $t5 $t5 48
    addi $t6 $t6 48
    sb $t5 ($t8)
    addi $t8 $t8 1
    sb $t6 ($t8)
    addi $t8 $t8 1    
    subi $t1 $t1 55
    div $t1 $t4
    mflo $t5
    mfhi $t6
    addi $t5 $t5 48
    addi $t6 $t6 48
     sb $t5 ($t8)
    addi $t8 $t8 1
     sb $t6 ($t8)
    addi $t8 $t8 1
    sb $t2 ($t8)
    addi $t8 $t8 1
    sb $t3 ($t8)
    subi $a0 $t8 23
    li $a1 24
    li $a2 97
    jal modulo_str
    
    # restore registers and return
    jr	$ra
