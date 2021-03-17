%{
#include"main.h"

extern "C"
{
    void yyerror(const char *s);
    extern int yylex(void);
}


%}


%start CompUnit     //以CompUnit为开始符号
%token <number> IntConst
%token <number> HEX_NUMBER
%token <number> OCT_NUMBER
%token <str>    IDENT 
%left MULTI DIV MOD
%token <str> INT
%token <str> VOID
%token WHILE DO IF ELSE BLOCK CONTINUE BREAK CONST  LT LE EQ NE GT GE  ADD SUB FenHao DouHao LSIGN  RSIGN NOT EQUAL OR RETURN AND
%token LPAREN RPAREN LBIG RBIG 



/*
 *   LPAREN == '[
 *   
 *
 *
 */
/*********************/
%%
CompUnit:  Decl     {cout << "yes" << endl;}
         | FuncDef 
         |  CompUnit  FuncDef 
         |  CompUnit  Decl
;

Decl :   ConstDecl 
       | VarDecl
;

Repeat: Repeat DouHao ConstDef 
       | ;

ConstDecl: CONST BType ConstDef Repeat FenHao ;

BType: INT ;

RR :  RR  LSIGN ConstExp RSIGN 
      | ;

ConstDef:IDENT RR EQ ConstInitVal ;


RRR : RRR  DouHao ConstInitVal
      | ; 

ConstInitVal:   ConstExp   
             |  LBIG    ConstInitVal RRR  RBIG
             |  LBIG  RBIG;

RRRR:  RRRR  DouHao VarDef 
       | ;

VarDecl: BType VarDef RRRR FenHao ;

RRRRR:  RRRRR  LSIGN ConstExp RSIGN
        | ;

RAR :  RAR  LSIGN ConstExp RSIGN
        | ;

VarDef:  IDENT  RRRRR
       | IDENT  RAR EQ InitVal ;

RBR:   DouHao InitVal
       | ;

InitVal:  Exp 
        | LBIG  RBIG
        | LBIG  InitVal RBR  RBIG;

FuncType: VOID
	 | INT ;

FuncDef:  FuncType IDENT  LPAREN FuncFParams RPAREN Block  
        | FuncType IDENT  LPAREN  RPAREN Block ;


FuncFParams: FuncFParam RCR ;


FuncFParam :  BType IDENT 
            | BType IDENT  LSIGN RSIGN RDR ;

RDR: RDR  LSIGN Exp RSIGN
      | ;

 RCR :   RCR  FenHao FuncFParam
       | ;



RER:    RER  BlockItem
        | ;

Block : LBIG RER RBIG ;

BlockItem: Decl 
	 | Stmt ;

Stmt :LVal EQ Exp FenHao 
     | Exp FenHao  
| Block 
| IF LPAREN Cond RPAREN Stmt ELSE Stmt  
| IF LPAREN Cond RPAREN Stmt  
| WHILE LPAREN Cond RPAREN Stmt 
| BREAK FenHao    
| CONTINUE FenHao 
| RETURN  Exp FenHao 
| RETURN  FenHao 
| FenHao;

Exp : AddExp ;

Cond : LOrExp;

RSR: RSR LSIGN Exp RSIGN
   | ;
LVal : IDENT  RSR ;

PrimaryExp:   LPAREN Exp RPAREN
            | LVal 
            | Number;

Number:     IntConst ;

UnaryExp:    PrimaryExp 
           | IDENT  LPAREN FuncRParams RPAREN 
           | IDENT  LPAREN  RPAREN   
           | UnaryOp UnaryExp ;

UnaryOp : ADD 
        | SUB
        | NOT ;

RFR: RFR DouHao  Exp
     | ;

FuncRParams: Exp RFR ;
	    
 MulExp: 
 UnaryExp 
 | MulExp  MULTI  UnaryExp 
 | MulExp   DIV    UnaryExp 
 | MulExp   MOD    UnaryExp ;
 
 AddExp:  MulExp 
 | AddExp  ADD  MulExp
 | AddExp  SUB  MulExp;
 
 RelExp:  AddExp 
 | RelExp  LT  AddExp
 | RelExp  GT  AddExp
 | RelExp  LE  AddExp
 | RelExp  GE  AddExp;
 
 EqExp: RelExp 
 | EqExp  EQUAL   RelExp 
 | EqExp  NE      RelExp ;

LAndExp: EqExp 
| LAndExp AND EqExp;

LOrExp:  LAndExp 
| LOrExp OR LAndExp ;

ConstExp: AddExp; 

%%
void yyerror(const char *s)			
{
	cerr<<s<<endl;			
}

int main()				
{
	const char* sFile="file.txt";
	FILE* fp=fopen(sFile, "r");
	if(fp==NULL)
	{
		printf("cannot open %s\n", sFile);
		return -1;
	}
	extern FILE* yyin;		
	yyin=fp;						

	printf("-----begin parsing %s\n", sFile);
	yyparse();						
	puts("-----end parsing");

	fclose(fp);

	return 0;
}
