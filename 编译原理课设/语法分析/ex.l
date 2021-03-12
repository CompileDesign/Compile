%{ 
#include <stdio.h>
#include "yacc.tab.h"
void yyerror(char *);
extern YYSTYPE yylval;
/*
//关系运算符
#define LT					1   //   <
#define LE					2   //   <=
#define GT					3   //   >
#define GE					4   //   >=
#define EQ					5   //   
#define NE					6   //   !=
//算数运算符
#define MOD                                     7
#define ADD                                     8       
#define MULTI                                   9
#define DIV                                     10
//逻辑运算符
#define NOT                                     11
#define AND                                     12
#define OR                                      13
//保留字
#define IF                                      14
#define ELSE                                    15
#define WHILE                                   16
#define DO					  17
#define BREAK                                   18
#define CONTINUE                                19
#define RETURN                                  20
#define BLOCK                                   21
#define IntConst                                30
#define INT                                     31
#define VOID                                    32
#define CONST                                   33
//其他
#define IDENT                                   22   //标识符
#define LETTER                                  23   //字母与下划线
//数字
#define HEX_NUMBER                              24
#define NUMBER                                  25
#define OCT_NUMBER                              26
#define ERRORCHAR                               27


//运算符
#define RELOP                                   28

#define NEWLINE                                 29

#define DouHao                                  30
#define FenHao                                  31
#define LSIGN                                   32
#define RSIGN                                   33
#define EQUAL                                   34
#define LBIG                                    35
#define RBIG                                    36
#define LPAREN                                  37
#define RPAREN                                  38
#define SUB                                     39
*/
%}
 
 
delim		       [\t \n]
ws		       {delim}+
letter	               [A-Za-z_]
dec_digit	       [1-9]
ident 		       {letter}({letter}|{hex_digit})*
number	               {dec_digit}*(0)*(\.{dec_digit}+)?(E[+-]?{dec_digit}+)?
hex_digit              (0[xX][0-9A-Fa-f]+)
oct_digit              (0[0-7]+)

 
/* 状态（或条件）定义可以定义在这里 
 * INITIAL是一个默认的状态，不需要定义
 */
%s COMMENT
%s COMMENT2
%%
 
<INITIAL>"/*"						{BEGIN COMMENT;}
<COMMENT>"*/"						{BEGIN INITIAL;}
<COMMENT>.|\n						{;}
<INITIAL>"//"						{BEGIN COMMENT2;}
<COMMENT2>\n					    {BEGIN INITIAL;}
<COMMENT2>.					        {;}
 
 /* ECHO是一个宏，相当于 fprintf(yyout, "%s", yytext)*/
 
<INITIAL>{ws}	                   {;}
<INITIAL>while			   {return WHILE;}
<INITIAL>do		          {return DO;}
<INITIAL>if		          {return IF;}
<INITIAL>else		          {return ELSE;}
<INITIAL>block		          {return BLOCK;}
<INITIAL>continue		  {return CONTINUE;}
<INITIAL>break		          {return BREAK;}
<INITIAL>const	                  {return CONST;}
<INITIAL>int	                  {return INT;}
<INITIAL>void	                  {return VOID;}
<INITIAL>{ident}	          { /*scanf(yytext,"%s",&yylval.str);*/return IDENT;}
<INITIAL>{number}	          {/*scanf(yytext,"%d",&yylval.num);*/return  IntConst;}
<INITIAL>{hex_digit}	          {/*scanf(yytext,"%d",&yylval.num);*/return  HEX_NUMBER;}
<INITIAL>{oct_digit}	          {/*scanf(yytext,"%d",&yylval.num);*/return  OCT_NUMBER;}
<INITIAL>"<"	                  {return LT;}
<INITIAL>"<="	                  {return LE;}
<INITIAL>"="	                  {return EQ;}
<INITIAL>"!="	                  {return NE;}
<INITIAL>">"	                  {return GT;}
<INITIAL>">="	                  {return GE;}
<INITIAL>"("	                  {return LPAREN;}
<INITIAL>")"	                  {return RPAREN;}
<INITIAL>"{"	                  {return LBIG;}
<INITIAL>"}"	                  {return RBIG;}
<INITIAL>"+"	                  {return ADD;}
<INITIAL>"-"	                  {return SUB;}
<INITIAL>"*"	                  {return MULTI;}
<INITIAL>"/"	                  {return DIV;}
<INITIAL>";"	                  {return FenHao;}
<INITIAL>"%"	                  {return MOD;}
<INITIAL>","	                  {return DouHao;}
<INITIAL>"["	                  {return LSIGN;}
<INITIAL>"]"	                  {return RSIGN;}
<INITIAL>"!"	                  {return NOT;}
<INITIAL>"=="	                  {return EQUAL;}
<INITIAL>"&&"	                  {return AND;}
<INITIAL>"||"	                  {return OR;}
<INITIAL>"return"	           {return RETURN;}
<INITIAL>.			   {return ERRORCHAR;}

 
%%
 
int yywrap (){
  return 1;
}
/*
void writeout(int c){
  switch(c){
  	case ERRORCHAR:   fprintf(yyout, "(ERRORCHAR, \"%s\") \n", yytext);break;
        case RELOP:       fprintf(yyout, "(RELOP, \"%s\") \n", yytext);break;	   	  
        case IntConst:    fprintf(yyout, "(NUMBER, \"%s\") \n", yytext);break;
        case IDENT:       fprintf(yyout, "(IDENT,\"%s\") \n", yytext);break;
        case BREAK:       fprintf(yyout, "(BREAK,\"%s\") \n", yytext);break;
        case CONTINUE:    fprintf(yyout, "(CONTINUE,\"%s\") \n", yytext);break;
        case BLOCK:       fprintf(yyout, "(BLOCK, \"%s\") \n", yytext);break;
        case IF:          fprintf(yyout, "(IF,\"%s\") \n", yytext);break;
        case ELSE:        fprintf(yyout, "(ELSE,\"%s\") \n", yytext);break;
        case WHILE:       fprintf(yyout, "(WHILE,\"%s\") \n", yytext);break;
        case DO:          fprintf(yyout, "(DO,\"%s\") \n", yytext);break;
        case CONST:       fprintf(yyout, "(CONST,\"%s\") \n", yytext);break;
        case INT:         fprintf(yyout, "(INT,\"%s\") \n", yytext);break;
        case VOID:        fprintf(yyout, "(VOID,\"%s\") \n", yytext);break;
        //case OCT_NUMBER:  fprintf(yyout, "(OCT_NUMBER,\"%s\") \n", yytext);break;
        //case HEX_NUMBER:  fprintf(yyout, "(HEX_NUMBER,\"%s\") \n", yytext);break;
        case NEWLINE:     fprintf(yyout, "\n");break;
        default:break;
  }
  return;
}
 
 
int main (int argc, char ** argv){
	int c,j=0;
	if (argc>=2){
	  if ((yyin = fopen(argv[1], "r")) == NULL){
	    printf("Can't open file %s\n", argv[1]);
	    return 1;
	  }
	  if (argc>=3){
	    yyout=fopen(argv[2], "w");
	  }
	}
 
	while (c = yylex()){
		writeout(c);
		j++;
		if (j%5 == 0) writeout(NEWLINE);
	}
	if(argc>=2){
	  fclose(yyin);
	  if (argc>=3) fclose(yyout);
	}
	return 0;
}*/
