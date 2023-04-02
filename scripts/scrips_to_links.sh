#!/bin/bash
filename=$(basename -- "$0")
arr=("$(ls $HOME/.config/scripts/global | grep -v ".txt$")")
[[ -d "$HOME/.local/bin" ]] || mkdir -p "$HOME/.local/bin"
for i in $arr
do 
  ln -s "$HOME/.config/scripts/global/$i" "$HOME/.local/bin/$i"
done

