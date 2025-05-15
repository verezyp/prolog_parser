# code examples
  - https://github.com/Anniepoo/prolog-examples/tree/master

# Usage

Linux:
- ./labcompiler test.txt

Windows:
- labcompiler.exe test.txt

# Linux compile

- make

# Windows compile

- *run Developer command Prompt for VS*

- cl lex.yy.c y.tab.c polynomlib.c -o labcompiler -DYY_NO_UNISTD_H
