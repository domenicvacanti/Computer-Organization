.data
array: .word 1,2,5,24,56,216
length: .word 6
targetNotIn: .asciiz " was not found"
targetFound: .asciiz " was found"
inputMessage: .asciiz "Input target number: "
.text
.globl main

main:

la $a0, inputMessage
li $v0, 4		#display input message, save input to reg $s0 for target
syscall
li $v0, 5
syscall
la $s0, 0
move $s0, $v0

la $a0, array
lw $a1, 0($s0)		#this is supposed to load the target value, for some reason it isn't, I've looked over it a million times
lw $t8, length

jal BinSearch
addi $a2, $s1, 0
jal output
li $v0, 10

BinSearch:
addi $t1, $zero, 0	#starting position
sub $s3, $t8, 1		#length - 1
move $t2, $s3		#store length - 1 into $t2

loop:
addi $t3, $t1, 1	#add 1 to starting postion
bgt $t3, $t2, endLoop	#if $t3 (starting postion) > len - 1
beq $t3, $t2, endLoop	#if $t3 = len - 1
sub $t4, $t2, $t1	#(len - 1) - starting position
div $t4, $t4, 2		#divide line above by 2
add $t5, $t1, $t4	#middle index
mul $t7, $t5, $s3	#mul middle index by length - 1
add $t6, $a0, $t7	#array[middle index]
lw $t6, 0($t6)		#load value from array[middle index]
bgt $a1, $t6, else	#if target > array[middle] jump else
beq $a1, $t6, else	#if target = array[middle] jump else
add $t2, $zero, $t5	#end = middle if target < array[middle]
j loop

else:
add $t1, $zero, $t5	#start = middle index
j loop

endLoop:
mul $t7, $t1, $s3	#mul middle index by len - 1
add $t6, $a0, $t7	#array[starting position]
lw $t6, 0($t6)		#load the value in array[starting postion]
bne $a1, $t6, notFirst	#if target != first value
addi $s1, $zero, 1
j realEnd

notFirst:
mul $t7, $t2, $s3	#mul start index by len - 1
add $t6, $a0, $t7	#finding index of last value
lw $t6, 0($t6)		#load value from array[last index]
bne $a1, $t6, notLast	#if target != array[last index]
addi $s1, $zero, 1
j realEnd

notLast:
addi $s1, $zero, 0

output:
li $v0, 1
add $a0, $a1, 0		#print target number
syscall
bne $a2, 0, found	#check to see if value was found

notFound:
li $v0, 4
la $a0, targetNotIn
syscall
j outputEnd

found:
li $v0, 4
la $a0, targetFound
syscall

realEnd:

outputEnd:
syscall