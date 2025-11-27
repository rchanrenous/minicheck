# Minicheck: a minishell tester

## Introduction

`minicheck` is a program supposed to run tests on a `minishell` program.\
It makes the `minishell` program read instructions from input files, and compares the associated output with that from `bash`, with the same input files.\
This tester is a powerful program to see in a glance where your `minishell` program succeeds and fails.
It requires a small tweak in the `minishell` program code which is detailed in the next section.\
Section *Build* details how to run the program.\
Finally the *Notes about the tests* section discusses the outputs of some tests.

## Pre-requisites

In order for the `minishell` program to read instructions from input files instead of reading them from the terminal, `minishell` cannot use the `readline()` function to read the instructions.\
As such `minishell` should check if it is reading from the terminal or an input file.\
A one way to do so is to use the `isatty()` function to detect whether the standard input of the program is associated to a terminal (`man 3 isatty`).

## Build

Clone the project at the root of the `minishell` program: a Makefile that builds `minishell` should be present here; then `cd` into that repository.
```
git clone git@github.com:rchanrenous/minicheck.git
cd minicheck
```
The tests are separated into *parsing* and *exec* tests.\
Use `make` to test both type of tests.\
Use `make parsing` or `make exec` to test *parsing* or *exec* tests only.

## Notes about the tests

`minicheck` compares both the standard outputs and standard errors of `minishell` versus `bash`.\
Possible differences should be checked carefully as some differences are intended, eg. the standard error outputting their shell program names (`minishell` versus `bash`).
