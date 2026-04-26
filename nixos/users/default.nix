{ self }:

{
  description = "Users configuration";

  nixosModule = { config, pkgs, ... }: {
    virtualisation.docker.enable = true;

    users.users.berzi = {
      isNormalUser = true;
      description = "ayush";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        firefox
      ];
    };
  };
}