%{


#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(const char *s);

extern char *yytext;
extern int line_no;
extern FILE* yyin;


%}


%token NUMBER COMPONENT_NAME VAR_NAME SQOPBR SQCLBR ENDLINE VERTICAL_PIPE OPERATOR DOT OPBR CLBR COMMA COLON MINUS


%%


program :

    program base_block  
    { 
        printf("Rule: program -> base_block program\n"); 
    }

    |

    base_block 
    { 
        printf("Rule: program -> base_block\n"); 
    }
    
    ;


base_block : 

    intergral_expr ENDLINE
    { 
        printf("Rule: base_block -> intergral_expr ENDLINE\n"); 
    } 

    |

    ENDLINE
    {
        printf("Rule: JUST ENDLINE\n"); 
    }
    
    ;


intergral_expr :

    expr 
    { 
        printf("Rule: intergral_expr -> expr\n"); 
    }

    | 
    
    intergral_expr expr   // several exprs in single line    
    { 
        printf("Rule: intergral_expr -> intergral_expr expr\n"); 
    }
    
    ;


expr : 
    
    component DOT 
    { 
        printf("Rule: expr -> component DOT\n"); 
    }
    
    | 
    
    component COLON MINUS ENDLINE list_components DOT 
    { 
        printf("Rule: expr -> component COLON MINUS ENDLINE list_components DOT\n"); 
    }
    
    | 
    
    component COLON MINUS list_components DOT 
    { 
        printf("Rule: expr -> component COLON MINUS list_components DOT \n"); 
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


list_components : 
    
    component 
    { 
        printf("Rule: list_components -> component\n"); 
    }
    
    | 
    
    list_components COMMA opt_endlines component 
    { 
        printf("Rule: list_components -> list_components , component\n"); 
    }       
    
    |
    
    subterm
    {
        printf("Rule: component -> list_components subterm\n"); 
    }
    
    |
    
    list_components COMMA opt_endlines subterm
    {
        printf("Rule: list_components COMMA opt_endlines  subterm\n"); 
    }
    
    ;


component : 
    
    COMPONENT_NAME 
    { 
        printf("Rule: component -> COMPONENT_NAME\n"); 
    }
    
    | 
    
    COMPONENT_NAME OPBR listterms CLBR 
    { 
        printf("Rule: component -> COMPONENT_NAME ( listterms )\n"); 
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


listterms : 
    
    |
    
    term 
    { 
        printf("Rule: listterms -> term\n"); 
    }
    
    | 
    
    listterms COMMA term 
    { 
        printf("Rule: listterms -> listterms , term\n"); 
    }
    
    | 
    
    listterms VERTICAL_PIPE term
    {
        printf("Rule: listterms -> listterms | term\n"); 
    }
    
    ;


term :
    
    NUMBER 
    { 
        printf("Rule: term -> NUMBER\n"); 
    }
    
    |
    
    COMPONENT_NAME 
    { 
        printf("Rule: term -> COMPONENT_NAME\n"); 
    }
    
    |
    
    VAR_NAME 
    { 
        printf("Rule: term -> VAR_NAME\n"); 
    }
    
    | 
    
    bracket_term 
    { 
        printf("Rule: term -> bracket_term\n"); 
    }
    
    ;


bracket_term :
    
    COMPONENT_NAME OPBR listterms CLBR 
    { 
        printf("Rule: bracket_term -> COMPONENT_NAME ( listterms )\n"); 
    }
    
    |
    
    SQOPBR listterms SQCLBR
    {
        printf("Rule: bracket_term -> [] ( listterms )\n"); 
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
