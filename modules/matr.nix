{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "git-matr";
  version = "0.1.0";

  src = pkgs.fetchgit {
    url = "https://github.com/Goldan32/git-matr.git";
    rev = "fb3629fab1495e46ba81354be26142176b95db17";
    sha256 = "sha256-YffJGeD/zeLacNI37WgqaOR72HkGLdDkpUYDbB5A+cY=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp matr.py $out/bin/matr
    chmod +x $out/bin/matr
  '';
}
