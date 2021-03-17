%{
   #include "main.h"		
   #include "y.tab.h"
   void comment();
   extern "C"		
    {						
	int yywrap(void);
	int yylex(void);	
    }  

%}

delim                  [\t \n]
ws                     {delim}+
letter                 [A-Za-z_]
dec_digit              [1-9]
ident                  {letter}({letter}|{hex_digit})*
number                 {dec_digit}*(0)*(\.{dec_digit}+)?(E[+-]?{dec_digit}+)?
hex_digit              (0[xX][0-9A-Fa-f]+)
oct_digit              (0[0-7]+)


%%
"/*"			{ comment();/*注释*/}
"//"[^\n]*              { /* consume //-comment */ }
"while"                 {return (WHILE);}
"do"                    {return (DO);}
"if"                    {return (IF);}
"else"                  {return (ELSE);}
"block"                 {return (BLOCK);}
"continue"              {return (CONTINUE);}
"break"                 {return (BREAK);}
"const"                 {return (CONST);}
"int"                   {return (INT);}
"void"                  {return (VOID);}
"<="                    {return (LE);}
"<"                      {return (LT);}
"="                      {return (EQ);}
"!="                     {return NE;}
">"                      {return GT;}
">="                     {return GE;}
"("                      {return LPAREN;}
")"                      {return RPAREN;}
"{"                      {return LBIG;}
"}"                      {return RBIG;}
"+"                      {return ADD;}
"-"                      {return SUB;}
"*"                      {return MULTI;}
"/"                      {return DIV;}
";"                      {return FenHao;}
"%"                      {return MOD;}
","                      {return DouHao;}
"["                      {return LSIGN;}
"]"                      {return RSIGN;}
"!"                      {return NOT;}
"=="                     {return EQUAL;}
"&&"                     {return AND;}
"||"                     {return OR;}
"return"                 {return RETURN;}
.                        {/**/}

{ident}                 {
                                yylval.str = yytext;
                                return IDENT;
                        }

{number}                {
                                 yylval.number = atoi(yytext);
                                 return IntConst;
                        }

{hex_digit}             {      
                                 yylval.number = atoi(yytext);
                                 return IntConst;
                        }


{oct_digit}             {
                                 yylval.number = atoi(yytext);
                                 return IntConst;
                        }

%%



void comment() {
	char c, prev = 0;
	
	while (cin >> c)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	printf("unterminated comment");
}

int yywrap(void)
{
	puts("-----the file is end");
	return 1;								//返回1表示读取全部结束。如果要接着读其它文件，可以这里fopen该文件，文件指针赋给yyin，并返回0
}
