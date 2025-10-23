{ config, lib, pkgs, jotter, system, dotfiles, ... }: 
let
  git-matr = import ../modules/matr.nix { inherit pkgs; };

  configDirs = builtins.attrNames (builtins.readDir "${dotfiles}/.config");

  blacklist = [ "Code" ];
  filteredConfigDirs = lib.filter (dir: !(builtins.elem dir blacklist)) configDirs;

  configAttrs = builtins.listToAttrs (map (dir: {
    name = ".config/${dir}";
    value = {
      source = "${dotfiles}/.config/${dir}";
      recursive = true;
    };
  }) filteredConfigDirs);
in
{
  home.packages = with pkgs; [
    git-matr
    hostname
    acpi

    git
    zsh
    gnumake
    htop
    gcc
    tree
    gnutar
    cmake
    ninja
    gettext
    pkg-config
    unzip
    sqlite
    dunst
    fd

    neovim
    ripgrep
    stylua
    bash-language-server
    typescript-language-server
    prettier
    pyright
    shellcheck

    cargo
    bat
    jotter.packages.${system}.default
    cargo-generate

    nodejs
    typescript
    nodenv

    zoxide
    jq
    wl-clipboard
    fastfetch
    file
    bmaptool
  ];

  #
  # Dotfiles
  #
  home.file = lib.mkMerge [
    configAttrs
    {
      ".zshrc".source = "${dotfiles}/.zshrc";
      ".zsh/machines".source = "${dotfiles}/.zsh/machines";
      ".zsh/patches".source = "${dotfiles}/.zsh/patches";
      ".zsh/scripts".source = "${dotfiles}/.zsh/scripts";
      ".local/scripts".source = "${dotfiles}/.local/scripts";
      ".local/start-page".source = "${dotfiles}/.local/start-page";
      ".local/bin/switch-audio".source = "${dotfiles}/.local/scripts/switch-audio.sh";
    }
  ];

  home.activation.batCacheBuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';
}
