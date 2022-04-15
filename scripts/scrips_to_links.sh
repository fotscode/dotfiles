#!/bin/bash
filename=$(basename -- "$0")
arr=("$(ls $XDG_CONFIG_HOME/scripts | grep -v "$filename")")
for i in $arr
do 
  ln -s "$XDG_CONFIG_HOME/scripts/$i" "$i"
done

