#!/bin/zsh
# Return the name of the config to be pulled

HOSTNAME="$(hostname)"

CONF_ROOT="${HOME}/.config/hypr/machines"

HYPR_CACHE="${HOME}/.cache/hypr"
mkdir -p "$HYPR_CACHE"

MONITOR_CONF_FILE="$HYPR_CACHE/monitors.conf"

if [[ "$HOSTNAME" == "pc" ]]; then
    cat "$CONF_ROOT/${HOSTNAME}.conf" > "$MONITOR_CONF_FILE"
    exit 0
fi

cat "$CONF_ROOT/${(L)$(cat /sys/class/dmi/id/product_family | cut -d ' ' -f 1)}.conf" > "$MONITOR_CONF_FILE"

exit 0
