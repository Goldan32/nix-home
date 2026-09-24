{ ... }:
{
  imports = [
    ../modules/control.nix
    ../modules/core-utils.nix
    ../modules/core.nix
    ../modules/desktop-light.nix
    ../modules/devtools.nix
    ../modules/dotfiles-install.nix
    ../modules/essential.nix
    ../modules/firefox-full.nix
    ../modules/jellyfin-client.nix
    ../modules/matr.nix
    ../modules/neovim.nix
    ../modules/rofi.nix
    ../modules/terminal.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";
  home.stateVersion = "25.05";

  devtools.languages = [
    "bash"
    "nix"
    "cmdtools"
    "python"
  ];
}
