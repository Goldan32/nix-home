{ config, pkgs, lib, ... }:
let
  waybarCmd = "${pkgs.waybar}/bin/waybar "
    + "--config ${config.xdg.configHome}/waybar/config.jsonc "
    + "--style ${config.xdg.configHome}/waybar/style.css";
in
{
  home.packages = [ pkgs.waybar ];

  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
      StartLimitIntervalSec = 0;
    };
    Service = {
      ExecStart = waybarCmd;
      Restart = "always";
      RestartSec = 2;
      Environment = [ "WAYLAND_DISPLAY=wayland-1" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
