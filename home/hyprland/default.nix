{
  inputs,
  ...
}:

{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
    ./scripts.nix
    ./noctaliashell.nix
  ];
}
