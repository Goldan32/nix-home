#!/usr/bin/env bash

CWD_FILE="$HOME/.cache/wezterm_cwd"
WEZTERM_BIN="wezterm --config-file $HOME/.config/wezterm/wezterm-hyprland.lua"

# Check if the active window is WezTerm and if our state file exists.
if [[ $(hyprctl activewindow -j | jq -r '.class') =~ "wezterm" ]] && [[ -f "$CWD_FILE" ]]; then
    # Read the CWD from the file instead of running a slow command.
    CWD=$(cat "$CWD_FILE")

    if [[ -n "$CWD" && -d "$CWD" ]]; then
        $WEZTERM_BIN start --cwd "$CWD"
    else
        $WEZTERM_BIN start --cwd "$HOME" # Fallback
    fi
else
    # Not WezTerm or no file, launch normally.
    $WEZTERM_BIN start --cwd "$HOME"
fi
