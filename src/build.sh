TARGETS="x86_64-linux-gnu arm-linux-gnueabi arm-linux-androideabi i686-w64-mingw32 x86_64-w64-mingw32"

build() {
    target=$2
    $target-gcc -w $1.c -o ../bin/$target-$1
}

if [ "x$TARGETS" != "x" ]; then
    TARGETS="$TARGETS"
fi

for target in $TARGETS; do
    build $1 $target && result="DONE" || result="FAIL"
    printf "%-40s %s\n" $target $result
done
