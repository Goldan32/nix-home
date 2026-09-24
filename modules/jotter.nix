{ jotter, system, ... }:
{
  home.packages = [
    jotter.packages.${system}.default
  ];
}
