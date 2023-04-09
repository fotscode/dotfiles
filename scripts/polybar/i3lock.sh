#!/bin/bash
rm /tmp/screenshot.png
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshot.png
i3lock -i /tmp/screenshot.png
