{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fluffychat
    # element-desktop # disabled due to keyring issues
  ];
}
