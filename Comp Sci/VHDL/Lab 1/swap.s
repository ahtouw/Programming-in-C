# Lab 1

	.data	# Data declaration section

zing:	.word	0, 1, 2, 3, 4, 5, 6, 7
num1:	.asciiz	"zing[4] now has "
num2:	.asciiz	"\nzing[5] now has "

	.text

main:	la	$a0,zing
	addi	$a1,$zero,4
	jal	swap
	li	$v0,4		#system call for printing a string
	la	$a0,num1
	syscall
	li	$v0,1		#system call for printing an integer in ASCII
	lw	$a0,0($t1)
	syscall
	li	$v0,4		#system call for printing a string
	la	$a0,num2
	syscall
	li	$v0,1		#system call for printing an integer in ASCII
	lw	$a0,4($t1)
	syscall
	li	$v0,11		#system call for printing a character in ASCII
	li	$a0,10
	syscall
	li	$v0,10		#system call for an exit
	syscall
	

swap:	sll	$t1,$a1, 2	#reg $t1=k*4
	add	$t1,$a0,$t1	#reg $t1=address of zing[k]
				
	lw	$t0,0($t1)	#reg $t0=zing[k]
	lw	$t2,4($t1)	#reg $t2=zing[k+1]
				
	sw	$t2,0($t1)	
	sw	$t0,4($t1)	
	addi $t0, $zero, 5
	addi $t1, $t0, 2
	add $t2, $t1, $t0
	jr	$ra		

# END OF PROGRAM