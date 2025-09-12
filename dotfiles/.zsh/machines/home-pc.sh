switch-audio() {
    local HEADPHONE='alsa_output.usb-HP__Inc_HyperX_Cloud_III_000000000000-00.iec958-stereo'
    local SPEAKER='alsa_output.pci-0000_0d_00.3.iec958-stereo'
    case "$1" in
        "headphone")
            pactl set-default-sink "$HEADPHONE"
        ;;
        "speaker")
            pactl set-default-sink "$SPEAKER"
        ;;
    esac
}
