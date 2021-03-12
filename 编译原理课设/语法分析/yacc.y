%{
#include <stdio.h>
#include <string.h>
int yylex(void);
void yyerror(char *);
%}

%union{
  int num;
  double number;
  char * str;
}

%start CompUnit     //以CompUnit为开始符号
%token <number> IntConst
%token <number> HEX_NUMBER
%token <number> OCT_NUMBER
%token <str>    IDENT 
%left MULTI DIV MOD
%token WHILE DO IF ELSE BLOCK CONTINUE BREAK CONST INT VOID LT LE EQ NE GT GE  ADD SUB FenHao DouHao LSIGN  RSIGN NOT EQUAL OR RETURN AND
%token LPAREN RPAREN LBIG RBIG 



%type Decl
%type ConstDecl 
%type BType
%type ConstDef
%type ConstInitVal
%type VarDecl 
%type VarDef 
%type InitVal
%type FuncDef 
%type FuncType
%type FuncFParams
%type FuncFParam 
%type Block
%type BlockItem 
%type Stmt
%type Exp
%type Cond
%type LVal 
%type PrimaryExp
%type Number
%type UnaryExp
%type UnaryOp 
%type FuncRParams
%type MulExp
%type AddExp
%type RelExp
%type EqExp
%type LAndExp
%type LOrExp
%type ConstExp

%type Repeat
%type RR
%type RRR
%type RRRR
%type RRRRR
%type RAR
%type RBR
%type RCR
%type RDR
%type RER
%type RFR
/*********************/
%%
CompUnit:
LPAREN Decl RPAREN
| LPAREN  FuncDef RPAREN
|  CompUnit LPAREN  FuncDef RPAREN
|  CompUnit LPAREN  Decl RPAREN
;

Decl :
ConstDecl 
| VarDecl
;

Repeat: 
DouHao ConstDef 
| ;
ConstDecl:
CONST BType ConstDef Repeat FenHao ;

BType: INT ;

RR : 
LSIGN ConstExp RSIGN 
| ;
ConstDef:IDENT RR EQ ConstInitVal ;

RRR : 
DouHao ConstInitVal
| ; 

ConstInitVal:
ConstExp   
|  LBIG    ConstInitVal RRR  RBIG
|  LBIG  RBIG;

RRRR: 
DouHao VarDef 
| ;
VarDecl: BType VarDef RRRR FenHao ;

RRRRR:
LSIGN ConstExp RSIGN
| ;

RAR :
LSIGN ConstExp RSIGN
| ;

VarDef:
IDENT  RRRRR
| IDENT  RAR EQ InitVal ;

RBR:
DouHao InitVal
| ;

InitVal: 
Exp 
| LBIG  RBIG
| LBIG  InitVal RBR  RBIG;

FuncDef: 
FuncType IDENT  LPAREN [FuncFParams] RPAREN Block  
| FuncType IDENT  LPAREN  RPAREN Block ;

FuncType: 
VOID
| INT 
;

RCR :
FenHao FuncFParam
| ;

FuncFParams: FuncFParam RCR ;

RDR:
LSIGN Exp RSIGN
| ;
FuncFParam : 
BType IDENT 
| BType IDENT  LSIGN RSIGN RDR ;

RER:
BlockItem
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

RER:
LSIGN Exp RSIGN
| ;
LVal : IDENT  RER ;

PrimaryExp: 
LPAREN Exp RPAREN
| LVal 
| Number;

Number: 
IntConst ;


UnaryExp: 
PrimaryExp 
| IDENT  LPAREN FuncRParams RPAREN 
| IDENT  LPAREN  RPAREN   
| UnaryOp UnaryExp ;

UnaryOp : 
ADD 
| SUB
| NOT ;

RFR:
DouHao  Exp
| 
;

FuncRParams: Exp RFR ;
 
 MulExp: 
 UnaryExp 
 | MulExp  MULTI  UnaryExp 
 | MulExp   DIV    UnaryExp 
 | MulExp   MOD    UnaryExp ;
 
 AddExp: 
 MulExp 
 | AddExp  ADD  MulExp
 | AddExp  SUB  MulExp;
 
 RelExp: 
 AddExp 
 | RelExp  LT  AddExp
 | RelExp  GT  AddExp
 | RelExp  LE  AddExp
 | RelExp  GE  AddExp;
 
 EqExp: 
 RelExp 
 | EqExp  EQUAL   RelExp 
 | EqExp  NE      RelExp ;

LAndExp: 
EqExp 
| LAndExp AND EqExp;

LOrExp: 
LAndExp 
| LOrExp OR LAndExp ;

ConstExp: AddExp; 

%%
void yyerror(char *s) {
  printf("%s\n", s);
}
int main(void) {
  yyparse();
  return 0;
}
