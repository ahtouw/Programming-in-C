# Part 5

	.data	# Data declaration section
	a: .word 0
	letb: .word 0
	c: .word 0
	.text
main:	lw $s1, a
	lw $s2, letb
	lw $s3, c
	li $t0, 5 	# i = 5
	li $t1, 10	# j = 10
	move $a0, $t0
	jal AddItUp
	move $s1, $v0
	move $a0, $t1
	jal AddItUp
	move $s2, $v0
	add $s3, $s1, $s2
	jr $ra
	
AddItUp:
	li $v0, 0	# x = 0
	li $t4, 0	# i = 0
loop:
	blt $a0, $t4, ret	# i < n
	addi $v0, $v0, 1	# x = x + 1
	add $v0, $v0, $t4	# x = x + i
	addi $t4, $t4, 1	# i++
	j loop
ret:
	jr $ra			# return x	

# END OF PROGRAM