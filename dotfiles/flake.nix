{
  description = "My dotfiles";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    # Example: expose your dotfiles as a package
    packages.x86_64-linux.dotfiles = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "dotfiles";
      src = self;
      installPhase = ''
        mkdir -p $out
        cp -r * $out/
      '';
    };
  };
}
