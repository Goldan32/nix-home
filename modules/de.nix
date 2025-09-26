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
      # Restart = "always";
      # RestartSec = 5;
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };
}

