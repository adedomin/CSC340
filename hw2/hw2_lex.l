%{
 
#include "hw2_main.h"
#include "hw2_parser.h"
#include <stdio.h>
#include <stdlib.h>

%}

%option outfile="hw2_lex.c" 
%option header-file="hw2_lex.h"
%option warn nodefault
%option reentrant noyywrap never-interactive nounistd
%option bison-bridge
%option yylineno
 
IF      "if"
ELSE    "else"
OR      "OR"
AND     "AND"
TRUE    "TRUE"
FALSE   "FALSE"
NOT     "NOT"
EQUALS  "="
LINE_T  ";"
LPAREN  "("
RPAREN  ")"
PLUS    "+"
MULT    "*"
SUB     "-"
DIV     "/"
MOD     "%"

NUMBER  [0-9]+
VAR     [a-zA-Z][a-zA-Z0-9]*
/* (I)nternal (F)ield (S)eparator */
IFS     [ \r\n\t]*

%%
 
{IF}      { printf("TOKEN: %d, LEXEME: %s\n", IF, yytext); return IF; } 
{ELSE}    { printf("TOKEN: %d, LEXEME: %s\n", ELSE, yytext); return ELSE; } 
{OR}      { printf("TOKEN: %d, LEXEME: %s\n", OR, yytext); return OR; } 
{AND}     { printf("TOKEN: %d, LEXEME: %s\n", AND, yytext); return AND; } 
{TRUE}    { printf("TOKEN: %d, LEXEME: %s\n", TRUE, yytext); return TRUE; } 
{FALSE}   { printf("TOKEN: %d, LEXEME: %s\n", FALSE, yytext); return FALSE; } 
{NOT}     { printf("TOKEN: %d, LEXEME: %s\n", NOT, yytext); return NOT; } 
{LINE_T}  { printf("TOKEN: %d, LEXEME: %s\n", LINE_T, yytext); return LINE_T; } 
{EQUALS}  { printf("TOKEN: %d, LEXEME: %s\n", EQUALS, yytext); return EQUALS; } 

{IFS}     { /* Skip blanks. */ }
{VAR}     { printf("TOKEN: %d, LEXEME: %s\n", IDENT, yytext); return IDENT; } 
{NUMBER}  { printf("TOKEN: %d, LEXEME: %s\n", INT_LIT, yytext); return INT_LIT; }

{SUB}     { printf("TOKEN: %d, LEXEME: %s\n", SUB_OP,yytext); return SUB_OP; } 
{DIV}     { printf("TOKEN: %d, LEXEME: %s\n", DIV_OP, yytext); return DIV_OP; } 
{MOD}     { printf("TOKEN: %d, LEXEME: %s\n", MOD_OP, yytext); return MOD_OP; } 
{MULT}    { printf("TOKEN: %d, LEXEME: %s\n", MULT_OP, yytext); return MULT_OP; } 
{PLUS}    { printf("TOKEN: %d, LEXEME: %s\n", ADD_OP, yytext); return ADD_OP; } 
{LPAREN}  { printf("TOKEN: %d, LEXEME: %s\n", LEFT_PAREN, yytext); return LEFT_PAREN; } 
{RPAREN}  { printf("TOKEN: %d, LEXEME: %s\n", RIGHT_PAREN, yytext); return RIGHT_PAREN; } 
<<EOF>>   { printf("TOKEN: %d, LEXEME: EOF\n", EOF); return EOF; }
.         { fprintf(stderr, "ERROR: UNKNOWN LEXEME %s, on line %d\n", yytext, yylineno); }
 
%%

