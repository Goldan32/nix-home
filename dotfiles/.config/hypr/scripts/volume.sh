#!/bin/bash

# This script handles volume changes and sends a notification to dunst.
# To use: ./volume.sh up
#         ./volume.sh down
#         ./volume.sh mute

# Function to send a notification
send_notification() {
  # Check mute status
  is_muted=$(pamixer --get-mute)

  if [ "$is_muted" = "true" ]; then
    # If muted, show the muted icon and text
    dunstify -i audio-volume-muted -r "991049" -u low "Muted"
  else
    # If not muted, get volume and select an icon
    volume=$(pamixer --get-volume)
    if [ "$volume" -gt 66 ]; then
      icon="audio-volume-high"
    elif [ "$volume" -gt 33 ]; then
      icon="audio-volume-medium"
    elif [ "$volume" -gt 0 ]; then
      icon="audio-volume-low"
    else
      icon="audio-volume-muted"
    fi
    # Show the volume bar notification
    dunstify -i "$icon" -r "991049" -u low -h int:value:"$volume" "Volume: ${volume}%"
  fi
}

# Main logic
case $1 in
  up)
    # Unmute and increase volume by 5%
    pamixer -u
    pamixer -i 5
    send_notification
    ;;
  down)
    # Unmute and decrease volume by 5%
    pamixer -u
    pamixer -d 5
    send_notification
    ;;
  mute)
    # Toggle mute
    pamixer -t
    send_notification
    ;;
esac

