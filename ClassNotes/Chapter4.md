# The Processor
In RISC-V ISA, executing every instruction first needs these two steps:
1. Send the PC to the memory that contains the code and fetch the instruction from that memory.
2. Read one or two registers whose numbers are determined by fields of the instruction. 

After these two steps, the action depends on the instruction class (ex: logical or arithmetic), but all will need to use arithmetic logical unit (ALU) first. 

At the end, increment PC by 4 and fetch the next instruction.

## 1st Layer of CPU
![Figure3](./images/Figure3.png)
* All instruction start by using the program counter to get the instruction from the instruction memory. 
* After the instruction is fetched, the register operands are specified by fields of that instruction. 
* Once the register operands are fetched, they can be operated on to compute a memory address (for lw or sw), for arithmetic computation (add or shift), or an equality check (branch).
* The result from the ALU or memory is written back into the register file. Branch requires the ALU output to determine the next PC.
* NOTE: thick lines are buses representing multiple signals. The arrows guide the information flow.

## 2nd Layer of CPU
![Figure4](./images/Figure4.png)
* The top Multpilexor controls whether PC should go to the next line or branch. 
* This top multiplexor is controlled by ANDing the Zero output of the ALU and a control signal that indicates the instruction is a branch. 
* The middle multiplexor's output returns to the register file. It's used to steer the output of the ALU (for arithmetic and logical instruction) or load data from the memory to the register. 
* The bottom-most multiplexor is used to determine whether the second ALU input is from the register (for arithmetic, logical, and branch) or from the offset field of the instruction (lw or sw). 

## Review of Digital Logic
* **Combinational Element:** an operational element, such as an AND gate or an ALU. EX: Adder
* **State Element:** a memory element, such as a register or a memory. A state element has two inputs and an output. It requires the data value to be written into the element and the clock, which determines when the data value is written; a state element can be read at any time.
EX: D-Flip-Flop.

We will assume **positive edge-triggered clocking**, in which all state changes occur on a clock edge.

![Figure5](./images/Figure5.png)

All signals must propagate from state element 1, through the combinational logic, and to state element 2 in the time of one clock cycle. The time necessary for the signals to reach state element 2 defines the length of the clock cycle.

## Datapath
* Datapath Element: a unit used to operate on or hold data within a procesor. EX: instruction, data memory, register file, ALU, and adder.

### PC
![Figure6](./images/Figure6.png)

* A register file is a collection of registers in which any register can be read or written by specifying the number of the register in the file.


### Register file
![Figure7](./images/Figure7.png)


### Memory unit
![Figure8](./images/Figure8.png)

The branch instruction operates by adding the PC with the 12 bits of the instruction shifted left by 1 bit. Concatenating to the branch offset accomplishes this shift.

### Branch
![Figure9](./images/Figure9.png)

### Data Path for R-Type Instruction
![Figure11](./images/Figure11.png)

**ALU Control Inputs**
![Figure12](./images/Figure12.png)

**Control Unit**
![Figure13](./images/Figure13.png)

## Exercise
![Figure14](./images/Figure14.png)

### Data Path
![Figure15](./images/Figure15.png)

### Waveform
![Figure16](./images/Figure16.png)

### Latency
* R-Type Instruction = Register Read (30 ps) + I-Mem (250 ps) + Register File (150 ps) + Mux (25 ps) + ALU (200 ps) + Mux (25 ps) + Register Setup (20 ps) = 700 ps
* lw (load word) = Register Read (30 ps) + I-Mem (250 ps) + Register File (150 ps) + Mux (25 ps) + ALU (200 ps) + D-Mem (250 ps) + Mux (25 ps) + Register Setup (20 ps) = 950 ps
* sw (store word) = Register read (30 ps) + I-Mem (250 ps) + Register File (150 ps) + Mux (25 ps) + ALU (200 ps) + D-Mem (250 ps) = 905 ps
* Branch = Register read (30 ps) + I-Mem (250 ps) + Register File (150 ps) + Mux (25 ps) + ALU (200 ps) + Single gate (5 ps) + Mux (25 ps) + Register Setup (20 ps) = 705 ps
* Arithmetic, logical, shift I-type instruction = Register Read (30 ps) + I-Mem (250 ps) + Register File (150 ps) + Mux (25 ps) + ALU (200 ps) + Mux (25 ps) + Register Setup (20 ps) = 700 ps
