{ config, pkgs, lib, ... }:
{
  home.packages = [ pkgs.dunst ];

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst Notification Daemon";
      After = "default.target";
    };
    Install.WantedBy = ["default.target"];
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
  };

}
