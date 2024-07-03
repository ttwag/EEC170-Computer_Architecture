.data
hello: .string "Hello World!\n"
we_have: .string "We have: "
average: .string "Their Average is: "
line_break: .string "\n"
A:     .word 200
B:     .word 40
C:     .word 100
D:     .word -20
E:     .word 30
num:   .word 5


.text
.globl main
main:
    #Greet the user
    la a1, hello
    li a0, 4
    ecall

    #Indicate we have
    la a1, we_have
    li a0, 4
    ecall

    la a1, line_break
    li a0, 4
    ecall

    #List the 5 numbers
    lw a1, A
    li a0, 1
    ecall

    la a1, line_break
    li a0, 4
    ecall

    lw a1, B
    li a0, 1
    ecall

    la a1, line_break
    li a0, 4
    ecall

    lw a1, C
    li a0, 1
    ecall

    la a1, line_break
    li a0, 4
    ecall

    lw a1, D
    li a0, 1
    ecall

    la a1, line_break
    li a0, 4
    ecall

    lw a1, E
    li a0, 1
    ecall

    la a1, line_break
    li a0, 4
    ecall

    #Indicate their average
    la a1, average
    li a0, 4
    ecall

    #Sum the numbers
    lw a3, A
    lw a4, B
    lw a5, C
    lw a6, D
    lw a7, E
    lw a2, num
    li a1, 0
    add a1, a1, a3
    add a1, a1, a4
    add a1, a1, a5
    add a1, a1, a6
    add a1, a1, a7

    #Divide the by the count
    div a1, a1, a2

    #Print the result
    li a0, 1
    ecall
    
    la a1, line_break
    li a0, 4
    ecall

exit:
    addi a0, zero, 10 
    ecall