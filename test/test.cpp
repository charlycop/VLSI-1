#include <iostream>
#include <bitset>

void convertToBinary(unsigned int n) {
    if (n / 2 != 0) {
        convertToBinary(n / 2);
    }
		std::cout << n % 2;
}

int main() {
	
	unsigned int i = 665;
	unsigned int j = 85;

	j >>= 1;
  unsigned int r = j&i;
	std::cout << j << "  " << r << std::endl;

	return 0;
}
