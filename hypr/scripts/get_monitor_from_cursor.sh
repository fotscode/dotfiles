#!/bin/bash

# 1. Get cursor position
CURSOR_INFO=$(hyprctl cursorpos -j)
CURSOR_X=$(echo "$CURSOR_INFO" | jq -r '.x')
CURSOR_Y=$(echo "$CURSOR_INFO" | jq -r '.y')

# 2. Find the monitor using a single jq command and awk for float comparison

# JQ filters all monitors to find the one that contains the cursor coordinates.
# 
# Explanation of the JQ filter:
# .[] | selects each monitor object in the array.
# select( ( .x | tonumber ) <= $cx and ( .y | tonumber ) <= $cy and ... ):
#    This is the core logic. It checks if the cursor X and Y are within the monitor's 
#    bounds (x, y, width, height, and scale). Since jq can only do integer arithmetic
#    on scaled values, we use 'awk' for the final boundary check involving floats.
#
#    Note: JQ is used to construct the AWK command which is then executed.

MONITOR_NAME=$(
    hyprctl monitors -j | jq -r --argjson cx "$CURSOR_X" --argjson cy "$CURSOR_Y" '
        .[] |
        # Pass all necessary data to awk for precise float comparison
        .name + " " + (.x | tostring) + " " + (.y | tostring) + " " + (.width | tostring) + " " + (.height | tostring) + " " + (.scale | tostring)
    ' | awk -v cx="$CURSOR_X" -v cy="$CURSOR_Y" '
        {
            # Assign fields from JQ output
            mon_name = $1; 
            mon_x = $2; 
            mon_y = $3; 
            mon_width = $4; 
            mon_height = $5; 
            mon_scale = $6;
            
            # Calculate scaled dimensions and boundaries
            scaled_width = mon_width * mon_scale;
            scaled_height = mon_height * mon_scale;
            mon_right = mon_x + scaled_width;
            mon_bottom = mon_y + scaled_height;
            
            # Check boundaries
            if (cx >= mon_x && cx < mon_right && cy >= mon_y && cy < mon_bottom) {
                print mon_name;
                exit; # Exit immediately after finding the first match
            }
        }
    '
)

# 3. Output result
if [ -n "$MONITOR_NAME" ]; then
    echo "$MONITOR_NAME"
else
    echo "Monitor not found."
fi
