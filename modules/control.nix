{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    pavucontrol
    acpi
    pamixer
    playerctl
  ];
}
