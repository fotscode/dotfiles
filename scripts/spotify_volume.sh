#!/bin/bash
[[ $# -ne 1 ]] && echo "Usage: $0 (up/down)" && exit 1
spotify=$(pacmd list-sink-inputs | grep Spotify -B 15 | grep index | tail -1 | cut -d ":" -f2 | sed 's/[[:space:]]*//g')
step=5
case $1 in
up)
    pactl set-sink-input-volume "$spotify" +${step}%
    ;;
down)
    pactl set-sink-input-volume "$spotify" -${step}%
    ;;
esac
