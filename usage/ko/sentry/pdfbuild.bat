pandoc sentry.md --toc --toc-depth=3 --template=cli.tex --latex-engine=xelatex -V geometry:"top=3.5cm, bottom=3.5cm, left=2.5cm, right=2.5cm" --variable fontsize=10.5pt -s -o logpresso_query_manual.pdf