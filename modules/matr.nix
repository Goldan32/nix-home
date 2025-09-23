{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "git-matr";
  version = "0.1.0";

  src = pkgs.fetchgit {
    url = "https://github.com/Goldan32/git-matr.git";
    rev = "303b957bc9f7614f7d92db51d465148f8c57d78f";
    sha256 = "sha256-CCu24T/pMIc5EKZBhmPLC7ZFZbZ1sToaGPJOKo0JK3g=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp matr.py $out/bin/matr
    chmod +x $out/bin/matr
  '';
}
