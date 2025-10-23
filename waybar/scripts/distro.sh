#!/bin/bash
up="$(uptime -p | awk '
{
    for(i=2;i<=NF;i++){
        if($i ~ /day/) printf "%dd ", $(i-1);
        else if($i ~ /hour/) printf "%dh ", $(i-1);
        else if($i ~ /minute/) printf "%dm ", $(i-1);
    }
    print ""
}')"
distro="$(neofetch --off| grep OS | cut -d' ' -f2- | sed -r 's/\x1B\[[0-9;]*[mK]//g')"
kernel="$(neofetch --off| grep Kernel | cut -d' ' -f2- | sed -r 's/\x1B\[[0-9;]*[mK]//g')"

echo "{
  "$up"| "$distro"| "$kernel"
}"
