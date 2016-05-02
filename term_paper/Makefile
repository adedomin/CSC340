DOC=pandoc
DOCFLAGS=--filter pandoc-citeproc
DOCNAME=term-dedominica.pdf
DOCOBJ=*.md

all: doc
	
doc:
	$(DOC) $(DOCOBJ) -o $(DOCNAME) $(DOCFLAGS)

remove:
	rm $(DOCNAME)
