# Part 2 Problem 1 - Temperature Conversion

	.data	# Data declaration section
	prompt: .asciiz "Enter float value of temperature in Fahrenheit: "
	message1: .asciiz "\nCelsius: "
	message2: .asciiz "\nKelvin: "
	kelvFloat: .float 273.15
	five: .float 5.0
	nine: .float 9.0
	threetwo: .float 32.0
	
	.text
main:
	lwc1 $f16, five # $f16 = 5
	lwc2 $f18, nine # $f18 = 32
	div.s $f16, $f16, $f18  # 5/9
	lwc1 $f18, threetwo # $f18 = 32
	
	# Prompt the user for temperature
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get the temperature in Fahrenheit
	li $v0, 6
	syscall
		
	sub.s $f18, $f0, $f18 # Fahrenheit - 32
	mul.s $f12, $f16, $f18 # (Fahrenheit - 32)*5/9
	
	# Display message1
	li $v0, 4
	la $a0, message1
	syscall
	
	# Display calculated Celsius
	li $v0, 2
	syscall
	
	lwc1 $f16, kelvFloat # load KelvFloat
	add.s $f12, $f16, $f12 # add celsius to Kelvin constant

	# Display message2
	li $v0, 4
	la $a0, message1
	
	# Display calculated Kelvin
	li $v0, 2
	syscall
	

	jr $ra			
# END OF PROGRAM