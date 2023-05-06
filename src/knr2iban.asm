	.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
    add $t0 $a0 $zero
    add $t1 $a1 $zero
    add $t2 $a2 $zero
    la $t5 'D' 
    sb $t5 ($t0)
    la $t5 'E'
    sb $t5 1($t0)
    la $t5 '0'
    sb $t5 2($t0)
    la $t5 '0'
    sb $t5 3($t0)
    
    li $t3 8
    
    blzload:
    lb $t4 ($t1)
    sb $t4,4($t0)
    addi $t1 $t1 1
    addi $t0 $t0 1
    subi $t3 $t3 1
    bnez $t3 blzload
    
    li $t3 10
    
    knrload:
    lb $t4 ($t2)
    sb $t4,4($t0)
    addi $t2 $t2 1
    addi $t0 $t0 1
    subi $t3 $t3 1
    bnez $t3 knrload
    addi $s0 $a0 0
    addi $s1 $a1 0
    addi $s2 $a2 0
    move $a3,$ra
    jal validate_checksum
    move $ra $a3
    addi $a0 $s0 0
    addi $a1 $s1 0
    addi $a2 $s2 0
    
        li $t3 98
    sub $v0 $t3 $v0    
    li $t3 10
    div $t7 $v0 $t3
    rem $t8 $v0 $t3
    addi $t7 $t7 48
    addi $t8 $t8 48
    sb $t7 2($a0)
    sb $t8 3($a0)         
    
	# TODO
	jr	$ra
