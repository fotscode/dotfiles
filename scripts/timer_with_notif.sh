#!/bin/bash
# suspend the system after a timer
# usage: timer_suspend.sh <minutes>
# display a timer when decrementing the seconds

# check if the argument is a number
if [[ $1 =~ ^[0-9]+$ ]]; then
    # convert minutes to seconds
    #seconds=$(( $1 * 60 ))
    seconds=$1
    # display the timer
    while [ $seconds -gt 0 ]; do
        ((h=${seconds}/3600))
        ((m=(${seconds}%3600)/60))
        ((s=${seconds}%60))
        printf " \r%02d:%02d:%02d\n" $h $m $s > "$HOME/.config/scripts/timer_with_notif.txt"
        sleep 1
        : $((seconds--))
    done
    # suspend the system
    printf "Finished\n" > "$HOME/.config/scripts/timer_with_notif.txt"
    notify-send "Timer finished" --icon "$HOME/Pictures/art/vanitas_still_life.jpg" 
else
    echo "Usage: timer_with_notif.sh <seconds>"
fi