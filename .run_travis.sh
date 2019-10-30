#!/bin/sh

bash -ex .travis-opam.sh
eval `opam config env`

BAPDIR=bap-source
USER=${TRAVIS_REPO_SLUG%/*}
PR_NUM=${TRAVIS_PULL_REQUEST_BRANCH##*#}
BRANCH=+refs/pull/$PR_NUM/merge

git clone --depth=50 https://github.com/$USER/bap.git $BAPDIR
cd $BAPDIR

(git fetch origin $BRANCH &&
 git checkout -qf FETCH_HEAD) ||
    git fetch origin master

opam pin -yn add bap .
opam install conf-bap-llvm
opam install bap --deps-only
opam install bap -v

cd ../

bap-byteweight update --url=https://github.com/BinaryAnalysisPlatform/bap/releases/download/v1.3.0/sigs_full.zip

if [ "$BAPTEST_RUN_VERI" = "true" ]; then
    git submodule init
    git submodule update
    opam pin add bap-veri veri/bap-veri/ -n
    opam install bap-veri --deps-only
    cd veri/bap-veri
    make && make install
    cd ../../
    make veri
fi

if [ "$BAPTEST_RUN_CHECK" = "true"  ]; then
    make check
fi
