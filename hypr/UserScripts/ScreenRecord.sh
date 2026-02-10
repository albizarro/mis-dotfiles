#!/bin/bash
# Screen Recording Script for Hyprland using wf-recorder
# Save to @[UserScripts]/ScreenRecord.sh

# Variables
VIDEOS_DIR="$HOME/Videos/ScreenRecords"
LOG_FILE="$HOME/.cache/screenrecord.log"

# Create directory if it doesn't exist
mkdir -p "$VIDEOS_DIR"

# Check if wf-recorder is installed
if ! command -v wf-recorder &> /dev/null; then
    notify-send "Screen Record" "wf-recorder not found. Please install it." -u critical
    exit 1
fi

# Check if already recording
if pgrep -x "wf-recorder" > /dev/null; then
    # Stop recording
    # Use SIGINT to allow wf-recorder to finalize the file properly
    pkill -INT wf-recorder
    
    # Wait a moment for the process to exit
    # sleep 1
    
    notify-send "Screen Record" "Recording stopped.\nSaved to $VIDEOS_DIR" -u normal -i video-x-generic
else
    # Detect the focused monitor to record
    # Try using jq if available for reliable JSON parsing
    if command -v jq &> /dev/null; then
        OUTPUT=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
    else
        # Fallback to text parsing
        # Find the block with 'focused: yes' and get the Monitor name from the header
        OUTPUT=$(hyprctl monitors | grep -B 11 "focused: yes" | grep "Monitor" | awk '{print $2}')
    fi

    # Fallback default if detection failed
    if [ -z "$OUTPUT" ]; then
        OUTPUT=$(hyprctl monitors | grep "Monitor" | head -n 1 | awk '{print $2}')
    fi

    # Start recording
    FILENAME="Recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
    FILEPATH="$VIDEOS_DIR/$FILENAME"
    
    notify-send "Screen Record" "Recording started on $OUTPUT..." -u low -i media-record
    
    # Run in background with specific output
    # -o specifies the output (monitor) to record
    wf-recorder -o "$OUTPUT" -f "$FILEPATH" &> "$LOG_FILE" &
fi
