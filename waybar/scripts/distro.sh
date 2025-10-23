#!/bin/bash
echo '{
  "text": "Uptime: '"$(uptime -p)"'",
  "tooltip": "System info:\n'"$(uname -a)"'",
  "class": ["info"],
  "percentage": 75
}'
