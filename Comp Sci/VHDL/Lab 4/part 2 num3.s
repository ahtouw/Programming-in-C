# Part 2 Problem 3 - Using Part 1
	.data	# Data declaration section
	datain_a: .word 0x01234567
	datain_b: .word 0x11223344
	
	.text
main:
	lw $s0, datain_a
	lw $s1, datain_b
	
	add $s2, $s0, $s1 	# add function result
	sub $s3, $s0, $s1 	# sub function result
	addi $s4, $s0, 4321	# addi function result
	and $s5, $s0, $s1 	# and function result
	or $s6, $s0, $s1	# or function result
	sll $s0, $s0, 2		# shift left function result
	srl $s1, $s1, 2		# shift right function result
	
	jr $ra
# END OF PROGRAM