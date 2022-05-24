#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

i=0
if type "xrandr"; then
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  let i++
  MONITOR=$m polybar --reload mon$i &
  echo $m
  echo mon$i
done
else
 polybar --reload mon1 &
 polybar --reload mon2 &
fi
