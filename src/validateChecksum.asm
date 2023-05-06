	.data
    temp: .space 24
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the remainder

validate_checksum:
    #intial buffer loading
    add $t9 $a0 $zero
    la $t8 temp
    li $t7 18
    lb $t0, 0($t9)
    lb $t1, 1($t9)
    lb $t2, 2($t9)
    lb $t3, 3($t9)
    addi $t9 $t9 4
    #loop to extract all digits and place in space temp
    digitloading:
    lb $t4,($t9)
    sb $t4, ($t8)
    addi $t9 $t9 1
    addi $t8 $t8 1
    subi $t7 $t7 1
    beqz $t7 digitconversion
    b digitloading
    
    digitconversion:
    li $t7 10   
    subi $t0 $t0 55 #converting A to 10,... Z to 35
    div $t0 $t7
    mflo $t5
    mfhi $t6
    addi $t5 $t5 48
    addi $t6 $t6 48
    sb $t5 ($t8)
    addi $t8 $t8 1
    sb $t6 ($t8)
    addi $t8 $t8 1    
    subi $t1 $t1 55
    div $t1 $t7
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
    la $a0 temp
    li $a1 24
    li $a2 97
    move $t4 $ra
    jal modulo_str
    move $ra $t4
    jr $ra                 # return to caller
