pattern="pptx"
dir=""
[[ $# -eq 1 ]] && dir="$1"
readarray -t files < <(find $dir | grep $pattern)
for a in "${files[@]}"
do
  libreoffice --convert-to pdf "$a"
done

