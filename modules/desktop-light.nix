{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    thunar
    qimgv
  ];

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };
}
