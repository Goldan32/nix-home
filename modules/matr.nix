{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "git-matr";
  version = "0.2.0";

  src = pkgs.fetchgit {
    url = "https://github.com/Goldan32/git-matr.git";
    rev = "15bc40aba900afb5fa78dbf6ec8c2330aa25aa6f";
    sha256 = "sha256-t3ORVt5gy/5XI3cHPmHi/tXT4H6+Jwb4XtO64UQpi6Y=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp matr.py $out/bin/matr
    chmod +x $out/bin/matr
  '';
}
