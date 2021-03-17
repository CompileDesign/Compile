/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IntConst = 258,
    HEX_NUMBER = 259,
    OCT_NUMBER = 260,
    IDENT = 261,
    MULTI = 262,
    DIV = 263,
    MOD = 264,
    INT = 265,
    VOID = 266,
    WHILE = 267,
    DO = 268,
    IF = 269,
    ELSE = 270,
    BLOCK = 271,
    CONTINUE = 272,
    BREAK = 273,
    CONST = 274,
    LT = 275,
    LE = 276,
    EQ = 277,
    NE = 278,
    GT = 279,
    GE = 280,
    ADD = 281,
    SUB = 282,
    FenHao = 283,
    DouHao = 284,
    LSIGN = 285,
    RSIGN = 286,
    NOT = 287,
    EQUAL = 288,
    OR = 289,
    RETURN = 290,
    AND = 291,
    LPAREN = 292,
    RPAREN = 293,
    LBIG = 294,
    RBIG = 295
  };
#endif
/* Tokens.  */
#define IntConst 258
#define HEX_NUMBER 259
#define OCT_NUMBER 260
#define IDENT 261
#define MULTI 262
#define DIV 263
#define MOD 264
#define INT 265
#define VOID 266
#define WHILE 267
#define DO 268
#define IF 269
#define ELSE 270
#define BLOCK 271
#define CONTINUE 272
#define BREAK 273
#define CONST 274
#define LT 275
#define LE 276
#define EQ 277
#define NE 278
#define GT 279
#define GE 280
#define ADD 281
#define SUB 282
#define FenHao 283
#define DouHao 284
#define LSIGN 285
#define RSIGN 286
#define NOT 287
#define EQUAL 288
#define OR 289
#define RETURN 290
#define AND 291
#define LPAREN 292
#define RPAREN 293
#define LBIG 294
#define RBIG 295

/* Value type.  */


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
