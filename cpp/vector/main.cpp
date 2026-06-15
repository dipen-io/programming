#include <iostream>
#include <string>
#include <vector>

template<typename T>
std::ostream& operator<<(std::ostream& s, const std::vector<T>& v)
{
    s.put('{');
    for (char comma[]{'\0', ' ', '\0'}; const auto& e : v)
        s << comma << e, comma[0] = ',';
    return s << "}\n";
}

int main () {
    std::vector<std::string> words1{"the", "fruits", "is", "great"} ;
    std::cout<<"1: "<<words1;

    // words2 == words1
    std::vector<std::string> words2(words1.begin(), words1.end()) ;
    std::cout<<"2: "<<words2;

    // words3 == words1
    std::vector<std::string> words3(words1);
    std::cout<<"3: "<<words3;

    // words4 
    std::vector<std::string> words4(5, "mo");
    std::cout<<"4: " << words4;

    return 0;
}
