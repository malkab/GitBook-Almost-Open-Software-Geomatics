#!/bin/bash

# Prepare images
mogrify -resize 650x650 -path 05-Primeros_pasos/Images/Resizes/ 05-Primeros_pasos/Images/Originals/*.png

# # To HTML
# pandoc -s -f markdown_github Proposal.md -o Proposal.html

# # To PDF
# pandoc -s --include-in-header=nohyphenation -f markdown_github Proposal.md -o Proposal.pdf

# # To Word
# pandoc -s -f markdown_github -t docx Proposal.md -o Proposal.docx
