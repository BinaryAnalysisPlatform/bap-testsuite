
all: echo

.PHONY: echo echo-32
echo: echo.c
		sh build.sh echo
		x86_64-linux-gnu-gcc -m32 -w echo.c  -o ../bin/x86-linux-gnu-echo
