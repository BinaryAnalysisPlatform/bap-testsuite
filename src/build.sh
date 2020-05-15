TARGETS="x86_64-linux-gnu\
       arm-linux-gnueabi\
       i686-w64-mingw32\
       x86_64-w64-mingw32\
       mips-linux-gnu\
       powerpc-linux-gnu"

build() {
    target=$2
    $target-gcc -g -w $1 -o ../bin/$target-$(basename $1 .c)
}

if [ "x$TARGETS" != "x" ]; then
    TARGETS="$TARGETS"
fi

for src in $@; do
    for target in $TARGETS; do
        build $src $target && result="DONE" || result="FAIL"
        printf "%-40s %s\n" $target $result
    done
done
