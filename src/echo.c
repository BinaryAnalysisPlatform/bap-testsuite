#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int print_strings(const char **strings) {
    const char **p;
    for (p = strings; *p; p++) {
        printf("read %s\n", *p);
    }
}

int main(int argc, const char **argv) {
    int i;
    char *strings[argc+1];

    for (i = 0; i < argc; i++) {
        strings[i] = strcpy(malloc(strlen(argv[i])), argv[i]);
    }

    strings[argc] = '\0';

    print_strings(strings);
}
