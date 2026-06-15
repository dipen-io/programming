#include <iostream>
#include <vector>

void printStack(const std::vector<int> & stack) {
    if (stack.empty()) {
        std::cout<<"Empty";
    }

    for(auto element: stack) {
        std::cout<< element << ' ';
    }

    std::cout<<"\tCapacity: " <<stack.capacity() << " Length: " << stack.size() << "\n";
}

int main() {
    std::vector<int> stack{}; // empty stack
    printStack(stack);

    stack.push_back(1);
    printStack(stack);

    stack.push_back(2);
    printStack(stack);
}
