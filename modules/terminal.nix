{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    roboto-mono
    nerd-fonts.roboto-mono
  ];
}
