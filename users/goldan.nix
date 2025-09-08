{ config, lib, pkgs, jotter, system, ... }: 
let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/Goldan32/dotfiles";
    rev = "f78ae30dbe6c3cd3a0dd7c73e768d9f3ee1bc392";
  };

  # automatically collect subdirs from dotfiles/config/
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
  home.username = "goldan";
  home.homeDirectory = "/home/goldan";

  # Basic example: install some packages
  home.packages = with pkgs; [
    # Used to be apt
    git
    zsh
    gnumake
    htop
    cowsay
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

    # Neovim and co.
    neovim
    ripgrep
    stylua
    bash-language-server
    typescript-language-server
    prettier
    pyright
    shellcheck

    # Cargo packages
    cargo
    bat
    jotter.packages.${system}.default
    cargo-generate

    # NodeJS related
    nodejs
    typescript
    nodenv

    # Other
    firefox
    roboto-mono
    wezterm
    zoxide

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
    }
  ];

  home.activation.batCacheBuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  #
  # Dunst service
  #
  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst Notification Daemon";
      After = "default.target";
    };
    Install.WantedBy = ["default.target"];
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.dunst}/bin/dunst";
      # Restart = "always";
      # RestartSec = 5;
    };
  };

  #
  # For some reason
  #
  home.stateVersion = "25.05";
}
