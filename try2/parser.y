%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char *s);
%}

%union {
    char *str;
}

%token <str> ATOM VARIABLE
%token IMPLICATION COMMA LPAREN RPAREN LBRACKET RBRACKET DOT
%token ERROR

%start program

%%

program:
    rules
    ;

rules:
    rule
    | rules rule
    ;

rule:
    head IMPLICATION body DOT
    ;

head:
    predicate
    ;

body:
    goals
    ;

goals:
    goal
    | goals COMMA goal
    ;

goal:
    predicate
    ;

predicate:
    ATOM LPAREN terms RPAREN
    | ATOM
    ;

terms:
    term
    | terms COMMA term
    ;

term:
    ATOM
    | VARIABLE
    | list
    ;

list:
    LBRACKET elements RBRACKET
    ;

elements:
    /* пустой список */
    | element
    | elements COMMA element
    ;

element:
    term
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Ошибка: %s\n", s);
}

int main() {
    if (yyparse() == 0) {
        printf("Программа корректна.\n");
    } else {
        printf("Программа содержит ошибки.\n");
    }
    return 0;
}