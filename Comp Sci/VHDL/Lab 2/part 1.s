# Part 1
	.data	# Data declaration section
	z: .word 0 # Z
	.text

main:		# Start of code section
	li $t0, 15 # A
	li $t1, 10 # B
	li $t2, 5 # C
	li $t3, 2 # D
	li $t4, 18 #E
	li $t5, -3 # F
	lw $t6, z  # Z
	
	sub $s1, $t0, $t1 # A-B
	mul $s2, $t2, $t3 # C*D
	sub $s3, $t4, $t5 # E-F
	divu $s4, $t0, $t2 # A/C
	
	add $s5, $s1, $s2 # (A-B) + (C*D)
	sub $s6, $s3, $s4 # (E-F) - (A/C)
	add $v0, $s5, $s6 # Z computed
	
	move $a0, $v0
	li $v0, 1	# system call code for print_int
	syscall	
.end main

# END OF PROGRAM