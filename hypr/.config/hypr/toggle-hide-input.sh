#!/bin/bash
# Toggle hide_input for hyprlock
# This script toggles between showing password as dots or actual text
# Usage: Called by hyprlock onclick handler
#
# Note: This briefly unlocks the screen to reload with new config

CONFIG_FILE="$HOME/.config/hypr/hyprlock.conf"

# Check current state of hide_input in the input-field block
if grep -q "hide_input = true" "$CONFIG_FILE"; then
    # Currently hiding input (showing dots), change to show text
    sed -i 's/hide_input = true/hide_input = false/' "$CONFIG_FILE"
    # Update eye icon to crossed-out (showing text)
    sed -i 's/text = 󰅁/text = 󰅂/' "$CONFIG_FILE"
elif grep -q "hide_input = false" "$CONFIG_FILE"; then
    # Currently showing input text, change to hide (show dots)
    sed -i 's/hide_input = false/hide_input = true/' "$CONFIG_FILE"
    # Update eye icon to open (showing dots)
    sed -i 's/text = 󰅂/text = 󰅁/' "$CONFIG_FILE"
else
    # Default: add hide_input = true to input-field block
    sed -i '/^input-field {$/,/^}$/ s/^    hide_input = .*/    hide_input = true/' "$CONFIG_FILE"
    if ! grep -q "hide_input" "$CONFIG_FILE"; then
        # Insert hide_input after size line
        sed -i '/^    size = /a\    hide_input = true' "$CONFIG_FILE"
    fi
    # Update eye icon to crossed-out
    sed -i 's/text = 󰅁/text = 󰅂/' "$CONFIG_FILE"
fi

# Restart hyprlock with new config
# Using pkill and restart to apply changes
pkill hyprlock
sleep 0.2
hyprlock
