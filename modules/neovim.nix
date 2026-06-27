{ pkgs, neovim-nightly-overlay, ... }:

{
  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;

    # your existing config goes here, e.g.:
    # viAlias = true;
    # vimAlias = true;
    # extraLuaConfig = ''
    #   -- whatever you had
    # '';
    # plugins = with pkgs.vimPlugins; [ ... ];
  };
}
