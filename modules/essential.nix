{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh
    gnumake
    htop
    tree
    fd
    bat
    zoxide
    wl-clipboard
    fastfetch
    imagemagick
  ];
}
