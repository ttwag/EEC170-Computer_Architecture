#include <iostream>
#include <iomanip>

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

int main() {
    int num = 0x00000FFF;
    num = parity(num, 1);
    std::cout<<std::hex<<num<<std::endl;
    return 0;
}
