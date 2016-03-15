%{

#include "hw2_main.h"
#include "hw2_lex.h"

void yyerror(yyscan_t scanner, char const *msg);

%}

%code requires{

#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
typedef void* yyscan_t;
#endif

}

%output  "hw2_parser.c"
%defines "hw2_parser.h"

%define parse.error verbose
%define api.pure
%lex-param   { yyscan_t scanner }
%parse-param { yyscan_t scanner }

%token INT_LIT 
%token IDENT 
%token ADD_OP 
%token SUB_OP 
%token MULT_OP 
%token DIV_OP 
%token MOD_OP 
%token LEFT_PAREN 
%token RIGHT_PAREN 
%token IF 
%token ELSE 
%token OR 
%token AND 
%token TRUE 
%token FALSE 
%token NOT 
%token LINE_T 
%token EQUALS 
%token UNKNOWN

%%

ifstmt: IF LEFT_PAREN boolexpr RIGHT_PAREN assign 
	  { printf("IFSTMT: IF ONLY, EXIT\n"); }
	  | IF LEFT_PAREN boolexpr RIGHT_PAREN assign ELSE assign
	  { printf("IFSTMT: IF/ELSE, EXIT\n"); }
	  ;

boolexpr: boolexpr OR boolterm 
		{ printf("BOOLEXPR: boolexpr OR boolterm, EXIT\n"); }
		| boolterm
		{ printf("BOOLEXPR: boolterm, EXIT\n"); }
		;

boolterm: boolterm AND boolfactor 
		{ printf("BOOLTERM: boolterm AND boolfactor, EXIT\n"); }
		| boolfactor
		{ printf("BOOLTERM: boolfactor, EXIT\n"); }
		;

boolfactor: TRUE 
		  { printf("BOOLFACTOR: TRUE, EXIT\n"); }
		  | FALSE 
		  { printf("BOOLFACTOR: FALSE, EXIT\n"); }
		  | NOT boolfactor 
		  { printf("BOOLFACTOR: NOT boolfactor, EXIT\n"); }
		  | LEFT_PAREN boolexpr RIGHT_PAREN
		  { printf("BOOLFACTOR: ( boolfactor ), EXIT\n"); }
		  ;

assign: IDENT EQUALS expr LINE_T 
	  { printf("ASSIGN: INDENT EQUALS expr LINE_T, EXIT\n"); }
	  | IDENT EQUALS expr LINE_T assign
	  { printf("IDENT: INDENT EQUALS expr LINE_T assign, EXIT\n"); }
	  ;

expr: expr ADD_OP term 
	{ printf("EXPR: expr ADD_OP term, EXIT\n"); }
	| expr SUB_OP term 
	{ printf("EXPR: expr SUB_OP term, EXIT\n"); }
	| term
	{ printf("EXPR: term, EXIT\n"); }
	;

term: term MULT_OP factor 
	{ printf("TERM: term MULT_OP factor, EXIT\n"); }
	| term DIV_OP factor 
	{ printf("TERM: term DIV_OP factor, EXIT\n"); }
	| term MOD_OP factor  
	{ printf("TERM: term MOD_OP factor, EXIT\n"); }
	| factor
	{ printf("TERM: factor, EXIT\n"); }
	;

factor: IDENT 
	  { printf("FACTOR: IDENT, EXIT\n"); }
	  | INT_LIT
	  { printf("FACTOR: INT_LIT, EXIT\n"); }
	  | LEFT_PAREN expr RIGHT_PAREN
	  { printf("FACTOR: LEFT_PAREN INT_LIT RIGHT_PAREN, EXIT\n"); }
	  ;

%%

void yyerror(yyscan_t scanner, char const *msg) {

    fprintf(stderr, "Error: %s\n", msg);
}

