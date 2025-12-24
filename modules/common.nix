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
    clang

    neovim
    ripgrep
    stylua
    lua-language-server
    bash-language-server
    typescript-language-server
    svelte-language-server
    prettierd
    pyright
    shellcheck
    rust-analyzer
    rustfmt
    clang-tools

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
    rclone
    rsync
    imagemagick
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
