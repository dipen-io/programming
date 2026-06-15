#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <string>

using namespace std;

int main () {

    println("\nORDERED_MAP\n");

    // unordered_map< Key(T), value(T)> name
    unordered_map<string, int> score;

    //insert
    score["dinesh"] = 88;
    score.insert({"dipen", 898});
    score.emplace("mohon", 888);

    // check existence  using key
    if (score.count("dinesh")) {
        // access 
        cout<<"dinesh : " << score["dinesh"] <<"\n";
    }

    // Iterate
    for (const auto& [name, score] : score) {
        cout<<name <<"->" << score << "\n";
    }

    // find 
    auto it = score.find("dinesh");
    if (it != score.end()) {
        cout<<"Found: " <<it->first <<" = " <<it->second;
    } 

    score.erase("Bob");

    println("\nUNORDERED_MAP\n");
    unordered_set<int> seen;
    seen.insert(10);
    seen.insert(20);
    seen.insert(30);
    seen.insert(40);
    seen.insert(10); // duplicate ingnored


    println("\nBEFORE \n");
    for (int x: seen) {
        println("{}", x);
    }

    auto its = seen.find(80);
    if (its != seen.end()) {
        seen.erase(its);
    } else {

        println("\element not found \n");
    }

    println("\nAFTER \n");

    for (int x: seen) {
        println("{}", x);
    }

    return 0;
}
