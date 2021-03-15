%{
   #include <stdio.h>
   #include "yacc.tab.h"
   void yyerror(char *);
   extern YYSTYPE yylval;
%}

delim                  [\t \n]
ws                     {delim}+
letter                 [A-Za-z_]
dec_digit              [1-9]
ident                  {letter}({letter}|{hex_digit})*
number                 {dec_digit}*(0)*(\.{dec_digit}+)?(E[+-]?{dec_digit}+)?
hex_digit              (0[xX][0-9A-Fa-f]+)
oct_digit              (0[0-7]+)

 
/*   状态（或条件）定义可以定义在这里 
 *   INITIAL是一个默认的状态，不需要定义
 */

%s COMMENT
%s COMMENT2
%%
 
<INITIAL>"/*"                                           {BEGIN COMMENT;}
<COMMENT>"*/"                                           {BEGIN INITIAL;}
<COMMENT>.|\n                                           {;}
<INITIAL>"//"                                           {BEGIN COMMENT2;}
<COMMENT2>\n                                        {BEGIN INITIAL;}
<COMMENT2>.                                             {;}
 
 /* ECHO是一个宏，相当于 fprintf(yyout, "%s", yytext)*/
 
<INITIAL>{ws}                      {;}
<INITIAL>while                     {return WHILE;}
<INITIAL>do                       {return DO;}
<INITIAL>if                       {return IF;}
<INITIAL>else                     {return ELSE;}
<INITIAL>block                    {return BLOCK;}
<INITIAL>continue                 {return CONTINUE;}
<INITIAL>break                    {return BREAK;}
<INITIAL>const                    {return CONST;}
<INITIAL>int                      {return INT;}
<INITIAL>void                     {return VOID;}
<INITIAL>{ident}                  { /*scanf(yytext,"%s",&yylval.str);*/return IDENT;}
<INITIAL>{number}                 {/*scanf(yytext,"%d",&yylval.num);*/return  IntConst;}
<INITIAL>{hex_digit}              {/*scanf(yytext,"%d",&yylval.num);*/return  HEX_NUMBER;}
<INITIAL>{oct_digit}              {/*scanf(yytext,"%d",&yylval.num);*/return  OCT_NUMBER;}
<INITIAL>"<"                      {return LT;}
<INITIAL>"<="                     {return LE;}
<INITIAL>"="                      {return EQ;}
<INITIAL>"!="                     {return NE;}
<INITIAL>">"                      {return GT;}
<INITIAL>">="                     {return GE;}
<INITIAL>"("                      {return LPAREN;}
<INITIAL>")"                      {return RPAREN;}
<INITIAL>"{"                      {return LBIG;}
<INITIAL>"}"                      {return RBIG;}
<INITIAL>"+"                      {return ADD;}
<INITIAL>"-"                      {return SUB;}
<INITIAL>"*"                      {return MULTI;}
<INITIAL>"/"                      {return DIV;}
<INITIAL>";"                      {return FenHao;}
<INITIAL>"%"                      {return MOD;}
<INITIAL>","                      {return DouHao;}
<INITIAL>"["                      {return LSIGN;}
<INITIAL>"]"                      {return RSIGN;}
<INITIAL>"!"                      {return NOT;}
<INITIAL>"=="                     {return EQUAL;}
<INITIAL>"&&"                     {return AND;}
<INITIAL>"||"                     {return OR;}
<INITIAL>"return"                 {return RETURN;}
<INITIAL>.                        {return ERRORCHAR;}
%%


main(argc,argv)
int argc;
char **argv;
{
   if(argc > 1){
         FILE * file ; 
         file = fopen(argv[1],"r");
         if(!file){
             fprintf(stderr,"error open %s",argv[1]);
             exit(1); 
           }
       yyin = file ;
    }

    yylex();
}
