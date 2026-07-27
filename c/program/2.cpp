#include <stdio.h>

int main() {
    int card = 1;
    if (card > 1) {
        card = card - 1;
        if (card < 7) {
            puts("Small Word");
        }
    } else {
        puts("Ale");
    }
    return 0;
}
