{ config, lib, pkgs, jotter, system, ... }: {
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
    stow
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

  ];

  programs.zsh.enable = false;
  programs.git.enable = false;

  #
  # Dotfiles
  #
  home.file.".zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-home/dotfiles/.zshrc";
  };

  home.activation.linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    CURDIR="$(pwd)"
    cd "${config.home.homeDirectory}/nix-home/dotfiles" && \
    ${pkgs.stow}/bin/stow --no-folding -t "$HOME" .
    cd "$CURDIR"
  '';

  home.activation.batCacheBuild = lib.hm.dag.entryAfter [ "linkDotfiles" ] ''
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
