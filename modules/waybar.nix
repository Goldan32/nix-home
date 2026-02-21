{ config, pkgs, lib, ... }:
let
  waybarCmd = "${pkgs.waybar}/bin/waybar "
    + "--config ${config.xdg.configHome}/waybar/config.jsonc "
    + "--style ${config.xdg.configHome}/waybar/style.css";
in
{
  # Ensure waybar is installed
  home.packages = [ pkgs.waybar ];

  # Autostart via systemd user service
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = waybarCmd;
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
