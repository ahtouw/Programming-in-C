# Part 2

.data	# Data declaration section
	varA: .word 10 # A = 10
	varB: .word 15 # B = 15
	varC: .word 6 # C = 6
	varZ: .word 0 # Z = 0
.text

main:		# Start of code section
	lw $s4, varA
	lw $s5, varB
	lw $s6, varC
	lw $s7, varZ # loading words into registers
	
	li $t0, 5 # Comparison for 'if'
	slt $s0, $s4, $s5 # A < B
	slt $t1, $t0, $s6 # 5 < C
	and $s1, $s0, $t1 # A < B && 5 < C
	beq $s1, $zero, ElseIf # Jump to ElseIf
	addi $s7, $zero, 1 # Z = 1
	j Switch
ElseIf: addi $s6, $s6, 1 # C + 1
	addi $t0, $t0, 2 # Comparison for 'else if'
	slt $t2, $s6, $t0 # t2 is 0 if (C+1) == 7
	slt $t2, $t0, $s6 # t2 is 0 if (C+1) == 7
	not $t2, $t2 # t2 is 1 if (C+1) == 7
	slt $s0, $s5, $s4 # B < A
	or $s2, $s0, $t2 # B < A || (C+1 == 7)
	beq $s2, $zero, Else # Jump to Else
	addi $s7, $zero, 2 # Z = 2
	j Switch
Else:	addi $t7, $zero, 3 # Z = 3
	j Switch
Switch: slti $t3, $s7, 1 # test Z < 1
	bne $t3, $zero, def
	slti $t3, $s7, 3 # test Z < 4
	beq $t3, $zero, def
	sll $s7, $s7, 2
	add $t4, $s7, $gp
	lw $t4, 1064($t4)
	jr $t4
c1:	addi $s7, $zero, -1 # Z = -1
	j done
c2:	addi $s7, $zero, -2 # Z = -2
	j done
c3:	addi $s7, $zero, -3 # Z = -3
	j done
def:	addi $s7, $zero, 0 # Z = 0
	j done
done:	move $a0, $s7
	li $v0, 1	# system call code for print_int
	syscall	
.end main
# END OF PROGRAM