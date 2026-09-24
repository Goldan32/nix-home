{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wezterm
    roboto-mono
    nerd-fonts.roboto-mono
  ];
}
