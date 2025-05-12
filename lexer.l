%{
#include "y.tab.h"
#include <string.h>
#include <stdio.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
VARIABLE    [A-Z_][a-zA-Z0-9_]*
ATOM        [a-z][a-zA-Z0-9_]*
NUMBER      {DIGIT}+
STRING      \"[^"]*\"

%%

%[^\n]*  { 
    printf("DEBUG: COMMENT - pass\n");
}

{VARIABLE}   { 
    yylval.str = strdup(yytext); 
    printf("DEBUG: VARIABLE - '%s'\n", yylval.str); 
    return VARIABLE; 
}

{ATOM}       { 
    yylval.str = strdup(yytext); 
    printf("DEBUG: ATOM - '%s'\n", yylval.str); 
    return ATOM; 
}

{NUMBER}     { 
    yylval.num = atoi(yytext); 
    printf("DEBUG: NUMBER - %d\n", yylval.num); 
    return NUMBER; 
}

{STRING}     { 
    yylval.str = strdup(yytext); 
    printf("DEBUG: STRING - '%s'\n", yylval.str); 
    return STRING; 
}

:-          { 
    printf("DEBUG: IMPLICATION\n"); 
    return IMPLICATION; 
}

"."          { 
    printf("DEBUG: DOT\n"); 
    return DOT; 
}

"("          { 
    printf("DEBUG: LPAREN\n"); 
    return LPAREN; 
}

")"          { 
    printf("DEBUG: RPAREN\n"); 
    return RPAREN; 
}

"["          { 
    printf("DEBUG: LBRACKET\n"); 
    return LBRACKET; 
}

"]"          { 
    printf("DEBUG: RBRACKET\n"); 
    return RBRACKET; 
}

","          { 
    printf("DEBUG: COMMA\n"); 
    return COMMA; 
}

[ \t\n]      ; 

.            { 
    printf("DEBUG: UNKNOWN TOKEN - '%s'\n", yytext); 
    return ERROR; 
}

%%

int yywrap() {
    return 1;
}