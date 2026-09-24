{ ... }:
{
  imports = [
    ../modules/core-utils.nix
    ../modules/core.nix
    ../modules/devtools.nix
    ../modules/dotfiles-install.nix
    ../modules/essential.nix
    ../modules/neovim.nix
    ../modules/terminal.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";
  home.stateVersion = "25.05";

  devtools.languages = [
    "c"
    "bash"
    "nix"
    "dbtools"
    "cmdtools"
    "python"
  ];
}
