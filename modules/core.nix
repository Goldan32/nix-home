{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hostname
    git
    gnutar
    file
    usbutils
    unzip
  ];

  programs.git-matr.enable = true;
}
