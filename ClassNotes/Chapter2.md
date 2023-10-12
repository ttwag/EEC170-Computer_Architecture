# Chapter 2 -  Instructions: Language of the Computer
## Inside the Computer
* **CPU**
    * **Program Counter (PC)**: Pointer to the next instruction to execute.
    * **Arithmetic Unit (ALU)**: adder, shift, multiply
    * **Register File**: array of registers (small lcoal fast memory). Each is 32 bits X0,...,X31. It's implemented by D-Flipflop
* **Memory**
    * Each memory block has an address and data, and we use **byte-addressing**. Each index is 1 byte.
    * 32 bit quantity is called **WORD**. In word addressing, each index represents 4 byte.
    * 1 WORD has 4 bytes.
    * **Big Endian Notation**: MSB of data in least significant address.
    * **Little Endian Notation**: MSB of data in most significant address.


## Instruction Set
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

### 2.3 -  RISC-V Operands<br>
* **Operands** in assembly language is the data or memory location used to execute the instruction.
* **Opcode**: What to do?
* **Source**: What should I do it on.
* **Destination**: Where to put the results.
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
| | Load halfword, unsigned |
| | Store halfword | 
| | Load byte |
| | Load byte, unsigned |
| | Store byte | 
| | Load reserved | 
| | Store conditional | 
| | Load upper immediate | 
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

#### When an Operand is in Memory (C to Assembly)
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
#### Compiling Using Load and Store
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
## 2.4 - Signed and Unsigned Numbers
* We'll use **Two's Complement**.
* If the most significant bit is 0, the number is positive. Otherwise, it's negative. The number overflows if it doesn't match this pattern.
* To go from a positive number x to its negative counterpart, negate x bit-by-bit and add 1. This comes from the fact that all 1's in two's complement is -1, so $x + \bar{x} = -1$ and $\bar{x} + 1 = -x$.

## 2.5 - Representing Instructions in the Computer
* An instruction could be represented by a 32 bit number.
* **Instruction format**: a form of representation of an instruction composed of fields of binary numbers.

