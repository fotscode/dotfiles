#!/bin/bash
filename=$(basename -- "$0")
arr=("$(ls $XDG_CONFIG_HOME/scripts/global | grep -v ".txt$")")
[[ -d "$XDG_CONFIG_HOME/.local/bin" ]] || mkdir -p "$XDG_CONFIG_HOME/.local/bin"
for i in $arr
do 
  ln -s "$XDG_CONFIG_HOME/scripts/global/$i" "$XDG_CONFIG_HOME/.local/bin/$i"
done

