Write a program (question2.asm) that will receive a series of positive integers to be added,
separated by the ‘+’ operation. Compute the sum of these values. Assume that the input sum has
no whitespace.

.text

main:
	la $a0, prompt
	li $v0, 4
	syscall
	
	la $a0, space	
	li $a1, 1024
	li $v0, 8
	syscall
	
	la $a0, result
	li $v0, 4
	syscall
	
	li $s0, 0
	li $t5, 0
	li $t4,0
	lb $t2,addition
	lb $t7,next
 
	
loop:
	lb $t0, space($t4)
	
	beq $t0, $t2, multiply
	beq $t0,$t7,rsvt0
	addi $t4,$t4,1
	
	j loop

multiply:
	
	
	lb $t0, space($t5)
	add $t1,$t0,-48
	beq $t4,1,single
	
	addi $t4, $t4,-1
	bgt $t5,0, update 
	
convert:
	mul $t1,$t1,10
	add $t4,$t4,-1
	beqz $t4, store
	j convert
	
store:
	
	add $s0, $t1,$s0
	addi $t5,$t5,1
	move $t4, $t5
	j loop
	
store2:
	add $s0, $t1,$s0
	add $s1 ,$s1,$s0
	li $s0,0
	addi $t5,$t5,2
	move $t4, $t5
	beq $t8,$t7,end
	j loop
update:

	ble $t4, $t5, store2
	sub $t4, $t4, $t5
	j convert
	
 rsvt0:
 	move $t8, $t0
 	j multiply
 	
 single:
 	j store2
end:
	move $a0, $s1
	li $v0,1
	syscall
	
	li $v0, 10
	syscall

.data
prompt: .asciiz "Enter a sum:\n"
space: .space 1024
result: .asciiz "The value is:\n"
addition: .byte '+'
next: .asciiz "\n"