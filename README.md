BAP Test suite
==============

This repository contains tests and test artifacts for Binary Analysis
Platform. We use DejaGNU testing framework to glue everything in one
piece. The tests are organized around different tools, namely `bap`,
`mc`, `byteweight` (to be added), and so on.

Usage
=====

Testing the Platform
--------------------

The repository was designed to be ran automatically by Travis CI, but
still can be used manually. Just clone it, make sure that you have
`dejagnu` installed on your system, and run:

```
make check
```

This will run all tests for all tools. To test only specific `$tool`, run

```
runtest --tool=$tool
```

To run only a specific suite from a `file.exp` of a `$tool` use:

```
runtest --tool=$tool file.exp
```

See `man runtest` for more information.


Adding new test
---------------

To add a new test to an existing tool create a file `<testname>.exp`
in a folder, that contains tests for the tool. For example, to add a
new test to a `bap` frontend, add it to `bap.tests`. The tests are
written in Tcl extended with `expect` command. The DejaGNU framework
adds few functions, such as `pass`, `fail`. Even more functions are
added by tool specific libraries, the `lib/$tool.exp` is evaluated
before `$tool` test, making all its definitions available. Also
`site.exp` file defines site configuration parameters (see Structure
section below, for information on a structure of the suite).

Adding new tool
---------------

To add new tool `$tool`, you need to create:
- a folder `$tool.tests` where test suites will be stored;
- add this test to the Makefile `TOOLS` variable
- add `lib/$tool.exp` as a tool support package


Adding new test artifact
------------------------

We store artifacts in binary mode and if possible in source
code. There are few reasons to commit the artifacts in the binary
form:

1. it is quite to compile them in a portable way
2. sometimes there're now source code for an artifact

The artifact name should have form `tripple-name`, where `tripple` is
a canonical target representation, e.g., `arm-linux-gnueabi`,
`i686-w64-mingw32`, etc. An example of a well-formed fully tripplified
name would be: `arm-linux-androideabi-echo`.

Once a new test artifact is added, make sure that all existing tests
are passing. If the don't then either create an issue (if you think,
that they should pass), or fix the test.

Structure
=========

The repository structure is defined by requirements of the DejaGNU
framework. For each `$tool` there is a folder `$tool.tests` that
contains tests for this `$tool`. A library `lib/$tool.exp` contains
code that can be reused across different tools. Other modules from
this folder can be loaded with `load_lib` procedure provide by the
DejaGNU framework, e.g., `common.exp` is used for sharing code between
all tools. The `config` folder contains configuration files (i.e.,
files that define configuration constants) specific for
boards. (Currently we support only unix board, so at this point of
time it can be ignored).

The `src` folder contains source code for test artifacts. Each
test-artifact that has a source should be rebuildable from the source,
using a recipe in `src/Makefile`. The `src/Makefile` can contain
recipes that are not portable.

The `bin` folder contains the test artifacts built from sources `src`,
or obtained from some obscure system. The folder must contain only
binary files for testing. If some object data is needed, then it
should be stored in corresponding test folder in the test itself or as
a file with `.dat` extension (or any other suitable extension). If you
want to add some meta information to a file that is not backed by a
source code, it would be a good idea to add a textual file with the
same basename as the file into the `src` folder.


Current Status
==============

Currently the suite is an alpha stage and is not yet integrated with
Travis CI. It will be as soon, as we will get `0` on the `make check`.
