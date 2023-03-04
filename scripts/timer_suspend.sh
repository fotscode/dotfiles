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
        printf " \r%02d:%02d:%02d\n" $h $m $s > "$HOME/.config/scripts/timer_suspend.txt"
        sleep 1
        : $((seconds--))
    done
    # suspend the system
    printf "Suspending\n" > "$HOME/.config/scripts/timer_suspend.txt"
    i3lock-fancy-dualmonitor -gf DejaVu-Sans && systemctl suspend 
else
    echo "Usage: timer_suspend.sh <minutes>"
fi
