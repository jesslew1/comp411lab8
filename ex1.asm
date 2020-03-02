
.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:     .space 400  		# int CC[100]
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm

      # You may add more variables here if you need to



.text

main:


#------- INSERT YOUR CODE HERE for main -------
#
#  Best is to convert the C program line by line
#    into its assembly equivalent.  Carefully review
#    the coding templates near the end of Lecture 8.
#
#
#  1.  First, read m (the matrices will then be size mxm).
  sw    $0,m($0)		#set m to 0
  add 	$8,$0,$0		# $8  to r (x)
  add 	$9,$0,$0		# $9  to c (y)
  add 	$1,$0,$0		# $1  to z
  
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  add	$7, $0, $v0		# copy the "m" into $7
  sw	$7, m($0)
  
  add	$10, $0, $0		#$10 is going to be the sum register
  
for_outer_A:
  beqz	$9, for_inner_A
  addi	$8, $8, 1
  beq	$8, $7, reset1
  add	$9, $0, $0		#set c to 0
  j	for_inner_A
  
for_inner_A:
  beq	$9, $7, for_outer_A
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  mult	$7, $8			#multiply m * r
  mflo	$4
  add	$4, $4, $9		#add c to M *r
  sll	$4, $4, 2		#offset
  sw	$v0, AA($4)		#store
  addi	$9, $9, 1
  j	for_inner_A
  
reset1:
  add 	$8,$0,$0		# r to 0
  add 	$9,$0,$0		# c to 0
  j	forrB
  
for_outer_B: 
  beqz	$9, for_inner_B
  addi	$8, $8, 1
  beq	$8, $7, reset2 
  add	$9, $0, $0		#set c to 0
  j	for_inner_B
 
for_inner_B:
  beq	$9, $7, for_outer_B
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  mult	$7, $8			#multiply m * r
  mflo	$4
  add	$4, $4, $9		#add c to M *r
  sll	$4, $4, 2		#offset
  sw	$v0, BB($4)		#store
  addi	$9, $9, 1
  j	for_inner_B

reset2:
  add 	$8,$0,$0		# r to 0
  add 	$9,$0,$0		# c to 0
  j	loop1

loop1:
  beqz	$9, loop2
  addi	$8, $8, 1
  beq	$8, $7, reset3
  add	$9, $0, $0		#set 9 to zero
  add	$10, $0, $0		#set sum to zero
  add	$1, $0, $0		#set z to zero
  j	loop2
  
loop2:
  beqz  $1, loop3
  addi	$9, $9, 1
  beq	$9, $7, loop1
  add	$10, $0, $0		#set sum to zero
  add	$1, $0, $0		#set z to zero
  j	loop3
  
loop3:
  beq	$1, $7, loop2		
  mult	$7, $8
  mflo 	$11
  add	$11, $11, $1
  sll	$13, $11, 2
  lw	$13, AA($13)
  mult	$7, $1
  mflo 	$11
  add	$11, $11, $9
  sll	$14, $11, 2
  lw	$14, BB($14)
  mult	$13, $14
  mflo	$15
  add	$10, $10, $15	#set sum to sum + AA[m*x+z]*BB[m*z+y];
  mult	$7, $8
  mflo 	$11
  add	$11, $11, $9
  sll	$12, $11, 2
  sw	$10, CC($12)
  addi	$1, $1, 1
  j	loop3
  
 reset3:
  add 	$8,$0,$0		# r to 0
  add 	$9,$0,$0		# c to 0
  j	printr	
  
printr:
  beqz	$9, printc  
  addi	$8, $8, 1
  beq	$8, $7, exit					# Print a newline
  addi 	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, newline 			# address of areaIs string is in $a0
  syscall           			# print the string
  
  add	$9, $0, $0		#set c to 0
  j	printc
  
printc:
  beq	$9, $7, printr			        
  mult	$7, $8			#multiply m * r
  mflo	$4
  add	$4, $4, $9		#add c to M *r
  sll	$4, $4, 2
  lw	$5, CC($4)
  addi 	$v0, $0, 1  		# system call 1 is for printing an integer
  add 	$a0, $0, $5 		# bring the area value from $10 into $a0
  syscall           		# print the integer
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, space 		# address of areaIs string is in $a0
  syscall           		# print the string
  addi	$9, $9, 1
  j	printc	
	
#BB will look the same	
#CC will have outer, inner, middle loop

#  2.  Next, read matrix A followed by matrix B.
#  3.  Compute matrix product.  You will need triple-nested loops for this.
#  4.  Print the result, one row per line, with one (or more) space(s) between
#      values within a row.
#  5.  Exit.
#
#------------ END CODE ---------------


exit:                     # this is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#------- If you decide to make other functions, place their code here -------
#
#  You do not have to use helper methods, but you may if you would like to.
#  If you do use them, be sure to do all the proper stack management.
#  For this exercise though, it is easy enough to write all your code
#  within main.
#
#------------ END CODE ---------------
