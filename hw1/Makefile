CC=cc
CFLAG=-O0 -Wall
CLEX=lexer_hw1.l
CLEXDIR=./lexer/
CFILE=lexer_hw1.c
CHEAD=lexer_hw1.h
CNAME=lexer_hw1

DOC=pandoc
DOCFLAGS=
DOCNAME=hw1-dedominica.pdf
DOCOBJ=ch1.md ch3.md ch4.md figures.md

DOTGRAPHDIR=./graphs/

PACK=zip
PACKFLAGS=-r
PACKNAME=HW1-dedominica.zip
PACKDIR=HW1/

all: doc
	
lex:
	cd $(CLEXDIR); \
	flex $(CLEX); \
	$(CC) $(CFILE) -o $(CNAME) $(CFLAG)

clean:
	cd $(CLEXDIR); \
	rm $(CFILE) $(CHEAD)

remove:
	cd $(CLEXDIR); \
	rm $(CNAME)

lex_test: lex
	cd $(CLEXDIR); \
	./lexer_hw1 ./text_syntax/syntax.txt

doc:
	$(DOC) $(DOCOBJ) -o $(DOCNAME) $(DOCFLAGS)

remove_doc:
	rm $(DOCNAME)

package: doc
	mkdir $(PACKDIR)
	cp -r $(DOCNAME) $(DOCOBJ) $(CLEXDIR) $(DOTGRAPHDIR) ./Makefile $(PACKDIR)
	$(PACK) $(PACKFLAGS) $(PACKNAME) $(PACKDIR)
	rm -rf $(PACKDIR)

remove_package:
	rm $(PACKNAME)
