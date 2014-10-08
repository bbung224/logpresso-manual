OUTPUTFILE=logpresso_cli_manual

MDFILES=$(shell ls -1 [0-9]*.md | sort -t. -k1,1n -k2,2n)

all: html pdf

html: ${OUTPUTFILE}.html

pdf: ${OUTPUTFILE}.pdf

${OUTPUTFILE}.html: ${MDFILES}
	pandoc ${MDFILES} --toc --toc-depth=2 -s -c css/logpresso.css -o $@

${OUTPUTFILE}.pdf: ${MDFILES} cli.tex
	pandoc ${MDFILES} --toc --toc-depth=2 --template=cli.tex --latex-engine=xelatex -V geometry:"top=3.5cm, bottom=3.5cm, left=2.5cm, right=2.5cm" -s -o $@

clean:
	rm -f logpresso_cli_manual.html
	rm -f logpresso_cli_manual.pdf
