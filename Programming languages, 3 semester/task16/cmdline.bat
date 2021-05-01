@echo off
set drive=%~dp0Data\Packages\Systems\
set path=%drive%Steel Bank Common Lisp\1.2.1;%drive%WinHugs;%drive%swipl\bin;%drive%Ruby23;%drive%Ruby23\bin;%drive%Ruby23\include;%drive%Ruby23\lib;%drive%Ruby23\share;%drive%SMLNJ\bin;%path%
set SMLNJ_HOME=%drive%SMLNJ\
set SBCL_HOME=%drive%Steel Bank Common Lisp\1.2.1\
set OS=Windows_NT
start cmd