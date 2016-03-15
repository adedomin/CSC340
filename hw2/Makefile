CC=gcc
CFLAGS=-O0 -Wall -Wpedantic
NAME=hw2_syn
DEPS=hw2_lex.h hw2_parser.h
SRC=hw2_lex.c hw2_parser.c
MAIN_DEP=hw2_main.h
MAIN_SRC=hw2_main.c
LEX=hw2_lex.l
PARSE=hw2_parser.y

all: lex bis executable

lex:
	flex $(LEX)

bis:
	bison $(PARSE)

executable: $(SRC) $(DEPS) $(MAIN_DEP) $(MAIN_SRC)
	gcc $(SRC) $(MAIN_SRC) -o $(NAME) $(CFLAGS)

clean:
	rm $(SRC) $(DEPS)

remove:
	rm $(NAME)
