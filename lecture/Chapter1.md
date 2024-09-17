# Chapter 1 -  Introduction to the Instruction Set
## 1. Inside the Computer
* **CPU**
    * **Program Counter (PC)**: Pointer to the next instruction to execute.
    * **Arithmetic Unit (ALU)**: adder, shift, multiply
    * **Register File**: array of registers (small local fast memory). Each is 32 bits X0,...,X31. It's implemented by D-Flipflop.
* **Memory**
    * Each memory block has an address and data, and we use **byte-addressing**. Each index is 1 byte.
    * A 32-bit quantity is called **WORD**. In word addressing, each index represents 4 bytes.
    * 1 WORD has 4 bytes.
    * **Big Endian Notation**: MSB of data in the least significant address.
    * **Little Endian Notation**: MSB of data in most significant address.


## 2. Instruction Set: RISC-V
**Instruction set**: the vocabulary of commands understood by a given architecture.
<br><br>
Each RISC-V arithmetic instruction performs only one operation and must always have exactly three variables. <br>
Each line in RISC-V contains at most 1 instruction.
```
// The following sequence adds four variables

add a, b, c //The sum of b and c is placed in a
add a, a, d //d is added to a
add a, a, e
```

### RISC-V Operands
* **Operands** in assembly language are the data or memory locations used to execute the instruction.
* **Opcode**: What to do?
* **Source**: What should I do it on?
* **Destination**: Where to put the results?
* Arithmetic operations use register operands.
* RISC-V's memory is little Endian.

| Name | Example | Comments |
| ---- | :------:| -------- |
| 32 Registers| x0 - x31 | Data must be in registers to perform arithmetics. Register x0 always equals 0. |
| $2^{30}$ memory words | Memory[0], Memory[4], .... | Accessed only by data transfer instructions. RISC-V uses byte addresses, so sequential word addresses differ by 4. |
<br>

### RISC-V Assembly Language

| Category | Instruction | Example | Meaning | Comments |
| -------- | ----------- | ------- | ------- | -------- |
| Arithmetic | Add | add x5, x6, x7 | x5 = x6 + x7 | Three register operands; add |
| | Subtract | sub x5, x6, x7 | x5 = x6 - x7 | Three register operands; subtract |
| | Add immediate | addi x5, x6, 20 | x5 = x6 + 20 | Used to add constants |
| Data transfer | Load word | lw x5, 40(x6) | x5 = Memory[x6 + 40] | Word from memory to register |
| | Load word, unsigned | lwu x5, 40(x6) | x5 = Memory[x6 + 40] | Unsigned word from memory to register |
| | Store word | sw x5, 40(x6) | Memory[x6 + 40] = x5 | Word from register to memory |
| | Load halfword | lh x5, 40(x6) | x5 = Memory[x6 + 40] | Halfword from memory to register |
| | Load halfword, unsigned | lhu x5, 40(x6) | x5 = Memory[x6 + 40] | Unsigned halfword from memory to register |
| | Store halfword | sh x5, 40(x6) | Memory[x6 + 40] = x5 | Halfword from register to memory |
| | Load byte | lb x5, 40(x6) | x5 = Memory[x6 + 40] | lb x5, 40(x6) | x5 = Memory[x6 + 40] | Byte from memory to register |
| | Load byte, unsigned | lbu x5, 40(x6) | x5 = Memory[x6 + 40] | Byte unsigned from memory to register |
| | Store byte | sb x5, 40(x6) | Memory[x6 + 40] = x5 | Byte from register to memory |
| | Load reserved | lr.d x5, (x6) | x5 = Memory[x6] | Load; 1st half of atomic swap |
| | Store conditional | sc.d x7, x5, (x6) | Memory[x6] = x5; x7 = 0/1 | Store;2nd hald of atomic swap |
| | Load upper immediate | lui x5, 0x12345 | x5 = 0x12345000 | Loads 20-bit constant shifted left 12 bits |
| Logical | And | and x5, x6, x7 | x5 = x6 & x7 | Three reg. operands; bit-by-bit AND |
| | Inclusive or | or x5, x6, x8 | x5 = x6 \| x8 | Three reg. operands; bit-by-bit OR |
| | Exclusive or | xor x5, x6, x9 | x5 = x6 ^ x9 | Three reg. operands; bit-by-bit XOR |
| | And immediate | andi x5, x6, 20 | x5 = x6 & 20 | Bit-by-bit AND reg. with constant |
| | Inclusive or immediate | ori x5, x6, 20 | x5 = x6 \| 20 |  Bit-by-bit OR reg. with constant |
| | Exclusive or immediate | xori x5, x6, 20 | x5 = x6 ^ 20 | Bit-by-bit XOR reg. with constant |
| Shift | Shift left logical | sll x5, x6, x7 | x5 = x6 << x7 | Shift left by register |
| | Shift right logical | srl x5, x6, x7 | x5 = x6 >> x7 | Shift right by register |
| | Shift right arithmetic | sra x5, x6, x7 | x5 = x6 >> x7 | Arithmetic shift right by register. An arithmetic shift preserves the sign. |
| | Shift left logical immediate | slli x5, x6, 3 | x5 = x6 << 3 | Shift left by immediate |
| | Shift right logical immediate | srli x5, x6, 3 | x5 = x6 >> 3 | Shift right by immediate |
| | Shift right arithmetic immediate | srai x5, x6, 3 | x5 = x6 >> 3 | Arithmetic shift right by immediate |
| Conditional branch | Branch if equal | beq x5, x6, 100 | if (x5 == x6) go to PC+100 | PC relative brach if registers equal |
| | Branch if not equal | bne x5, x6, 100 | if (x5 != x6) go to PC+100 | PC relative branch if registers not equal |
| | Branch if less than | blt x5, x6, 100 | if (x5 < x6) go to PC+100 | PC relativ branch if registers less |
| | Branch if greater or equal | bge x5, x6, 100 | if (x5 >= x6) go to PC+100 | PC relative branch if registers greater or equal |
| | Branch if less, unsigned | bltu x5, x6, 100 | if (x5 < x6) go to PC+100 | PC relative branch if registers less, unsigned |
| | Branch if greater or equal, unsigned | bgeu x5, x6, 100 | if (x5>= x6) go to PC+100 | PC relative branch if registers greater or equal, unsigned |
| Unconditional branch | Jump and link | jal x1, 100 | x1 = PC+4; go to PC+100 | PC relative procedure call |
| | Jump and link register | jalr x1, 100(x5) | x1 = PC+4; go to x5 + 100 | Procedure return indirect call |

## Operands of the Computer Hardware (Registers)
* The operands of arithmetic instructions are restricted; they must be from a limited number of special lcoation built directly in hardware called **registers**.
* Registers are small, high-speed storage locations in CPU. The computer typicaly puts more frequently used variables into registers.
* **Register takes less time to access and we could only perform arithmetics with register on RISC-V, so they have higher throughput**.
* The size of a register in the RISC-V architecture is 32 bits. Groups of 32 bits are given the name **word**, which is a natural unit of access in a computer. A word is a group of 32 bits. <br>
* **Doubleword** is a group of 64 bits.<br>
* Modern computer typically have 32 registers. Therefore, three operands of RISC-V arithmetic instructions must each be chosen from one of the 32-bit registers.
* The RISC-V convention for indicating a register is x followed by the number of the register, except a few.

Example C Code compiled to RISC-V
```
// C Langage
f = (g + h) - (i + h)
```
```
// RISC-V 
// f, g, h, i, and j are assigned to registers x19, x20, x22, and x23

add x5, x20, x21 // temporary registers x5 and x6
add x6, x22, x23
sub x19, x5, x6
```
### Memory Operands
* Since arithmetic operations occurs only on registers in RISC-V instructions, RISC-V must have instructions that transfer data between memory and registers.
* **Data transfer instruction** A command that moves data between memory (RAM) and registers. 
* To access a word in memory, the instruction must supply the memory address. Memory is an array starting at index 0.
* RISC-V uses byte addressing. Each address is 4 bytes, thus representing 1 word.
* The data transfer instruction that copies data from memory to a register is **load**, or **lw** in RISC-V.

### When an Operand is in Memory (C to Assembly)
* Assume A is an array of 100 words (100 4 byte) and the compiler associated the variable g and h with the registers x20 and x21. The starting address of A is in x22.
* A[8] is in the memory, so we must first transfer A[8] to the register.
* To access A[8] in assembly, we will add 8 indices to the starting address and load it to x9.
* The constant 8 here is called the **offset**.
* In the implementation, we use 32 instead of 8 because each index is separated by 4 byte and RISC-V uses byte address.
```
// C language
g = h + A[8]

// RISC-V 
// A[i]'s address = Base Address + i * 4
lw x9, 32(x22) //x9 as temp register
add x20, x21, x9 
```
### Compiling Using Load and Store
* The instruction complementary to load is **store (sw)**. It copies data from a register to memory.
* Assume h is associated with register x21 and the base address of the array A is in x22. 

```
// In C language
A[12] = h + A[8]

// In RISC-V
lw x9, 32(x22)      // x9 as temp register
add x21, x21, x9
sw x21, 48(x22)     // Stores the numbers back into A[12]
```
### Signed and Unsigned Numbers
We'll use **Two's Complement**.
Given an n-bit number, 
$$x = -x_{n-1} 2^{n-1} + x_{n-2}2^{n-2}+...+x_12^{1}+x_02^{0}$$
If the most significant bit is 0, the number is positive. Otherwise, it's negative. **The number overflows if it doesn't match this pattern.**

To go from a positive number x to its negative counterpart, negate x bit-by-bit and add 1. This comes from the fact that a binary with all 1's in two's complement is -1, so $$x + \bar{x} = -1$$ and $$\bar{x} + 1 = -x$$

Range of Representation = $$(-2^{n-1}, 2^{n-1}-1)$$

## 3. Representing Instructions in the Computer
* An instruction could be represented by a 32 bit number.
* **Instruction format**: a form of representation of an instruction composed of fields of binary numbers.
* RISC-V Instruction fields
    * **opcode (7-bits)**: basic operation of the instruction.
    * **rd (5-bits)**: the register destination operand.
    * **funct3 (3-bits)**: additional opcode field.
    * **rs1 (5-bits)**: first register source operand.
    * **rs2 (5-bits)**: second register source operand.
    * **funct7 (7-bits)**: additional opcode field.
* There are many instruction formats in RISC-V

### Logical Operations
* Shift right logical: fill the vacant bits with zero.
* Shift right arithmetic: fill the vacant bits with copies of old sign bit.

### Conditional Operations
Branch to a labeled instruction if a condition is true. Otherwise, continue sequentially.
```
//if (rs1 == rs2) branch to instruction labeled L1
beq rs1, rs2, L1  //L1 add to the program counter to jump to another line.

//if (rs1 != rs2) branch to instruction labeled L1
bne rs1, rs2, L1

//if (rs1 < rs2) branch to instruction L1
blt rs1, rs2, L1

//if (rs1 >= rs2) branch to instruction labeled L1
bge rs1, rs2, L1
```
### Signed vs. Unsigned
* Signed comparison: <small>blt</small>, <small>bge</small>
* Unsigned comparison: <small>bltu</small>, <small>bgeu</small>

### Loops
```
// C code
while (save[i] == k) i+=1;

// Compiled RISC-V code with i in x22, k in x24, address of save in x25
Loop:
    slli x10, x22, 2 //Bit shift for 4 bytes
    add x10, x10, x25
    lw x9, 0(x10)
    bne x9, x24, Exit
    addi x22, x22, 1
    beq x0, x0, Loop   // or j Loop
Exit:

```

## 4. Procedure (Function)
### Basic Ideas
* Jump-and-link instruction: an instruction that branches to an address and simultaneously saves the address of the following instruction in a register (**usually x1**).
* ```x10 - x17```: eight parameter registers in which to pass parameters or return values
* ```x1```: one return address register to return to the point of origin after the procedural call.
* The link stored in register x1 is called the **return address**
* The jump-and-link intstruction (jalr) branches to the address stored in register x1. 
The calling program (**caller**) puts the parameter values in ```x10``` to ```x17``` and uses ```jal x1, X``` to branch to procedure ```X``` (**callee**). The callee then performs the calculations, places the results in the same parameter registers, and returns control to the caller using ```jalr x0, 0(x1)```.
* We need a register to hold the address of the current instruction being executed. This register is called the **program counter (PC)**. The jal instruction saves PC+4 in its designation register (usually ```x1``` is the PC and 4 is 4 bytes)

```
jal x0, function_label #branch to function_label
```

### Using more Registers with Stack
A stack needs a pointer to the most recently allocated address in the stack to show where the next procedure should place the registers to be spilled or where old register values are found. 

The **stack pointer** is register ```x2```, also known by the name sp.

If I am going into a another function and want to save the contents in register ```x5```,```x6```, and ```x20```, then I could do:

```
addi sp, sp, -12    //expand stack for 3 integers

sw x5, 8(sp)    //save x5 for use afterwards

sw x6, 4(sp)    //save x6 for use afterward

sw x20, 0(sp)   //save x20 for use afterwards
```

Before returning from the function, we restore the three old values of the registers we saved by stack.pop()

```
lw x20, 0(sp)   //restore x20 for caller

lw x6, 4(sp)    //restore x6 for caller

lw x5, 8(sp)    //restore x5 for caller
addi sp, sp, 12 //adjust stack to delete 3 items

jalr x0, 0(x1)  //branch back to calling function
```
