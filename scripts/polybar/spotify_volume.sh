#!/bin/bash
[[ $# -ne 1 ]] && echo "Usage: $0 (up/down)" && exit 1
spotify_res=$(pacmd list-sink-inputs | grep Spotify -B 18)
spotify=$(echo "$spotify_res" | grep index | tail -1 | cut -d ":" -f2 | sed 's/[[:space:]]*//g')
spotify_volume=$(echo "$spotify_res" | grep RUNNING -A 2 | grep volume | cut -d "/" -f2 | xargs | head -c 2)
step=5

# gets the metadata
res="$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)"
title="$(echo "$res" | sed -n "/title/{n;p}" | cut -d '"' -f2)"
artist="$(echo "$res"| sed -n "/artist/{n;n;p}" | cut -d '"' -f2)"
album="$(echo "$res" | sed -n "/album/{n;p}" | cut -d '"' -f2 | head -1)"
icon="$(echo "$res"  | sed -n "/artUrl/{n;p}" | cut -d '"' -f2)"

echo $icon | cut -d "/" -f5
# checks if the image is older than 5 seconds
seconds=0
[[ -f /tmp/spotify.png ]] && seconds=$(exiftool /tmp/spotify.png | grep "File Modification" | cut -d ":" -f5-6 | cut -d "-" -f1 | tr ":" ".")
current=$(date | cut -d ":" -f2-3 | cut -d " " -f1 | tr ":" ".")
resta=$(echo "$seconds-$current" | bc)
if [ $seconds -eq 0 ] || [ "$(echo "$resta < -0.05" | bc )" -eq 1 ] || [ "$(echo "$resta > 0" | bc )" -eq 1 ];
then
    curl -s "$icon" > /tmp/spotify.png
fi

case $1 in
up)
    pactl set-sink-input-volume "$spotify" +${step}%
    spotify_volume=$(echo "$spotify_volume+$step" | bc)
    ;;
down)
    pactl set-sink-input-volume "$spotify" -${step}%
    spotify_volume=$(echo "$spotify_volume-$step" | bc)
    ;;
esac

dunstify -u low -t 2000 -i /tmp/spotify.png "$title" "$artist - $album" -h int:value:"$spotify_volume" -r 12345
sleep 2 && dunstctl history-rm 12345
