#!/bin/bash

# Get current time in local timezone
LOCAL_TIME=$(TZ="America/Argentina/Buenos_Aires" date '+%Y-%m-%d %H:%M:%S %Z')

# Define timezones to display (name:timezone pairs)
declare -a TZ_LIST=(
    "UTC/GMT:UTC"
    "PDT/PST (Pacific):America/Los_Angeles"
    "EST/EDT (Eastern):America/New_York"
    "CST/CDT (Central):America/Chicago"
    "MST/MDT (Mountain):America/Denver"
    "JST (Japan):Asia/Tokyo"
    "CST (China):Asia/Shanghai"
    "IST (India):Asia/Kolkata"
    "GMT/BST (London):Europe/London"
    "CET/CEST (Central Europe):Europe/Paris"
    "AEST/AEDT (Sydney):Australia/Sydney"
    "BRT (Brasília):America/Sao_Paulo"
)

# Build tooltip content
TOOLTIP+="<b>Local (Buenos Aires):</b> $LOCAL_TIME\n\n"
TOOLTIP+="<b>Other Timezones:</b>\n"

# Get current timestamp
CURRENT_EPOCH=$(date +%s)

# Display each timezone
for TZ_ENTRY in "${TZ_LIST[@]}"; do
    TZ_NAME="${TZ_ENTRY%%:*}"
    TZ_VALUE="${TZ_ENTRY##*:}"
    
    # Try GNU date first (Linux), then BSD date (macOS)
    TIME=$(TZ="$TZ_VALUE" date -d "@$CURRENT_EPOCH" '+%H:%M:%S %Z (%Y-%m-%d)' 2>/dev/null || \
           TZ="$TZ_VALUE" date -r "$CURRENT_EPOCH" '+%H:%M:%S %Z (%Y-%m-%d)' 2>/dev/null)
    
    if [ -n "$TIME" ]; then
        TOOLTIP+="<tt>$TZ_NAME:</tt> $TIME\n"
    fi
done

echo -e "$TOOLTIP"

