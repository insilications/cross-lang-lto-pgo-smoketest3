#include <iostream>
#include <exception>

int main () {
    try {
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello" << std::endl;
        std::cout << "Hello123" << std::endl;
    }
    catch (std::exception& ex) {
        std::cout << "Exception occurred!" << std::endl;
    }
    return 0;
}
