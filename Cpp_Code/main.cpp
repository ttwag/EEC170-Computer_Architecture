#include <iostream>
#include <iomanip>
//Setting Even or Odd Parity
int parity(int num, int i) {
    int ans = num, k = 1, bit = 0;
    while (k <= 15) {
        bit += num & 1;
        num = num >> 1;
        k++;
    }
    if (!(bit % 2 == 0 ^ i == 0)) {
        ans += std::pow(2, 15);
    }
    return ans;
}


// Bit Manipulation
int BitManip(unsigned int A, unsigned int B) {
    unsigned int x = 0x3f;
    unsigned int y = x;
    x = x << 10;
    x = A & x;
    y = y << 26;
    y = !y;
    B = B & y;
    x = x << 15;
    B = B | x;
    return B;
}
int main() {
    unsigned int A = 0x0, B = 0xffffffff;
    std::cout<<std::hex<<BitManip(A, B);
    return 0;
}
