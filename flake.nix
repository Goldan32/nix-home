{
  description = "Ubuntu Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    jotter.url = "github:Goldan32/jotter?ref=0.4.1";
    jotter.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, jotter, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations.goldan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit jotter system; };
        modules = [ 
          ./users/goldan.nix 
        ];
      };

      hmModules.goldan = ./users/goldan.nix;
    };
}
