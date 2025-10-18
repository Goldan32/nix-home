{ config, lib, pkgs, system, ... }:
{
  home.packages = with pkgs; [
    wofi
    firefox
    roboto-mono
    wezterm
    pamixer
    vlc
    xfce.thunar
    grim
    dracula-theme
    hyprpaper
    papers
    qimgv
  ];

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
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
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
    };
  };
}

