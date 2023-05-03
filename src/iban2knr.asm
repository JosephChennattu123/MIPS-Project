	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
addi $a0,$a0,4
add $t1,$zero,$a1
add $t2,$zero,$a2
li $t3 0
	blz:
	lb $t4,($a0)
	addi $a0,$a0,1
	sb $t4,($a1)
	addi $a1,$a1,1	
	addi $t3,$t3,1
	bne $t3,8,blz
	
	knr:
	lb $t4,($a0)	
	addi $a0,$a0,1
	sb $t4,($a2)
	addi $a2,$a2,1
	addi $t3,$t3,1
	bne $t3,18,knr
	
# TODO
	jr	$ra
