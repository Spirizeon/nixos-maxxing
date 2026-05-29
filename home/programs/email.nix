{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fastmail-desktop
    protonmail-desktop
  ];
}
