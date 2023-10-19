.data

# we are declaring a bunch of strings, using the .string directive

welcome:     .string "Welcome to EEC 170, Fall 2023 \n"
quot:    .string "Quotient = "
remain:   .string "Remainder = "
dividend: .string "Dividend =  "
divisor:  .string "Divisor =  "
newln:    .string "\n"
thank:    .string "Thanks. We are done.\n \n \n"

# we are declaring variables X and Y as integers, that is what .word means

X:  .word  130       #dividend   
Y:  .word  -15       #divisor    

# .text means the rest of the stuff is a program or instructions to the computer
.text
.globl main                         # make main available to all project files

main:                               # There should be one main

# In assembly language to print something like an string or integer you have to use a system call, basically
# a request to the operating system (much like printf in C)
# In RISC-V Assembly, you pass the pointer to the string or the value to be printed in register a1 or x11 
# and a code, what to print - whether it is integer, string, character, etc. in register a0 or x10
# This is followed by the command  ecall.

# Here are a bunch of examples
# the following 3 lines, print the message "Welcome to EEC 170, Fall 2023" via a system call
# here the pointer to the string welcome is passed in register a1 via a command "la" (we'll learn more about these commands or instructions in Chapter 2)
# and the code 4 in register a0, which is the request to print a integer.
    la a1, welcome
    li a0, 4
    ecall

# Similarly next 3 lines, print "Dividend ="  via  system call. 
	la a1, dividend
    li a0, 4
    ecall

# Next 3 lines, print the value X, which happens to be 130. Note the value X is loaded into register a1 with the lw command 
#register a0 has the value 1, which means we want to print an integer.
    lw a1, X
    li a0, 1
    ecall 
    
    la a1, newln
    li a0, 4
    ecall
    
    la a1, divisor
    li a0, 4
    ecall
    lw a1, Y
    li a0, 1
    ecall 
    
    la a1, newln
    li a0, 4
    ecall
    
    la a1, quot
    li a0, 4
    ecall

# Ok, we are done with printing stuff. Now let's do some computation.
# We want to compute X/Y and print the quotient and remainder.  div and rem are the instructions to compute quotient and remainder
# and the arguments are in register a3 and a4.   Notice that since the result is in a1, all we need to do is to put the correct
# code in the register a0 to print an integer.

    lw a3, X
    lw a4, Y
    div a1, a3, a4
    li a0, 1
    ecall
    
    la a1, newln
    li a0, 4
    ecall
    
    la a1, remain
    li a0, 4
    ecall
	rem a1, a3, a4
    li a0, 1
    ecall
    
    la a1, newln
    li a0, 4
    ecall
    
    
    la a1, thank
    li a0, 4
    ecall

    add x5, x0, x0
    li x6, 0xffffffff
    li x7, 0x3f
    add x28, x7, x0
    slli x7, x7, 10
    and x7, x7, x5
    slli x28, x28, 26
    not x28, x28
    and x6, x6, x28
    slli x7, x7, 15
    or x6, x6, x7

    add a1, x6, x0
    li a0, 1
    ecall

    la a1, newln
    li a0, 4
    ecall
# this is a system call to exit the program gracefully. The code is 10 in register a0. Nothing is required in a1.
exit:
    addi a0, zero, 10 
    ecall