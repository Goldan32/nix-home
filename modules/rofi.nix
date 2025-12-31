{ config, lib, pkgs, system, ... }: {
  programs.rofi = {
    enable = true;
    theme = builtins.toFile "rofi-theme.rasi" ''
      * {
        bg: #1e1e1e;
        bg-alt: #262626;
        fg: #e0e0e0;
        fg-alt: #a0a0a0;
        border: #3a3a3a;
        selected: #3f3f3f;
      }
  
      window {
        background-color: @bg;
        border: 2px;
        border-color: @border;
        border-radius: 8px;
        width: 40%;
      }
  
      inputbar {
        background-color: @bg-alt;
        padding: 8px;
        border-radius: 6px;
      }
  
      element selected {
        background-color: @selected;
      }
    '';
  };
}
