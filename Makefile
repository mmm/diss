PROGS = 
#CHAPTERS = chapter-intro.tex chapter-statDist.tex
CHAPTERS = $(wildcard chapters/chapter-*.tex)
BIBS = $(CHAPTERS:.tex=.bib)
LOG = build.log


##### (Pattern) RULES #####

#%.dvi %.log : %.tex
#	@if (egrep 'document(class|style)' $<); then echo "LaTeX file"; latex $<; else echo "TeX file"; tex $<; fi 
#	rm -f $*.log
#
%.ps :  %.dvi 
	dvips -o $@ $<

%.ps :  %.pdf 
	pdf2ps $< $@

%.pdf : %.ps
	ps2pdf $< $@ 

2up%.ps : %.ps
	2psred $< 

##### TARGETS #####

default: main.dvi

main.dvi: main.aux main.bbl main.ind
	@echo "--- dvi ---"
	@echo "--- dvi ---" >> $(LOG)
	@latex main >> $(LOG) 

main.bbl: main.aux $(BIBS)
	@echo "--- bbl ---"
	@echo "--- bbl ---" >> $(LOG)
	@( cat $(BIBS) > tmpdiss.bib )
	@bibtex main >> $(LOG)  # generates bbl file
	@latex main >> $(LOG)  # generates new aux file
	@latex main >> $(LOG)  # resolves crossrefs
	@rm -f tmpdiss.bib

main.ind: main.idx
	@echo "--- ind ---"
	@echo "--- ind ---" >> $(LOG)
	@makeindex main >> $(LOG) 2>&1 # generates ind file
	@latex main >> $(LOG)    # latex includes index

main.aux main.idx: main.tex $(CHAPTERS)
	@echo "--- aux ---"
	@echo "--- aux ---" >> $(LOG)
#	@latex main >> $(LOG)
	@latex main 

label:
	dvips -m -p0 -o $@.label.ps -t landscape -O 0in,1.5in $@

clean:
	-rm -f *.ps *.dvi *.pdf

realclean: clean
	-rm -f $(PROGS).dvi $(PROGS).ps $(PROGS).pdf
	-rm -f *.log *~

clobber: clean
#	-rm -f *.log *.aux *.toc *~
	-rm -f *.log *.aux *.toc *.idx *.lof *.lot *.ind *.bbl *.blg *.ilg *~ chapters/*~

targets: $(PROGS)

#include ../Make-config

