%{


#include <stdlib.h>
#include "y.tab.h"
#include <stdio.h>
#include <string.h>

int yyerror(const char *);
int line_number = 1;
int exit_flag = 0;


%}

%option noyywrap nodefault yylineno


%%


"=="|"mod"|"rem"|"div"|"is"|"=<"|"=>"|"="|"=\\="|"<="|"<"|">="|">"|\+|\*|\/ {
    printf("GET TOKEN OPERATOR (%s)\n", yytext);
    return OPERATOR;
}


[0-9]+ {
    printf("GET TOKEN NUMBER (%s)\n", yytext);
    return NUMBER;
}


[a-z]([a-z]|[A-Z]|[0-9]|_)* {
    printf("GET TOKEN COMPONENT_NAME (%s)\n", yytext);
    return COMPONENT_NAME;
}


(_|[A-Z])([a-z]|[A-Z]|[0-9]|_)* {
    printf("GET TOKEN VAR_NAME (%s)\n", yytext);
    return VAR_NAME;
}


%[^\n]*  { 
    printf("GET TOKEN COMMENT (%s)\n", yytext);
}


"." {
    printf("GET TOKEN DOT\n");
    return DOT;
}


"(" {
    printf("GET OPBR\n");
    return OPBR;
}


")" {
    printf("GET CLBR\n");
    return CLBR;
}


"," {
    printf("GET COMMA\n");
    return COMMA;
}


":" {
    printf("GET COLON\n");
    return COLON;
}


"-" {
    printf("GET MINUS\n");
    return MINUS;
}


"[" { 
    printf("GET TOKEN SQOPBR ([)\n");
    return SQOPBR;
}


"]" { 
    printf("GET TOKEN SQCLBR (])\n");
    return SQCLBR;
}


"|" {
    printf("GET TOKEN VERTICAL_PIPE (|)\n");
    return VERTICAL_PIPE;
}


";" {
    printf("GET TOKEN SEMICOLON (;)\n");
    return COMMA;
}


'([^'\\]|\\.)*' {
    printf("GET TOKEN STRING (%s)\n", yytext);
    return STRING;
}

\"([^"\\]|\\.)*\" {
    printf("GET TOKEN STRING (%s)\n", yytext);
    return STRING;
}

"!" {
    printf("GET TOKEN STRING (%s)\n", yytext);
    return CUT;
}


[ \t\f]  ;  


\n {
    line_number++;
    printf("GET TOKEN ENDLINE\n");
    // return ENDLINE;
}


<<EOF>> { 
    
    if (exit_flag)
    {
        return 0;
    } 
    else
    {
        exit_flag = 1;
        // return ENDLINE; 
    }
} 


. {
    yyerror("Invalid character");
}
