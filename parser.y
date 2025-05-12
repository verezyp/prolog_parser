%{
#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylex();
void yyerror(const char *s);
%}

%union {
    char *str;
    int num;
}

%token <str> VARIABLE ATOM STRING
%token <num> NUMBER
%token IMPLICATION DOT COMMA LPAREN RPAREN LBRACKET RBRACKET ERROR

%%

program: 
        
        | program clause DOT{
            printf("DEBUG: program clause DOT \n ");
        }
        ;

clause: 
    fact {
        printf("DEBUG: clause: fact \n ");
    }
      | rule    |
      clause IMPLICATION clause
      ;

fact: ATOM
    | ATOM LPAREN term_list RPAREN {
        printf("DEBUG: ATOM LPAREN term_list RPAREN \n ");
    }
    ;

rule: head IMPLICATION body {
    printf("DEBUG: head IMPLICATION body \n ");
    };

head: ATOM
    | ATOM LPAREN term_list RPAREN
    ;

body: term
    | body COMMA term
    ;

term: ATOM
    | VARIABLE
    | NUMBER
    | STRING
    | list
    ;

term_list: term
         | term_list COMMA term {
            printf("DEBUG:term_list COMMA term \n ");
         }
         ;

list: LBRACKET RBRACKET
    | LBRACKET term_list RBRACKET
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Ошибка: %s\n", s);
    exit(1);
}

int main(int argc, char* argv[]) {
    yyin = fopen(argv[1], "rb");
    yyparse();
    fclose(yyin);
    printf("\n\nSuccess\n\n");
    return 0;
}