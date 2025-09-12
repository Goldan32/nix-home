#!/bin/bash

[ -d "$HOME/.wallpaper" ] || exit 0

[ -n "$( ls -A "$HOME/.wallpaper" )" ] || exit 0

WPP="$HOME/.wallpaper/$(ls -t "$HOME/.wallpaper" | head -n 1)"

swaybg -i "$WPP" -m fill

