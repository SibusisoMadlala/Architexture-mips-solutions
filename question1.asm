Write a program (question1.asm) that will receive the number of lines of input, n, followed by n
lines of text and will then print them in reverse order. Each line should be stored in memory

.text

main:
	la $a0, lines
	li $v0, 4
	syscall 
	
	li $v0, 5
	syscall 
	
	move $t0,$v0
	
	la $a0, word1
	li $a1, 100
	li $v0, 8
	syscall
	
	lb $t3,zerro
	li $t1,0
	li $t4,0
	lb $t6, next
	lb $t9, colon 
	
	addi $t0,$t0,-1
	
floop:
	 
	jal inputlength
	syscall
	addi $t0,$t0,-1
	beqz $t0, spacelength
	
	j floop
	
spacelength:
	
	lb $t2, word1($t1)
	addi $t1,$t1,1
	beq $t2, $t3, val
	
	j spacelength
val:
	la $a0, values
	li $v0, 4
	syscall
sett1: 
	
	addi $t1, $t1, -2
	addi $t8,$t1,0

wordlength:

	addi $t8,$t8,-1
	lb $t5, word1($t8) 
	beq $t5,$t6,sett0
	addi $t4,$t4,1
	j wordlength
	

sett0:
	blt $t1,$t4,sett7
	sub $t1, $t1,$t4
	addi $t7,$t1,0

print:
	lb $a0, word1($t7) 
	li $v0, 11
	syscall
	
	addi $t7, $t7,1
	beq $a0,$t6,reset
	beq $a0,$t3,end
	j print

reset:
	li $t4,0
	li $t8,0
	li $t7,0
	
	j sett1
	
inputlength:

	lb $s0, word1($s1)
	beq $s0,$t6,seta0
	addi $s1,$s1,1
	addi $s2,$s2,1
	j inputlength
	
seta0:
	addi $s1, $s1,1
	addi $s2, $s2,1
	add $a0,$a0,$s2
	li $s2,0
	jr $ra

sett7:
	li $t7,0
printlast:
	
	lb $a0, word1($t7) 
	li $v0, 11
	syscall
	
	addi $t7, $t7,1
	addi $t4,$t4,-1
	beqz $t4,end
	j printlast
end:

	li $v0, 10
	syscall

.data
lines: .asciiz "Enter n, followed by n lines of text:\n"
values: .asciiz "The values are:\n"
word1: .space 1024
word2: .space 1024
zerro: .asciiz "\0"
next: .asciiz "\n"
colon: .byte ':'
