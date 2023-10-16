#!/bin/bash
# cd to directory of tex file
dir="$(dirname "$1")"
cd "$dir" || exit
latex_file="$(basename "$1")"

command=("pdflatex" "-interaction=batchmode" "$latex_file")
docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$dir":/data "blang/latex" "${command[@]}"

# remove extension
latex_file="${latex_file%.*}"
mv "$latex_file.aux" "$latex_file.log" "$latex_file.out" "$dir/logs"
