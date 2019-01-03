# Part 3
.data	# Data declaration section
	Z: .word 2 # Z = 2
	i: .word 0 # i
.text

main:		# Start of code section
	lw $s0, i
	lw $v0, Z # loading words into registers

while1:	slti $t2, $s0, 21 # $t2=1 if i < 21
	beq $t2, $zero, while2 # Exit while1
	addi $v0, $v0, 1 # Z++
	addi $s0, $s0, 2 # i+2
	j while1
while2: slti $t2, $v0, 101 # $t2=1 if Z < 101
	beq $t2, $zero, while3 # Exit while2
	addi $v0, $v0, 1 # Z++
	j while2
while3:	slt $t2, $zero, $s0 # $t2=1 if i > 0
	beq $t2, $zero, done # Exit while3
	addi $v0, $v0, -1 # Z--
	addi $s0, $s0, -1 # i--
	j while3
done:	move $a0, $v0
	li $v0, 1	# system call code for print_int
	syscall
.end main
# END OF PROGRAM