{
  description = "Ubuntu Home Manager config";

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
	      ripgrep
	      gcc
	      stow
	      tree
            ];

            programs.zsh.enable = true;
            programs.git.enable = true;

            home.file.".zshrc" = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/.zshrc";
            };
          
            home.activation.linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              CURDIR="$(pwd)"
              cd "${config.home.homeDirectory}/nix-home/dotfiles" && \
              ${pkgs.stow}/bin/stow --no-folding -t "$HOME" .
              cd "$CURDIR"
            '';

            home.stateVersion = "25.05"; # Adjust to current HM release
          }
        ];
      };
    };
}
