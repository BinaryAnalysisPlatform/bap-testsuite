#include <stdio.h>


int main(void) {
    while (1) {
        int c = getchar();
        if (c == 'A') {
            puts("access granted");
            return 0;
        }
        if (c <= 0) {
            puts("good bye!");
            return 1;
        }
        if (c == '\n') {
            puts("try again");
        }
    }
}
