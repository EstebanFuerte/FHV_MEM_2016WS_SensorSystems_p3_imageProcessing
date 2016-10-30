@echo off
set mode=batchmode
echo Start

echo Latex
latex -aux-directory=build Bachelorarbeit
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 

echo bibtex
bibtex -terse build/Bachelorarbeit
bibtex -terse build/Bachelorarbeit

echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 

echo Glossaries
makeglossaries -q -d build Bachelorarbeit
echo Glossaries
makeglossaries -q -d build Bachelorarbeit

echo PDFLatex
pdflatex --output-directory=build  -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 

echo bibtex
bibtex -terse build/Bachelorarbeit 
bibtex -terse build/Bachelorarbeit

echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 
echo PDFLatex
pdflatex --output-directory=build -quiet -synctex=1 -interaction=%mode% * 

echo Done
