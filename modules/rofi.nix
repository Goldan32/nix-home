{ ... }:
let
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
    windowWidth = "60%";
    windowHeight = "60%";
    borderWidth = 2;
    borderRadius = 8;
  };

  normal = {
    fontSize = 12;
    windowPadding = 4;
    mainboxSpacing = 4;
    inputPadding = 4;
    inputRadius = 4;
    listSpacing = 4;
    elementPadding = 4;
    elementRadius = 4;
  };

  giant = {
    fontSize = 32;
    windowPadding = 12;
    mainboxSpacing = 12;
    inputPadding = 12;
    inputRadius = 12;
    listSpacing = 12;
    elementPadding = 12;
    elementRadius = 12;
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

  xdg.configFile."rofi/giant-rofi.rasi".source = builtins.toFile "giant-rofi.rasi" (mkTheme giant);
}
