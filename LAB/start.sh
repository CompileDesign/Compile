lex lex.l
yacc -d yacc.y
g++ -c lex.yy.c y.tab.c
g++ -o exe lex.yy.o y.tab.o -ll

