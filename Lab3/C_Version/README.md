# Purpose
This C program is the C version of the lab3_skel.S, which 
implements the 16 bit floating point multiplication algorithm 
in software.

# Approach
1. **Process X and Y's mantissas**
    * Give the mantissa its invisible bit by bit shifting 0x1 seven times and OR it with the mantissa.
    * Use a while loop to shift the mantissa to the right to take away its 0s after the decimal point.
    * The while loop also counts how many shift it has done, which we would use to calculate the decimal
    point for the mantissa as 7 - count
2. **Perform Multiplication of Mantissas and Perform Normalization**
    * 7 - count1 + 7 - count2 = 14 - count1 - count2 is the decimal point of the product mantissa.
    * The key is that the result of mantissa multiplication is either 1.XXXXX or 10.XXXXX because
     of the invisible 1 being always in the front.
    * Use a variable e to check if the bit to the left of decimal point is 0 or 1.
    * If 1, no need to normalize, clear the bit to hide invisible 1.
    * If 0, normalize the MSB and shift the mantissa to the right once and record exponent offset.
3. **Shift the Product Mantissa To Appropriate Position for float16**
    * if 7 - (14 - count1 - count2) > 0, this means the product mantissa has less decimal point than 
    the allotted 7 bits, so we shift it left by the difference.
    * Else, we do the opposite.
4. **Sign Bit**
    * Extract the sign bits of x and y.
5. **Exponent**
    * Extract the exponent and subtract 127 and add the offset.
6.  **Assemble**
    * Get the sign bit by XOR the two sign.
    * Assemble everything by OR.

### Time Complexity
* O(7), the while loop at most loops 7 times to clear the 0 bits.
### Space Complexity
* O(1), we always store float16