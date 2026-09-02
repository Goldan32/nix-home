{ config, lib, pkgs, system, ... }:
{
  home.packages = with pkgs; [
    rofi
    firefox
    roboto-mono
    wezterm
    pamixer
    vlc
    thunar
    grim
    dracula-theme
    hyprpaper
    papers
    qimgv
    playerctl
    obsidian
    slurp
    signal-desktop
    fzf
    nerd-fonts.roboto-mono
    waybar
    blueman
    ripdrag
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "obsidian"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };

  gtk.gtk4.theme = config.gtk.theme;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "papers";
      "image/jpeg" = "qimgv";
      "image/png" = "qimgv";
      "image/gif" = "qimgv";
      "image/bmp" = "qimgv";
      "image/webp" = "qimgv";
      "image/tiff" = "qimgv";
      "image/svg+xml" = "qimgv";
      "image/heic" = "qimgv";
      "image/heif" = "qimgv";
      "image/avif" = "qimgv";
      "image/x-portable-pixmap" = "qimgv";
      "image/x-portable-graymap" = "qimgv";
      "image/x-portable-bitmap" = "qimgv";
      "image/x-portable-anymap" = "qimgv";
      "image/jp2" = "qimgv";
      "image/vnd.ms-photo" = "qimgv";
      "image/x-icon" = "qimgv";
      "application/epub+zip" = "calibre";
    };
  };
}

