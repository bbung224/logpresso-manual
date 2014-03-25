pandoc ^
1.1.araqne_core.md ^
1.2.webserver.md ^
1.3.license.md ^
1.4.benchmark.md ^
2.1.client_tools.md ^
--toc --toc-depth=2 --template=cli.tex --latex-engine=xelatex -V geometry:"top=3.5cm, bottom=3.5cm, left=2.5cm, right=2.5cm" -s -o logpresso_cli_manual.pdf