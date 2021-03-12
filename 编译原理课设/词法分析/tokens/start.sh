flex ex.l
cc -o parser lex.yy.c -ll
clear
./parser < file.txt
