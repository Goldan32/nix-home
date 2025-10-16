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
    };
  };
}

