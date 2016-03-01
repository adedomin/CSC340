CC=cc
CFLAG=-O0 -Wall
CLEX=lexer_hw1.l
CFILE=lexer_hw1.c
CHEAD=lexer_hw1.h
CNAME=lexer_hw1

DOC=pandoc
DOCFLAGS=
DOCNAME=hw3-dedominica.pdf
DOCOBJ=ch1.md ch3.md ch4.md figures.md

PACK=zip
PACKFLAGS=-r
PACKNAME=HW3-dedominica.zip
PACKDIR=HW3/

all: doc
	
lex:
	cd lexer/; \
	flex $(CLEX); \
	$(CC) $(CFILE) -o $(CNAME) $(CFLAG)

clean:
	cd lexer/; \
	rm $(CFILE) $(CHEAD)

remove:
	cd lexer/; \
	rm $(CNAME)

lex_test: lex
	cd lexer/; \
	./lexer_hw1 ./text_syntax/syntax.txt

doc:
	$(DOC) $(DOCOBJ) -o $(DOCNAME) $(DOCFLAGS)

remove_doc:
	rm $(DOCNAME)

package: doc
	mkdir $(PACKDIR)
	cp $(DOCNAME) $(DOCOBJ) ./Makefile ./HW2/
	$(PACK) $(PACKFLAGS) $(PACKNAME) $(PACKDIR)
	rm -rf $(PACKDIR)

remove_package:
	rm $(PACKNAME)
