
all: echo symexec

.PHONY: echo echo-32 symexec
echo: echo.c
		sh build.sh echo.c
		x86_64-linux-gnu-gcc -m32 -w echo.c  -o ../bin/x86-linux-gnu-echo

symexec: symexec-*.c
	sh build.sh $?
