#include <iostream>
using namespace std;

int main()
{
	int x;
	std::cout << "hex: ";
	std::cin >> std::hex >> x;
	std::cout << "oct: " << std::oct << x << '\n';
	std::cout << "dec: " << std::dec << x << '\n';

}

