	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
add $t1,$zero,$a1
add $t2,$zero,$a2
li $t3 0
	blz:
	lb $t4,4($a0)
	addi $a0,$a0,1
	sb $t4,($t1)
	addi $t1,$t1,1	
	addi $t3,$t3,1
	bne $t3,8,blz
	
	knr:
	lb $t4,4($a0)	
	addi $a0,$a0,1
	sb $t4,($t2)
	addi $t2,$t2,1
	addi $t3,$t3,1
	bne $t3,18,knr

	move $a1,$t1
	move $a2,$t2
	
# TODO
	jr	$ra
