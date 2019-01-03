# Part 4
.data

arrayA: .word 0:5
arrayB:	.word 1, 2, 4, 8, 16 

size: .word 5
.text
main: 	la $a0, arrayA		# base address of array
	la $a1, arrayB
	lw  $a2, size 		# array size
	add $t0, $zero, $zero 	# i = 0
while1:	slt $t1, $t0, $a2 	# i < 5
	beq $t1, $zero, done
	sll $t2, $t0, 2		# $t2= i*4
	add $s1, $a0, $t2	# $s1 -> a[i]
	add $s2, $a1, $t2	# $s2 -> b[i]
	lw $t3, 0($s2)		# $t3 = b[i]
	addi $t4, $t3, -1	# b[i] - 1
	sw $t4, 0($s1) 		# a[i] = b[i] - 1
	addi $t0, $t0, 1	# i++
	j while1
done:	addi $t0, $t0, -1	# i--
	addi $s5, $zero, -1	# boundary for while2 index
while2: slt $t1, $s5, $t0	# i >= 0
	beq $t1, $zero, finish
	sll $t2, $t0, 2		# $t2 = i*4
	add $s1, $a0, $t2	# $s1 -> a[i]
	add $s2, $a1, $t2	# $s2 -> b[i]
	lw $t3, 0($s2)		# $t3 = b[i]
	lw $t5, 0($s1)		# $t5 = a[i]
	add $t7, $t3, $t5	# a[i] + b[i]
	sll $t6, $t7, 1		# (a[i]+b[i])*2
	addi $t0, $t0, -1	# i--
	j while2
finish:
	li  $v0, 10 	# call code for terminate
	syscall 		# system call
.end main