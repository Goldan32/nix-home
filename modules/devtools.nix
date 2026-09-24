{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.devtools;

  tools = with pkgs; {
    lua = [
      lua
      stylua
      lua-language-server
    ];
    rust = [
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
      cargo-generate
    ];
    c = [
      clang
      cmake
      clang-tools
      ninja
      pkg-config
      xmake
    ];
    python = [
      uv
      pyright
    ];
    nix = [
      nil
      nixfmt
    ];
    bash = [
      bash-language-server
      shellcheck
    ];
    dbtools = [
      sqlite
    ];
    javascript = [
      nodejs
      typescript
      typescript-language-server
      nodenv
      prettierd
      svelte-language-server
    ];
    cmdtools = [
      jq
      bmaptool
    ];
    debug = [
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];
  };
in
{
  options.devtools.languages = lib.mkOption {
    type = lib.types.listOf (lib.types.enum (lib.attrNames tools));
    default = [ ];
    example = [
      "lua"
      "rust"
    ];
    description = "Language development tools installed.";
  };

  config.home.packages = lib.unique (lib.concatMap (lang: tools.${lang}) cfg.languages);
}
