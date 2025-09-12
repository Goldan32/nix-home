#!/bin/bash


# Get acpi output
ACPI_OUTPUT=$(acpi 2>&1)

if echo "$ACPI_OUTPUT" | grep "No support"; then
    PERCENTAGE="No battery"
    PLUGGED_IN="Yes"
else
    PERCENTAGE=$(echo "$ACPI_OUTPUT" | grep -oP '\d+%' | head -1)
    if echo "$ACPI_OUTPUT" | grep -q 'Charging\|Full'; then
        PLUGGED_IN="Yes"
    else
        PLUGGED_IN="No"
    fi
fi

TODAY="$(date '+%Y %B %d')"
TIME="$(date '+%H:%M')"

MESSAGE="Time:              $TIME
Date:              $TODAY
Plugged in:   $PLUGGED_IN
Battery:          $PERCENTAGE
"

dunstify -r 1225 "Time and battery" "$MESSAGE" -u low -t 20000

