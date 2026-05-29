{
  pkgs,
  inputs,
  config,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs inputs self; };
  cursorPkg = pkgs.catppuccin-cursors.mochaDark;
  cursorName = "catppuccin-mocha-dark-cursors";
  cursorSize = 24;
in
{
  home.username = "berzi";
  home.homeDirectory = "/home/berzi";

  home.file.".face".source = "${self}/assets/profile.jpg";

  imports = [
    "${self}/home/hyprland"
    "${self}/home/programs/browsers/firefox.nix"
    "${self}/home/programs/ghostty.nix"
    "${self}/home/programs/fastfetch.nix"
    "${self}/home/programs/terminal/zoxide.nix"
    "${self}/home/programs/editors/zed.nix"
    "${self}/home/programs/discord.nix"

    "${self}/system/shell/zsh.nix"

    inputs.nixcord.homeModules.nixcord
  ];

  home.packages = allPackages;

  home.stateVersion = "25.05";

  home.sessionVariables = {
    EDITOR = "hx";
    NH_FLAKE = "/home/${config.home.username}/nixos";

    XCURSOR_THEME = cursorName;
    XCURSOR_SIZE = cursorSize;
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  home.pointerCursor = {
    package = cursorPkg;
    name = cursorName;
    size = cursorSize;
    x11.enable = true;
    gtk.enable = true;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  gtk.gtk4.theme = config.gtk.theme;

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };
}
