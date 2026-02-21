{ config, lib, pkgs, jotter, system, dotfiles, ... }: 
{
  imports = [
    ../modules/de.nix
    ../modules/common.nix
    ../modules/rofi.nix
    ../modules/waybar.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";

  #
  # For some reason
  #
  home.stateVersion = "25.05";
}
