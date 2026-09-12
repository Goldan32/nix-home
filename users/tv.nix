{ config, lib, pkgs, jotter, system, dotfiles, ... }: 
{
  imports = [
    ../modules/de-light.nix
    ../modules/common.nix
    ../modules/rofi.nix
    ../modules/neovim.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";

  #
  # For some reason
  #
  home.stateVersion = "25.05";
}
