%{
#include "y.tab.h"
%}

%%

%{
/* Пропускаем пробелы, табуляции и переносы строк */
%}

[ \t\n]+            ;

%{
/* Комментарии */
%}

"%"[^"\n"]*         ; /* Однострочные комментарии */

%{
/* Ключевые символы */
%}

":"-"-"             { return IMPLICATION; }
","                 { return COMMA; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"["                 { return LBRACKET; }
"]"                 { return RBRACKET; }
"."                 { return DOT; }

%{
/* Идентификаторы и переменные */
%}

[a-z][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ATOM; }
[A-Z][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return VARIABLE; }

%{
/* Остальные символы */
%}

.                   { printf("Неизвестный символ: %s\n", yytext); return ERROR; }

%%

int yywrap() {
    return 1;
}