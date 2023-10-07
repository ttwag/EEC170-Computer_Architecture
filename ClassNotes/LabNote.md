# Lab1
```
# denotes comment in Assembly.
```
* An assembly language program has two sections.
    * **.data** <br>
    Where you declare all your variables.
    * **.text** <br>
    Where you put your program in the form of RISC-V instruction.
* Printing is done by passing the pointer to the string or the value to be printed in register a1 or x11 and a code that tells the system what to print. This is followed by the command **ecall**.

## .data (Variable Declaration Section)
To declare a string with the **.string** directive.
```
#Var_name: .string "String"

greeting: .string "Hello World!"
```
To declare an integer with the **.word** directive.
```
#Var_name: .word integer

x: .word 3.14
```

## .text (Instruction Section)
To make main available to all project files.
There should be a main statement after the .globl main and before we give any instruction.

```
#Declare main
.globl main #make main available to all project files
main:
```
### Printing
To priint In Assembly, we pass the pointer to the value to be printed in register a1 or x11 and specify the variable name. <br>
Here, the pointer to the string welcome is passed in register a1 via the "la" command to print the string welcome.<br>
This is followed by the command ecall.
```
# Print a string
la a1, welcome
ecall
```
Next, print the integer value X. X is loaded into register a1 with the lw command. Register a0 has the value 1, which means we want to print an integer.
```
# Print an integer
lw a1, X
li a0, 1
ecall
```

### Divide and Modulo
If we want to divide, we use the **div** operation. If we want to perform the modulo operation, we use the **rem**.
The arguments are in register a3 and a4. At the end, we need to put it in register a0.
```
# To divide

lw a3, X
lw a4, Y
div a1, a3, a4
li a0, 1
ecall
```

### Exit the Program
The code is 10 in register a0. Nothing is required in a1.
```
# Exit the program

exit:
    addi a0, zero, 10
    ecall
```
