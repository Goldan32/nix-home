{ config, pkgs, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;

  colloidTheme = {
    "*" = {
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "#D9DCE3";
      margin = 0;
      padding = 0;
      spacing = 0;
    };

    window = {
      location = mkLiteral "center";
      width = mkLiteral "520px";
      background-color = mkLiteral "#18191CEE";
      border = mkLiteral "1px";
      border-color = mkLiteral "#30343C";
      border-radius = mkLiteral "18px";
    };

    mainbox = {
      padding = mkLiteral "14px";
    };

    inputbar = {
      background-color = mkLiteral "#222429";
      border = mkLiteral "1px";
      border-color = mkLiteral "#343842";
      border-radius = mkLiteral "14px";
      padding = mkLiteral "10px 16px";
      spacing = mkLiteral "10px";
      children = [
        (mkLiteral "prompt")
        (mkLiteral "entry")
      ];
    };

    prompt = {
      text-color = mkLiteral "#78A9E8";
    };

    entry = {
      placeholder = "Search";
      placeholder-color = mkLiteral "#666C78";
      text-color = mkLiteral "#F4F5F7";
    };

    listview = {
      background-color = mkLiteral "transparent";
      margin = mkLiteral "12px 0px 0px";
      lines = 8;
      columns = 1;
      fixed-height = false;
      spacing = mkLiteral "4px";
    };

    element = {
      padding = mkLiteral "9px 12px";
      spacing = mkLiteral "10px";
      border-radius = mkLiteral "10px";
      background-color = mkLiteral "transparent";
    };

    "element-text" = {
      text-color = mkLiteral "inherit";
      vertical-align = mkLiteral "0.5";
    };

    "element-icon" = {
      size = mkLiteral "1.15em";
      vertical-align = mkLiteral "0.5";
    };

    "element selected" = {
      background-color = mkLiteral "#78A9E8";
      text-color = mkLiteral "#1B2028";
    };

    "element selected normal" = {
      background-color = mkLiteral "#78A9E8";
      text-color = mkLiteral "#1B2028";
    };

    "element selected active" = {
      background-color = mkLiteral "#78A9E8";
      text-color = mkLiteral "#1B2028";
    };

    "element selected alternate" = {
      background-color = mkLiteral "#78A9E8";
      text-color = mkLiteral "#1B2028";
    };

    "element normal active" = {
      text-color = mkLiteral "#78A9E8";
    };

    "element alternate active" = {
      text-color = mkLiteral "#78A9E8";
    };

    message = {
      margin = mkLiteral "12px 0px 0px";
      padding = 0;
      border = mkLiteral "1px";
      border-color = mkLiteral "#343842";
      border-radius = mkLiteral "12px";
      background-color = mkLiteral "#2A2D33";
    };

    textbox = {
      padding = mkLiteral "8px 16px";
      text-color = mkLiteral "#AEB4BF";
    };

    scrollbar = {
      handle-width = mkLiteral "4px";
      handle-color = mkLiteral "#78A9E8";
      background-color = mkLiteral "transparent";
      border = 0;
    };
  };

in
{
  programs.rofi = {
    enable = true;

    package = pkgs.rofi;

    theme = colloidTheme;

    font = "Sans 11";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      matching = "normal";
      case-sensitive = false;
      normalize-match = true;
      max-history-size = 25;
      icon-theme = "Adwaita";
    };
  };
}
