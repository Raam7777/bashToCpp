This is a simple C List module.

It is tested with Google test framework and with valgrind.

To install it:
1. Run 'make installonce' in the shell to install Google test framework, makedepend,
and valgrind. This should be done only once.
2. Run 'make' in the shell to install the List module with its testing and 
then run the tests.
3. If you change the name of files / includes you'll possibly need to 
update the Makefile and then run 'make depend' and only then run 'make'. 
If you change just the code in one of the files you'll only need to run 'make'.

You can also run the test executable, e.g., ListTest with the --help param. That is:
$ ListTest --help
