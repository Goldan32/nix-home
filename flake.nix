{
  description = "Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    jotter.url = "github:Goldan32/jotter/0.4.2";
    jotter.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles.url = "path:./dotfiles";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, jotter, dotfiles, zen-browser, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations.goldan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit zen-browser jotter system dotfiles neovim-nightly-overlay; };
        modules = [
          ./users/goldan.nix
        ];
      };
      homeConfigurations.headless = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit jotter system dotfiles neovim-nightly-overlay; };
        modules = [
          ./users/headless.nix
        ];
      };
      hmModules.goldan = ./users/goldan.nix;
      hmModules.headless = ./users/headless.nix;
    };
}
