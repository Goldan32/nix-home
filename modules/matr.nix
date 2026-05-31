{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "git-matr";
  version = "0.2.0";

  src = pkgs.fetchgit {
    url = "https://github.com/Goldan32/git-matr.git";
    rev = "cfa3fba9b7fc2241cf796af59ee50aaa0415046e";
    sha256 = "sha256-4mPoyb+te2VD8grx6JG5EqjAIS99WfAAr9rXhQtKPNI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp matr.py $out/bin/matr
    chmod +x $out/bin/matr
  '';
}
