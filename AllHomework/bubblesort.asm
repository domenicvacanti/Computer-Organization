.data
array: .word 5,60,2,4,6,8,3,10,-2	#array to be sorted
message: .asciiz "Sorted Array: "	#a print message
size: .word 9	#size of array
.text

main:
la $s7, array   #putting array in s7
li $s0, 0	#setting a counter to 0 to be inc at start of loop
li $s1, 0	#set counter for second loop
li $t3, 0	#print loop counter
lw $t4, size	#length (!!!!!!!IMPORTANT TO CHANGE WHILE TESTING!!!!!!!!!!)
addi $s6, $t4, -1	#length minus one
li $v0, 4,	#print "magic" number 4 (bits?)
la $a0, message	#print message
syscall

loop:
sll $t7, $s1, 2	#multiply s1 by two and put it in t7
add $t7, $s7, $t7	#add the address of array to t7
lw $t0, 0($t7)	#load array[j]
lw $t1, 4($t7)	#load array[j+1]
slt $t2, $t0, $t1	#if t0<t1
bne $t2, $zero, inc	#inc if t2 != 0
sw $t1, 0($t7)	#else swap numbers in the array
sw $t0, 4($t7)

inc:
addi $s1, $s1, 1	#inc t1
sub $s5, $s6, $s0	#sub
bne $s1, $s5, loop	#if s1 (second counter) does not equal length, go back to first loop
addi $s0, $s0, 1	#else inc s0
li $s1, 0		
bne $s0, $s6, loop

print: 	#Used a few articles including https://stackoverflow.com/questions/19748054/reading-and-printing-an-integer-in-mips to help with printing to see values
	#this article helped me with the printing loop https://stackoverflow.com/questions/50184876/printing-from-a-declared-array-in-mips/50185080
	#used this to help print message before numbers https://stackoverflow.com/questions/30416318/mips-printing-string
beq $t3, $t4, end	#if printed all numbers, end
lw $t5, 0($s7)	#load from array
li $v0, 1	#print the array
move $a0, $t5
syscall
li $a0, 32	#print a space
li $v0, 11
syscall
addi $s7, $s7, 4	#inc through the array
addi $t3, $t3, 1	#inc counter
j print

end:
lw $v0, size	#this needs to be set to length of array (to my understanding at least)
syscall