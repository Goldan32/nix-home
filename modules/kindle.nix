{ mkScript, ... }:
{
  home.packages = [
    (mkScript "kindle")
  ];
}
