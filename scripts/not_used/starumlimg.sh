#!/bin/bash
file="$1"
if [[ $# -le 0 || $# -gt 2 ]];
then
  echo "MDJ to img"
  echo "Usage: starumlimg <mdj_filename> [<out_filename>]"
  exit 1
fi
resultName="out.png"
if [[ $# -eq 2 ]];
then
  resultName="$2"
fi
dir="/tmp/png${file%.*}"
mkdir "$dir" 2> /dev/null
staruml html "$1" &>/dev/null
mv "html-docs" "$dir"
cat "${dir}/html-docs/diagrams/"$(ls "${dir}/html-docs/diagrams") | xmllint --format - | awk '!/UNREGISTERED/ {print}' > out.svg
convert out.svg "$resultName"
rm out.svg
rm -r "${dir}"
