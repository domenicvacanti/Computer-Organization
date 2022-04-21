#found a video on insertion sort, tried to emulate the implementation with the printing statement
#from the bubble sort... cannot seem to get this one to work, wants to be stuck in a loop in the
#print statement

.data
array: .word 5,60,2,4,6,8,3,10,-2	#array to be sorted
message: .asciiz "Sorted Array: "	#a print message
size: .word 9	#size of array
.text

main:
la $a1, array   #putting array in s7
li $s0, 0	#setting a counter for print loop
lw $a0, size	#length (!!!!!!!IMPORTANT TO CHANGE WHILE TESTING!!!!!!!!!!)
addi $s6, $t4, -1	#length minus one
li $v0, 4,	#print "magic" number 4 (bits?)
la $a2, message	#print message
addi $t0, $0, 1	#i = 1

loop:	
beq $t0, $a0, print		#if counter equals length go to print/end
sll $t3, $t0, 2			#multiply counter by 2
add $t3, $t3, $a1		#t3 to hold the object in the array
lw $t3, 0($t3)			#the key of the array is in t3
addi $t1, $t0, -1		#j counter = i - 1
	
loop2:	
slt $t2, $t1, $0			#j < 0, t2 = 0
bne $t2, $0, endloop2		#branch if above line is true
sll $t2, $t1, 2			#multiply t1 by 2 save in t2
add $t6, $t2, $a1		#t6 is address of array a spot j
lw $t4, 0($t6)			#t4 is key for array[j]
slt $t5, $t3, $t4		#if array[i] < array[j]
beq $t5, $0, endloop2		#if not less than endloop2
sw $t4, 4($t6)			#else swap
addi $t1, $t1, -1		#dec j
j loop2				#restart loop 2 for more swaps

endloop2:
addi $t2, $t1, 1			#inc i
sll $t2, $t2, 2			#multiply t2 by 2
add $t2, $t2, $a1		#find next address in array
sw $t3, 0($t2)			#finding the next address of array[j]
addi $t0, $t0, 1
j loop

print: 	#Used a few articles including https://stackoverflow.com/questions/19748054/reading-and-printing-an-integer-in-mips to help with printing to see values
	#this article helped me with the printing loop https://stackoverflow.com/questions/50184876/printing-from-a-declared-array-in-mips/50185080
	#used this to help print message before numbers https://stackoverflow.com/questions/30416318/mips-printing-string
beq $s0, $a0, end	#if printed all numbers, end
lw $t5, 0($a1)	#load from array
li $v0, 1	#print the array
move $a2, $t5
syscall
li $a2, 32	#print a space
li $v0, 11
syscall
addi $a0, $a0, 4	#inc through the array
addi $s0, $s0, 1	#inc counter
j print

end:
lw $v0, size	#this needs to be set to length of array (to my understanding at least)
syscall