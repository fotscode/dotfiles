#!/bin/bash
FILE_EXT="pdf|mkv|mp4|mp3|epub|jpeg|jpg|png|gif|opus|m4a"
FZF_COLORS="bg:#282C34,bg+:#2e3139,hl:#707070,prompt:#c678dd,fg+:#abb2bf,fg:#abb2bf,pointer:#c678dd,hl+:#c678dd,info:#e5c07b,border:#c678dd,spinner:#61afef"
OLD_PWD="."

if [[ -d "$1" ]];
then
    OLD_PWD=`pwd`
    cd "$1"

fi
ACTUAL_PWD=`pwd`
USER=`whoami`
NEW_PROMPT=${ACTUAL_PWD/\/home\/$USER/'~'}
res=`fdfind -H | fzf -i --prompt="$NEW_PROMPT/" --info=inline --reverse --border --preview='batcat --style=numbers --color=always --line-range :500 {}' --color "$FZF_COLORS"`

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

