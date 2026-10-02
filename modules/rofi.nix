{ pkgs, ... }:
let
  normalRasi = ''
    * {
      background-color: transparent;
      text-color: #D9DCE3;
      margin: 0px;
      padding: 0px;
      spacing: 0px;
    }

    window {
      location: center;
      width: 520px;
      background-color: #18191CEE;
      border: 1px;
      border-color: #30343C;
      border-radius: 18px;
    }

    mainbox {
      padding: 14px;
    }

    inputbar {
      background-color: #222429;
      border: 1px;
      border-color: #343842;
      border-radius: 14px;
      padding: 10px 16px;
      spacing: 10px;
      children: [ prompt, entry ];
    }

    prompt {
      text-color: #78A9E8;
    }

    entry {
      placeholder: "Search";
      placeholder-color: #666C78;
      text-color: #F4F5F7;
    }

    listview {
      background-color: transparent;
      margin: 12px 0px 0px;
      lines: 8;
      columns: 1;
      fixed-height: false;
      spacing: 4px;
    }

    element {
      padding: 9px 12px;
      spacing: 10px;
      border-radius: 10px;
      background-color: transparent;
    }

    element-text {
      text-color: inherit;
      vertical-align: 0.5;
    }

    element-icon {
      size: 1.15em;
      vertical-align: 0.5;
    }

    element selected {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected normal {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected active {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected alternate {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element normal active,
    element alternate active {
      text-color: #78A9E8;
    }

    message {
      margin: 12px 0px 0px;
      padding: 0px;
      border: 1px;
      border-color: #343842;
      border-radius: 12px;
      background-color: #2A2D33;
    }

    textbox {
      padding: 8px 16px;
      text-color: #AEB4BF;
    }

    scrollbar {
      handle-width: 4px;
      handle-color: #78A9E8;
      background-color: transparent;
      border: 0px;
    }
  '';

  giantRasi = ''
    * {
      background-color: transparent;
      text-color: #D9DCE3;
      margin: 0px;
      padding: 0px;
      spacing: 0px;
    }

    window {
      location: center;
      width: 900px;
      background-color: #18191CEE;
      border: 2px;
      border-color: #30343C;
      border-radius: 28px;
    }

    mainbox {
      padding: 28px;
    }

    inputbar {
      background-color: #222429;
      border: 2px;
      border-color: #343842;
      border-radius: 22px;
      padding: 18px 24px;
      spacing: 16px;
      children: [ prompt, entry ];
    }

    prompt {
      text-color: #78A9E8;
      font: "Sans 24";
    }

    entry {
      placeholder: "Search";
      placeholder-color: #666C78;
      text-color: #F4F5F7;
      font: "Sans 24";
    }

    listview {
      background-color: transparent;
      margin: 20px 0px 0px;
      lines: 8;
      columns: 1;
      fixed-height: false;
      spacing: 8px;
    }

    element {
      padding: 16px 20px;
      spacing: 18px;
      border-radius: 16px;
      background-color: transparent;
    }

    element-text {
      text-color: inherit;
      vertical-align: 0.5;
      font: "Sans 20";
    }

    element-icon {
      size: 2em;
      vertical-align: 0.5;
    }

    element selected {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected normal {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected active {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element selected alternate {
      background-color: #78A9E8;
      text-color: #1B2028;
    }

    element normal active,
    element alternate active {
      text-color: #78A9E8;
    }

    message {
      margin: 20px 0px 0px;
      padding: 0px;
      border: 2px;
      border-color: #343842;
      border-radius: 18px;
      background-color: #2A2D33;
    }

    textbox {
      padding: 12px 20px;
      text-color: #AEB4BF;
      font: "Sans 18";
    }

    scrollbar {
      handle-width: 6px;
      handle-color: #78A9E8;
      background-color: transparent;
      border: 0px;
    }
  '';

in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

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

  xdg.dataFile."rofi/themes/normal.rasi".text = normalRasi;
  xdg.dataFile."rofi/themes/giant-rofi.rasi".text = giantRasi;
}
