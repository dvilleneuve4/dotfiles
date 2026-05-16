#!/bin/sh
# Rotate wallpapers on each display at a set interval.
# This script continuously cycles through wallpapers, assigning a different
# random image to each connected display.
#
# Usage:
#   ./rotate_wallpapers.sh [DIRECTORY] [INTERVAL]
#
# Arguments:
#   DIRECTORY   Directory containing wallpaper images (default: ~/.local/share/awww/wallpapers)
#   INTERVAL    Time between rotations in seconds (default: 300 = 5 minutes)
#
# Example:
#   ./rotate_wallpapers.sh ~/.local/share/awww/wallpapers 300
#   ./rotate_wallpapers.sh  # Uses defaults

DEFAULT_INTERVAL=300  # 5 minutes in seconds
WALLPAPER_DIR="${1:-$HOME/.local/share/awww/wallpapers}"
INTERVAL="${2:-$DEFAULT_INTERVAL}"

# Validate directory
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory does not exist: $WALLPAPER_DIR" >&2
    exit 1
fi

# Transition settings
export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-60}"
export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"
RESIZE_TYPE="crop"  # or "fit" for non-cropped

# Infinite loop for continuous rotation
while true; do
    # Find all image files and add random prefixes for shuffling
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jpeg" \) \
    | while read -r img; do
        # Generate random sort key
        echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
    done \
    | sort -n | cut -d':' -f2- \
    | while read -r img; do
        # Get all connected displays
        for d in $(awww query 2>/dev/null | awk '{print $2}' | sed s/://); do
            # If no more images, re-shuffle by breaking out of inner loop
            [ -z "$img" ] && if read -r img; then true; else break 2; fi
            
            # Set wallpaper on this display
            awww img --resize "$RESIZE_TYPE" --transition-type random --outputs "$d" "$img"
            unset -v img  # Each image should only be used once per loop
        done
        
        # Wait for the specified interval before next rotation
        sleep "$INTERVAL"
    done
done
