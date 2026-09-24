{ pkgs, neovim-nightly-overlay, ... }:
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    withRuby = false;
    withPython3 = false;
  };

  home.packages = with pkgs; [
    tree-sitter
    ripgrep
  ];
}
