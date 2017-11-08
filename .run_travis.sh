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

if [ "$BAP_RUN_VERI" = "true" ]; then
    git clone https://github.com/BinaryAnalysisPlatform/bap-veri
    opam pin add bap-veri bap-veri/ -n
    opam install -y bap-veri
    make veri
else
    make check
fi
