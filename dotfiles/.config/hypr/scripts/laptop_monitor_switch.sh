#!/bin/zsh

HYPR_CACHE="${HOME}/.cache/hypr"
mkdir -p "$HYPR_CACHE"

STATE="$HYPR_CACHE/laptop_monitor_state"

turn_off() {
    if [[ "$(hyprctl -j monitors show | jq 'length')" == 1 ]] && [[ "$(hyprctl -j monitors show | jq '.[0].name')" == "\"eDP-1\"" ]]; then
        exit 0
    fi
    hyprctl keyword monitor "eDP-1, disabled"
    echo 0 > "$STATE"
}

turn_on() {
    hyprctl keyword monitor "eDP-1, 1920x1200@60.00, 0x0, 1"
    echo 1 > "$STATE"
}

toggle() {
    if [[ ! -f "$STATE" ]] || [[ "$(cat "$STATE")" == "1" ]]; then
        turn_off
    else
        turn_on
    fi
}

init() {
    turn_on
}

if [[ $# -eq 0 ]]; then
    turn_on
    exit 0
fi

if [[ $# -ne 1 ]]; then
    exit 1
fi

case "$1" in
    "on")
        turn_on
    ;;
    "off")
        turn_off
    ;;
    "toggle")
        toggle
    ;;
    *)
        exit 1
    ;;
esac

exit 0
