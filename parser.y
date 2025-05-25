%{


#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(const char *s);

extern char *yytext;
extern int line_number;
extern FILE* yyin;


%}


%token NUMBER COMPONENT_NAME VAR_NAME SQOPBR SQCLBR VERTICAL_PIPE OPERATOR DOT OPBR CLBR COMMA COLON MINUS STRING CUT


%%


program :

    program base_block  
    { 
        printf("Rule: program -> program base_block\n"); 
    }

    |

    base_block 
    { 
        printf("Rule: program -> base_block\n"); 
    }
    
    ;


base_block : 

    intergral_expr DOT
    { 
        printf("Rule: base_block -> intergral_expr ENDLINE\n"); 
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
    
    component 
    { 
        printf("Rule: expr -> component DOT\n"); 
    }
    
    | 
    
    component COLON MINUS list_components   
    { 
        printf("Rule: expr -> component COLON MINUS list_components DOT \n"); 
    }
    
    /* |

    COMPONENT_NAME COLON MINUS list_components
    { 
        printf("Rule: component -> COMPONENT_NAME COLON MINUS list_components//\n"); 
    } */
    ;
       



list_components : 
    

    component 
    { 
        printf("Rule: list_components -> component\n"); 
    }
    
    | 
    
    list_components COMMA component 
    { 
        printf("Rule: list_components -> list_components , component\n"); 
    }       
    
    |
    
    subterm
    {
        printf("Rule: component -> list_components subterm\n"); 
    }
    
    |
    
    list_components COMMA subterm
    {
        printf("Rule: list_components COMMA    subterm\n"); 
    }
    

    ;


component :
    
    CUT 
    {
        printf("Rule: term -> CUT\n");
    }

    |

    COMPONENT_NAME 
    { 
        printf("Rule: component -> COMPONENT_NAME//\n"); 
    } 
    
    | 
    
    COMPONENT_NAME OPBR listterms CLBR 
    { 
        printf("Rule: component -> COMPONENT_NAME ( listterms )\n"); 
    }
    
    |
    
    OPBR list_components CLBR 
    {

    }
    
    
    ;


/* uminus  :

    MINUS term
    {
        printf("Rule: uminus MINUS term\n");
    } */


subterm :
    
    /* OPBR subterm CLBR
    {
        printf("Rule: OPBR subterm CLBR\n");
    }
    
    | */

    term OPERATOR OPBR subterm CLBR
    {
         printf("Rule: term OPERATOR OPBR subterm CLBR\n");
    }

    |

    term OPERATOR term 
    {
        printf("Rule: subterm OPERATOR term\n"); 
    }
    
    /* |
    
    term uminus
    {
        printf("Rule: subterm MINUS term\n"); 
    } */
    
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

    |

    etc_br
    {
         printf("Rule: listterms -> OPBR listterms CLBR\n"); 
    }
    
    | 
    
    listterms COMMA etc_br 
    { 
        printf("Rule: listterms -> listterms , term\n"); 
    }
    
    | 
    
    listterms VERTICAL_PIPE etc_br
    {
        printf("Rule: listterms -> listterms | term\n"); 
    }


    ;


etc_br:

    OPBR listterms CLBR
    {
         printf("Rule: listterms -> OPBR listterms CLBR\n"); 
    }


term :
    
    MINUS term {
        printf("Rule: term -> MINUS term\n"); 
    }

    |

    STRING
    {
        printf("Rule: term -> STRING\n"); 
    }

    |

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

    /* |

    OPBR listterms CLBR
    {
        printf("Rule: term -> OPBR listterms CLBR\n"); 
    } */
    
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
    
    | 

    OPBR listterms COLON MINUS listterms CLBR
    {

    }

    ;


%%


int yyerror(const char *s)
{
    printf("Error: %s on line %d: %s\n", s, line_number, yytext);
    exit(1);
}


int main(int argc, const char * argv[]) {
    yyin = fopen(argv[1], "rb");
    yyparse();
    printf("\nVALID!\n");
    fclose(yyin);
}
