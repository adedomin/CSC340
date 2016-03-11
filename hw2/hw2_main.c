#include "hw2_parser.h"
#include "hw2_lex.h"

int main(int argc, char** argv) {

	argc--; argv++;

	yyscan_t scanner;

	yylex_init(&scanner);
	yyset_in(fopen(argv[0], "r"), scanner);

	yyparse(scanner);

	yylex_destroy(scanner);

	return 0;
}

