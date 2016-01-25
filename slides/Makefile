all : tex

tex: dir
	pdflatex -output-directory=work slides.tex;

dir:
	mkdir -p work

compressed :
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=tmp/slides-compressed.pdf tmp/slides.pdf

clean :
	@rm -rf ./work;
	@rm -rf *.log *.bbl *.aux
