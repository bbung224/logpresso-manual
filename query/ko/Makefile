include server*.mk

OUTPUTFILE=logpresso_query_manual

MDFILES=$(shell ls -1 [0-9]*.md | sort -t. -k1,1n -k2,2n -k3,3n)
LOCALE=$(shell basename $(realpath .))

all: html pdf

html: ${OUTPUTFILE}.html

pdf: ${OUTPUTFILE}.pdf

tex: ${OUTPUTFILE}.tex

upload: html
	scp -r -P${SSH_PORT} ${OUTPUTFILE}.html css/logpresso.css ${SSH_USER_N_HOST}:${REMOTE_DOCROOT}/query/latest/${LOCALE}

${OUTPUTFILE}.html: ${MDFILES}
	pandoc ${MDFILES} --toc --toc-depth=3 -s -c css/logpresso.css -o $@

${OUTPUTFILE}.pdf: ${MDFILES} cli.tex
	pandoc ${MDFILES} --toc --toc-depth=3 --template=cli.tex --latex-engine=xelatex -V geometry:"top=3.5cm, bottom=3.5cm, left=2.5cm, right=2.5cm" -s -o $@

${OUTPUTFILE}.tex: ${MDFILES} cli.tex
	pandoc ${MDFILES} --toc --toc-depth=3 --template=cli.tex --latex-engine=xelatex -V geometry:"top=3.5cm, bottom=3.5cm, left=2.5cm, right=2.5cm" -s -o $@

clean:
	rm -f ${OUTPUTFILE}.html
	rm -f ${OUTPUTFILE}.pdf
