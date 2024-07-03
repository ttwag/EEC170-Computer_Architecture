.data

##  Your name and ID etc go here
## Name: Tao Wang

# Lab Report:
# For a high-level description of the RISC-V code, please look at the C code below.
# The while loop iterates 15 times, and the loop counts the number of 1 in the input hex.
# To count the number of 1, we AND the least significant bit with 1 and store this number in int bit then bit shift the input hex right and bit shift the int mask left in every iteration.
# After 15 iteration, we will count the number of 1 while the mask is set to 0x8000.
# Depending on the input parity, we may or may not need to modify the input hex. If the parity is even and we count an odd number of 1, 
# or if the parity is odd and we count even number of 1, then we need to add another 1 to bit 16.
# This is implemented by the XNOR condition, if we XNOR to 1, then add 1 to bit 16 by OR the input hex with the mask 0x8000 and return the output. If
# we XNOR to 0, then just return the input hex.



# C code 
# Time Complexity: O(1), always loop 15 times
# Space Complexity: O(1)
#int parity(int num, int i) {
#    int ans = num, k = 1, bit = 0, mask = 1;
#    while (k <= 15) {
#        bit += num & 1;
#        num = num >> 1;
#        mask = mask << 1;
#        k++;
#    }
##   if (!(bit % 2 == 0 ^ i == 0)) {
#        ans | mask
#    }
#    return ans;
#}

parity1: .string "With Even Parity\n"
parity0: .string "With ODD Parity \n"
msg1: .string "Original Number is "
msg2: .string "   and the Parity Corrected Number is  "

newln:    .string "\n"

# X is the input.  You can change it and verify that your program works correctly for different values of X

X:  .word  0x1


# .text means the rest of the stuff is a program or instructions to the computer
.text
.globl main                         # make main available to all project files

main:                               # There should be one main

# Don't Touch this (BEGIN)
# Code to print message parity1
la a1, parity1
    li a0, 4
    ecall 
# Code to print Original Number is 
la a1, msg1
    li a0, 4
    ecall 
# Code to print the original number. The syscall code 34 in register a0, results in printing the number in hexadecimal notation. 
    lw a1, X
    li a0, 34
    ecall 
# Code to print msg2 is 
la a1, msg2
    li a0, 4
    ecall 
# Don't touch this (END)

###    Pass X in a1,  Pass P in a2, call the function parity and make sure parity returns result in a1
### BEGIN YOUR CODE  (Your code will be 3 instructions.)
    lw a1, X
    li a2, 1
    jal x1, parity
    ecall


#### END YOUR CODE  

# Don't Touch this (BEGIN)
    # print result
    li a0, 34
    ecall

# this is a system call to  print a newline.  
   la a1, newln
    li a0, 4
    ecall

# Don't touch this (END)

## Now we will repeat the same for ODD parity.


# Don't Touch this (BEGIN)
# Code to print message parity0
la a1, parity0
    li a0, 4
    ecall 
# Code to print Original Number is 
la a1, msg1
    li a0, 4
    ecall 
# Code to pring the original number. The syscall code 34 in register a0, results in printing the number in hexadecimal notation. 
    lw a1, X
    li a0, 34
    ecall 
# Code to print msg2 is 
la a1, msg2
    li a0, 4
    ecall 

# Don't touch this (END)

###    Pass X in a1,  Pass P in a2, call the function parity and make sure parity returns result in a1
### BEGIN YOUR CODE  (Your code will be 3 instructions.)
    lw a1, X
    li a2, 0
    jal x1, parity
    ecall


####  END YOUR CODE

# Don't Touch this (BEGIN)
    # print result
    li a0, 34
    ecall

# this is a system call to  print a newline.  
   la a1, newln
   li a0, 4
    ecall

    j exit            # We are done exit.
# Don't touch this (END)



### BEGIN YOUR CODE  (Make sure the result is in register a1)

## Uses register a3-a7, and x28
parity:
    or a3, a1, x0 #Copy hex input from a1 to a3, initializes num
    li a4, 0   #Load 0 to a4, initializes bit
    li a5, 1   #Loop iterator, initializes k
    li a6, 1   #Mask
    li a7, 0xF  #the number 15 in loop condition
    # while (k <= 15)
    loop:
        bgt a5, a7, greaterthan
        andi x28, a3, 1  #B = num & 1
        add a4, a4, x28  #bit += B
        srli a3, a3, 1  #num = num >> 1
        slli a6, a6, 1  #mask = mask << 1
        addi a5, a5, 1
        beq x0, x0, loop
    greaterthan:
        li a5, 2 
        #bit % 2 != 0
        rem x28, a4, a5 
        beq x28, x0, even
        li x28, 1
        even:
        ## A = (bit % 2 != 0 ^ parity == 0)
        xori a2, a2, 1        #Negate the parity
        xor x28, x28, a2
        ## if (A != 0) 
        beqz x28, ans
        or a1, a1, a6       #Or the mask to the input stored in a1
        ans:
        jr x1               # return from procedure via return address in x1

#int parity(int num, int i) {
#    int ans = num, k = 1, bit = 0, mask = 1;
#    while (k <= 15) {
#        bit += num & 1;
#        num = num >> 1;
#        mask = mask << 1;
#        k++;
#    }
##   if (!(bit % 2 == 0 ^ i == 0)) {
#        ans | mask
#    }
#    return ans;
#}

####  END YOUR CODE


# Don't modify anything below this.  It is just to exit the program gracefully.

   la a1, newln
    li a0, 4
    ecall

exit:
    addi a0, zero, 10 
    ecall