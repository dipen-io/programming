#include <iostream>

int main() {
    int arr[] = {1,2,3,4,5};
    int size = sizeof(int) / arr[0];
    std::cout << "hello world\n";
    for (int i = 0; i<=size; i++){
        std::cout<<arr[i];
    }
    std::cout<<std::endl;
    return 0;
}
