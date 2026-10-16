{ ... }:
{
  imports = [
    ../groups/full.nix
    ../modules/signal.nix
    ../modules/godot.nix
  ];

  home.username = "goldan";
  home.homeDirectory = "/home/goldan";
  home.stateVersion = "25.05";

  devtools.languages = [
    "lua"
    "rust"
    "c"
    "bash"
    "nix"
    "dbtools"
    "cmdtools"
    "python"
    "debug"
  ];
}
