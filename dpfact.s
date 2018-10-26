# Mike Black -- 4/20/14
# dpfact.s -- returns the factorial of any given integer
# Now in Science Fiction, Double Precision!

main: 
        la      $a0, welcome	# Print a welcome message 
        li      $v0, 4
        syscall

dialogue:	
	la 	$a0, nreq	# "Request a value for n"	
	li	$v0, 4
	syscall

	li	$v0, 5		# Read value of n 
	syscall			

	move 	$a0, $v0	# save the value into $a0

	blt	$a0, $zero, exit# if n < 0, exit program

	li	$v0, 1		# Print the value of n
	syscall

	addi	$sp, $sp, -4	# push n onto the stack
	sw	$a0, 0($sp)

	la	$a0, preans	# Print "! is "
	li	$v0, 4
	syscall

	lw	$a0, 0($sp)	# restore n and pop the stack
	addi	$sp, $sp, 4

	jal	dpfact		# call the "dpfact" procedure
	
	mov.d $f12, $f0	# copy the answer to $a0

	li	$v0, 3		# print $a0
	syscall

	la	$a0, newline	# print a newline
	li	$v0, 4
	syscall

	j	dialogue

dpfact:	li	$t0, 1		# initialize product to 1.0
	mtc1	$t0, $f0
	cvt.d.w	$f0, $f0

again:	slti	$t0, $a0, 2	# test for n < 2
	bne	$t0, $zero,done	# if n < 2, return

	mtc1	$a0, $f2	# move n to floating register
	cvt.d.w	$f2, $f2	# and convert to double precision

	mul.d	$f0, $f0, $f2	# multiply product by n
	
	addi	$a0, $a0, -1	# decrease n
	j	again		# and loop

done:	jr	$ra		# return to calling routine

exit:
	la	$a0, exitmsg	# load exit message
	li	$v0, 4	
	syscall

	li	$v0, 10         # exit from the program
      	syscall
       
	 	.data
welcome: 	.asciiz "Welcome to the factorial tester!\n"
nreq:    	.asciiz "Enter a value for n (or a negative value to exit):\n"
preans:		.asciiz "! is "
exitmsg:	.asciiz "Come back soon!\n"
newline:	.asciiz "\n"


 
