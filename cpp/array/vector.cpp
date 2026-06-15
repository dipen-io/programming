#include <istream>
#include <vector>
#include <print>
using namespace std;

int main (int argc, char *argv[]) {
    pmr::vector heloo  = pmr::vector<int>  {1, 2, 3};

    for (int i = 0; i<heloo.size() - 1; i++){
        println(heloo[i]);
    }

    return 0;
}
