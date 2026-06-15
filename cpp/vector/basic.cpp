#include <iostream>

int main (int argc, char* argv[]) {
    int width { 4 }; 
    std::cout<<"width: " <<width<<std::endl;

    std::cout<< "Number of args: " <<argc <<std::endl;
    for (int i = 1; i < argc; i++) {
        std::cout<<"Argument: "<<i<< ":" <<argv[i]<<std::endl;
    }
    return 0;
}   

