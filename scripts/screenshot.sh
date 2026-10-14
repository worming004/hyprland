#!/bin/bash
# Screenshot script: region select, save to ~/Pictures/screenshots, copy to clipboard

mkdir -p ~/Pictures/screenshots

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILE="$HOME/Pictures/screenshots/screenshot_${TIMESTAMP}.png"

grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE" && notify-send "Screenshot saved" "$FILE"
