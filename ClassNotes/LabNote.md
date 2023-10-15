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

## Put Integer into a Register




## If Statement
```
//C code
if (i == j) x; else !x;

// RISC-V
bne x22, 23, Else // go to Else if i != j
x             // if i == j, X
beq x0, x0, Exit //Unconditional branch
Else: !x     //Else branch i != j
Exit:
```
## While Loops
```
// C while loop
while (save[i] == k)
        i += 1;

// RISC-V, assuming i and k corresponds to x22 and x24. x25 stores array save's address

Loop: slli x10, x22, 2   //Temp reg x10 = i * 4
add x10, x10, x25       //x10 = address of save[i]
lw  x9, 0(x10)          //Temp reg x9 = save[i]
bne x9, x24, Exit       //go to Exit if save[i] != k
addi x22, x22, 1        //i = i + 1
beq x0, x0, Loop        //go to Loop
Exit: 
```

## Procedure
Jump-and-link instruction
```
jal x1, ProcedureAddress        //jump to ProcedureAddress and write return address to x1
```



