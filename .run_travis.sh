#!/bin/sh

bash -ex .travis-opam.sh
eval `opam config env`

BAPDIR=bap-source
USER=${TRAVIS_REPO_SLUG%/*}
PR_NUM=${TRAVIS_PULL_REQUEST_BRANCH##*#}
BRANCH=+refs/pull/$PR_NUM/merge

if [ -z "$TRAVIS_PULL_REQUEST_BRANCH" ]; then
    exit 0
fi

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
    git clone https://github.com/BinaryAnalysisPlatform/bap-veri
    opam pin add bap-veri bap-veri/ -n
    opam install -y bap-veri
    make veri
fi

if [ "$BAPTEST_RUN_CHECK" = "true"  ]; then
    make check
fi
