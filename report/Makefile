all : tex

tex: dir
	pdflatex -output-directory=work report.tex;

bib:
	@cd work;\
	ln -sf ../bib_group01.bib . ;\
	ln -sf ../ecmi_bib.bst . ;\
	bibtex report.aux

dir:
	mkdir -p work

compressed :
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=work/report-compressed.pdf work/report.pdf

clean :
	@rm -rf ./work;
	@rm -rf *.log *.bbl *.aux
