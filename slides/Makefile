PROGS = 


##### (Pattern) RULES #####

%.dvi %.log : %.tex
	@if (egrep 'document(class|style)' $<); then echo "LaTeX file"; latex $<; else echo "TeX file"; tex $<; fi 
	rm -f $*.log

%.ps :  %.dvi 
	dvips -o $@ $<

%.ps :  %.pdf 
	pdf2ps $< $@

%.pdf : %.ps
	ps2pdf $< $@ 

2up%.ps : %.ps
	2psred $< 

##### TARGETS #####

default:
	@echo "Specify a target configuration"

label:
	dvips -m -p0 -o $@.label.ps -t landscape -O 0in,1.5in $@

clean:
	-rm -f *.ps *.dvi *.pdf

realclean: clean
	-rm -f $(PROGS).dvi $(PROGS).ps $(PROGS).pdf
	-rm -f *.log *~

clobber: clean
#	-rm -f *.log *.aux *.toc *~
	-rm -f *.log *.aux *.toc *.idx *.lof *.lot *.ind *.bbl *.blg *.ilg *~

targets: $(PROGS)

#include ../Make-config
#-include ./Makefile ./makefile

