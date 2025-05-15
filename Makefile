all:
	flex lexer.l
	yacc -d parser.y --warnings=none
	gcc -w lex.yy.c y.tab.c -o prolog_parser 


clean:
	rm -f y.tab* prolog_parser* lex.yy.c *obj parser.tab*
