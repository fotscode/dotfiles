#!/bin/bash
set -e

TMPDIR=/tmp/hyprlock
mkdir -p "$TMPDIR"

# Get monitor names
MONITORS=($(hyprctl monitors -j | jq -r '.[].name'))

# 1️⃣ Take screenshots in parallel
printf "%s\n" "${MONITORS[@]}" | parallel -j0 grim -o {} "$TMPDIR/{}.png"

# 3️⃣ Launch hyprlock
hyprlock &

sleep 2

systemctl suspend
