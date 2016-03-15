#include "hw2_main.h"
#include "hw2_parser.h"
#include "hw2_lex.h"

int main(int argc, char** argv) {

	argc--; argv++;

	yyscan_t scanner;

	yylex_init(&scanner);

#ifdef _WIN32
	FILE* synfile;
	fopen_s(&synfile, "sample.txt", "r");
	yyset_in(synfile, scanner);
#else
	yyset_in(fopen(argv[0], "r"), scanner);
#endif

	yyparse(scanner);

	yylex_destroy(scanner);

#ifdef _WIN32
	printf("\nPRESS ENTER TO EXIT\n");
	fgetc(stdin);
#endif

	return 0;
}

