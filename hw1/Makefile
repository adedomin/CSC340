DOC=pandoc
DOCFLAGS=
DOCNAME=hw3-dedominica.pdf
DOCOBJ=ch1.md ch3.md ch4.md figures.md

PACK=zip
PACKFLAGS=-r
PACKNAME=HW3-dedominica.zip
PACKDIR=HW3/

all: doc
	
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
