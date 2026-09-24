{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    firefox
    vlc
    thunar
    grim
    dracula-theme
    papers
    qimgv
    slurp
  ];

  wayland.windowManager.hyprland = {
    configType = "hyprlang";
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
    enable = true;
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };
}
