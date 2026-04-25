{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/hardware.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System version
  system.stateVersion = "23.11";
}
