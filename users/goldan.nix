{ config, lib, pkgs, jotter, system, dotfiles, zen-browser, ... }: 
{
  imports = [
    ../modules/de.nix
    ../modules/common.nix
    ../modules/rofi.nix
    ../modules/waybar.nix
    ../modules/dunst.nix
    ../modules/neovim.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";

  #
  # For some reason
  #
  home.stateVersion = "25.05";
}
