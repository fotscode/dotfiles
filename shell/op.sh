#!/bin/bash
FILE_EXT="pdf|mkv|mp4|mp3|epub|jpeg|jpg|png|gif|opus|m4a"
FZF_COLORS="bg:#282C34,bg+:#282c34,hl:#e06c75,prompt:#E5C07B,fg+:#61afef,fg:#abb2bf,pointer:#e06c75,hl+:#c678dd,info:#98c379"
OLD_PWD="."

if [[ -d "$1" ]];
then
    OLD_PWD=`pwd`
    cd "$1"
fi

res=`fdfind -H | fzf --color "$FZF_COLORS"`

if [[ -d $res ]]; 
then   
    cd "$res"
elif [[ "$res" =~ .($FILE_EXT)$ ]];
then
    xdg-open "$res" &> /dev/null &disown 
elif [[ -f "$res" ]];
then
    vim "$res"
else
    cd $OLD_PWD
fi

