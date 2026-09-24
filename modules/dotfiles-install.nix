{
  lib,
  pkgs,
  dotfiles,
  ...
}:
let
  configDirs = builtins.attrNames (builtins.readDir "${dotfiles}/.config");

  blacklist = [ "Code" ];
  filteredConfigDirs = lib.filter (dir: !(builtins.elem dir blacklist)) configDirs;

  configAttrs = builtins.listToAttrs (
    map (dir: {
      name = ".config/${dir}";
      value = {
        source = "${dotfiles}/.config/${dir}";
        recursive = true;
      };
    }) filteredConfigDirs
  );
in
{
  home.file = lib.mkMerge [
    configAttrs
    {
      ".zshrc".source = "${dotfiles}/.zshrc";
      ".zsh/machines".source = "${dotfiles}/.zsh/machines";
      ".zsh/patches".source = "${dotfiles}/.zsh/patches";
      ".zsh/scripts".source = "${dotfiles}/.zsh/scripts";
      ".local/scripts".source = "${dotfiles}/.local/scripts";
      ".local/start-page".source = "${dotfiles}/.local/start-page";
    }
  ];

  home.activation.batCacheBuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';
}
