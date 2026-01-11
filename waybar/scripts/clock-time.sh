#!/bin/bash

# Get current time
TIME=$(TZ="America/Argentina/Buenos_Aires" date '+%T %p')

# Get tooltip with multiple timezones
TOOLTIP=$(~/.config/waybar/scripts/timezones.sh)

# Use python to properly escape JSON
python3 -c "
import json
import sys
time = sys.argv[1]
tooltip = sys.argv[2]
print(json.dumps({'text': time, 'tooltip': tooltip}))
" "$TIME" "$TOOLTIP"
