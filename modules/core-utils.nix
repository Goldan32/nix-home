{ pkgs, dotfiles, ... }:
{
  _module.args.mkScript =
    name: pkgs.writeShellScriptBin name (builtins.readFile "${dotfiles}/.local/scripts/${name}.sh");
}
