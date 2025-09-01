{
  description = "My Ubuntu Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations.goldan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = "goldan";
            home.homeDirectory = "/home/goldan";

            # Basic example: install some packages
            home.packages = with pkgs; [
              neovim
              htop
              cowsay
            ];

            programs.zsh.enable = true;
            programs.git.enable = true;

            # Always recommended
            home.stateVersion = "24.05"; # Adjust to current HM release
          }
        ];
      };
    };
}
