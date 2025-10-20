{ config, lib, pkgs, jotter, system, dotfiles, ... }: 
{
  imports = [
    ../modules/common.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";

  #
  # For some reason
  #
  home.stateVersion = "25.05";
}
