#include <iostream>
#include <vector>
#include <string>


int main () {
    std::vector<std::string> str = {"one", "two", "three"} ; 
    std::vector<int> integer = {1, 3, 5} ; 

    for (int i : integer) {
        if (i == 5) {
            std::cout<<"yes i is 5";
            integer[i] = 55;
        }
        std::cout<<i;
        std::cout<<" ";
    }


    for (std::string s : str) {
        std::cout<<s;
        std::cout<<" ";
    }
    std::cout<<std::endl;


    std::vector v {0, 2, 3};
    std::cout<< "The length is: " << v.size() <<'\n';

    v.resize(5); // resize 
    std::cout<< "The length after resize is: " << v.size() <<'\n';

    std::cout<<std::endl;
    for (auto i: v) 
        std::cout<< i <<' ';  // 0 2 3 0 0

    std::cout << '\n';  
    return 0;
}
