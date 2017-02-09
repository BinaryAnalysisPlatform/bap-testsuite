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
opam install bap --deps-only
opam install bap -v

cd ../
make check
