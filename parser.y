%{


#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(const char *s);

extern char *yytext;
extern int line_no;
extern FILE* yyin;


%}


%token ATOM VARIABLE
%token NUMBER
%token SQOPBR SQCLBR ENDLINE VERTICAL_PIPE OPERATOR DOT OPBR CLBR COMMA COLON MINUS

%type termlist predicate term structure subterm
%type clause
%type clauselist predicatelist


%%


program :

    prolog program  
    { 
        printf("Rule: program -> prolog program\n"); 
    }

    |

    prolog 
    { 
        printf("Rule: program -> prolog\n"); 
    }
    
    ;


prolog : 

    clauselist ENDLINE
    { 
        printf("Rule: prolog -> clauselist ENDLINE\n"); 
    } 

    |

    ENDLINE
    {
        printf("Rule: JUST ENDLINE\n"); 
    }
    
    ;


clauselist :

    clause 
    { 
        printf("Rule: clauselist -> clause\n"); 
    }

    | 
    
    clauselist clause
    { 
        printf("Rule: clauselist -> clauselist clause\n"); 
    }
    
    ;


clause : 
    
    predicate DOT 
    { 
        printf("Rule: clause -> predicate .\n"); 
    }
    
    | 
    
    predicate COLON MINUS ENDLINE predicatelist DOT 
    { 
        printf("Rule: clause -> predicate :- predicatelist .\n"); 
    }
    
    | 
    
    predicate COLON MINUS predicatelist DOT 
    { 
        printf("Rule: clause -> predicate :- predicatelist .\n"); 
    }
    
    ;
       

endlines : 
    
    ENDLINE
    {
        printf("Rule: endlines -> ENDLINE\n"); 
    }
    
    | 
    
    endlines ENDLINE
    {
        printf("Rule: endlines -> endlines ENDLINE\n"); 
    }
    
    ;


opt_endlines : 
    
    |
    
    endlines
    {
        printf("Rule: opt_endlines -> endlines\n"); 
    }
    
    ;


predicatelist : 
    
    predicate 
    { 
        printf("Rule: predicatelist -> predicate\n"); 
    }
    
    | 
    
    predicatelist COMMA opt_endlines predicate 
    { 
        printf("Rule: predicatelist -> predicatelist , predicate\n"); 
    }       
    
    |
    
    subterm
    {
        printf("Rule: predicate -> predicatelist subterm\n"); 
    }
    
    |
    
    predicatelist COMMA opt_endlines subterm
    {
        printf("Rule: predicatelist COMMA opt_endlines  subterm\n"); 
    }
    
    ;


predicate : 
    
    ATOM 
    { 
        printf("Rule: predicate -> ATOM\n"); 
    }
    
    | 
    
    ATOM OPBR termlist CLBR 
    { 
        printf("Rule: predicate -> ATOM ( termlist )\n"); 
    }
    
    ;


subterm :
    
    term OPERATOR term 
    {
        printf("Rule: subterm OPERATOR term\n"); 
    }
    
    |
    
    term MINUS term
    {
        printf("Rule: subterm MINUS term\n"); 
    }
    
    |
    
    subterm OPERATOR term
    {
        printf("Rule: subterm OPERATOR term\n"); 
    }
    
    |
    
    subterm MINUS term
    {
        printf("Rule: subterm MINUS term\n"); 
    }
    
    ;


termlist : 
    
    |
    
    term 
    { 
        printf("Rule: termlist -> term\n"); 
    }
    
    | 
    
    termlist COMMA term 
    { 
        printf("Rule: termlist -> termlist , term\n"); 
    }
    
    | 
    
    termlist VERTICAL_PIPE term
    {
        printf("Rule: termlist -> termlist | term\n"); 
    }
    
    ;


term :
    
    NUMBER 
    { 
        printf("Rule: term -> NUMBER\n"); 
    }
    
    |
    
    ATOM 
    { 
        printf("Rule: term -> ATOM\n"); 
    }
    
    |
    
    VARIABLE 
    { 
        printf("Rule: term -> VARIABLE\n"); 
    }
    
    | 
    
    structure 
    { 
        printf("Rule: term -> structure\n"); 
    }
    
    ;


structure :
    
    ATOM OPBR termlist CLBR 
    { 
        printf("Rule: structure -> ATOM ( termlist )\n"); 
    }
    
    |
    
    SQOPBR termlist SQCLBR
    {
        printf("Rule: structure -> [] ( termlist )\n"); 
    }
    
    ;


%%


int yyerror(const char *s)
{
    printf("Error: %s on line %d with text %s\n", s, line_no, yytext);
    exit(1);
}


int main(int argc, const char * argv[]) {
    yyin = fopen(argv[1], "rb");
    yyparse();
    printf("\nVALID!\n");
    fclose(yyin);
}
