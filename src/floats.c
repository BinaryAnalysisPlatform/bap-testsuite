#include <stdio.h>
#include <math.h>

#define check(msg,test) do {\
        if ((test)) puts("PASS: "msg); \
        else puts("FAIL: "msg);         \
    } while(0)

int main(void) {
    double pi = 3.14;
    double phi = 1.61;
    double e = 2.71;
    double avg = (pi + phi + e) / 3.0;

    check("pi = 3.14", pi == 3.14);
    check("pi != phi", pi != phi);
    check("pi < inf", pi < INFINITY);
    check("(pi+phi+e)/3 > 2", avg > 2.0);
    check("(pi+phi+e)/3 < 2.5", avg < 2.5);
    check("!((pi+phi+e)/3 < 2)", !(avg < 2.0));
    check("!((pi+phi+e)/3 > 2.5)", !(avg > 2.5));
}
