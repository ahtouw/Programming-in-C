# Part 2 Problem 2 - Fibonacci
	.data	# Data declaration section
	a: .word 0
	letb: .word 0
	c: .word 0
	
	.text
main:
	lw $s1, a
	lw $s2, letb
	lw $s3, c
	li $t0, 3 # used for a
	li $t1, 10 # used for letb
	li $t2, 20 # used for c
	move $a0, $t0
	jal Fibonacci # a = Fibonacci(3)
	move $s1, $v0
	move $a0, $t1
	jal Fibonacci # b = Fibonacci(10) 
	move $s2, $v0
	move $a0, $t2
	jal Fibonacci # c = Fibonacci(20)
	move $s3, $v0
	jr $ra

Fibonacci:
	move $t0, $a0 # input put into $t0
	slti $t4, $t0, 1 # n <= 0 (n < 1)
	beq $t4, $zero, ElseIf
	li $s4, 0 # value = 0
	j ret
ElseIf:
	slti $t4, $t0, 2 # n = 1 (n < 2)
	beq $t4, $zero, Else
	li $s4, 1 # value = 1
	j ret
Else:
	addi $t0, $t0, -1 # n -1
	move $a0, $t0
	jal Fibonacci # Fibonacci(n-1)
	move $s5, $v0
	
	addi $t0, $t0, -1 # n -1 -1
	move $a0, $t0
	jal Fibonacci # Fibonacci(n-2)
	move $s6, $v0
	
	add $s4, $s5, $s6 # value = Fibonacci(n-1) + Fibonacci(n-2)

	j ret
ret:
	move $v0, $s4
	jr $ra
	
# END OF PROGRAM