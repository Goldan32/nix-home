{ config, lib, pkgs, system, ... }:
let
  # Shared color palette — used by both theme files
  colors = ''
    * {
      bg: #1e1e1e;
      bg-alt: #262626;
      fg: #e0e0e0;
      fg-alt: #a0a0a0;
      border: #3a3a3a;
      selected: #3f3f3f;
    }
  '';

  fontFamily = "Roboto Mono";

  fixed = {
    windowWidth  = "60%";
    windowHeight = "60%";
    borderWidth  = 2;   # px
    borderRadius = 8;   # px
  };

  normal = {
    fontSize       = 12;  # pt
    windowPadding  = 4;  # px
    mainboxSpacing = 4;   # px
    inputPadding   = 4;   # px
    inputRadius    = 4;   # px
    listSpacing    = 4;   # px
    elementPadding = 4;   # px
    elementRadius  = 4;   # px
  };

  giant = {
    fontSize       = 32;  # pt
    windowPadding  = 12;  # px
    mainboxSpacing = 12;  # px
    inputPadding   = 12;  # px
    inputRadius    = 12;  # px
    listSpacing    = 12;  # px
    elementPadding = 12;  # px
    elementRadius  = 12;  # px
  };

  mkTheme = v: ''
    ${colors}
    * {
      font: "${fontFamily} ${toString v.fontSize}";
    }

    window {
      background-color: @bg;
      border: ${toString fixed.borderWidth}px;
      border-color: @border;
      border-radius: ${toString fixed.borderRadius}px;
      width: ${fixed.windowWidth};
      height: ${fixed.windowHeight};
      padding: ${toString v.windowPadding}px;
    }

    mainbox {
      spacing: ${toString v.mainboxSpacing}px;
    }

    inputbar {
      background-color: @bg-alt;
      padding: ${toString v.inputPadding}px;
      border-radius: ${toString v.inputRadius}px;
    }

    listview {
      spacing: ${toString v.listSpacing}px;
    }

    element {
      padding: ${toString v.elementPadding}px;
      border-radius: ${toString v.elementRadius}px;
    }

    element selected {
      background-color: @selected;
    }
  '';
in
{
  programs.rofi = {
    enable = true;
    theme = builtins.toFile "rofi-theme.rasi" (mkTheme normal);
  };

  xdg.configFile."rofi/giant-rofi.rasi".source =
    builtins.toFile "giant-rofi.rasi" (mkTheme giant);
}
