{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    jotter.url = "github:Goldan32/jotter/0.4.2";
    jotter.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      jotter,
      dotfiles,
      neovim-nightly-overlay,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (nixpkgs) lib;

      hosts = [
        "pc"
        "zenbook"
        "server"
        "vm"
      ];
    in
    {
      homeConfigurations = lib.genAttrs hosts (
        host:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit
              jotter
              system
              dotfiles
              neovim-nightly-overlay
              ;
          };
          modules = [ ./hosts/${host}.nix ];
        }
      );

      hmModules = lib.genAttrs hosts (host: ./hosts/${host}.nix);
    };
}
