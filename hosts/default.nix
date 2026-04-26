{
  description = "Host configurations";

  outputs = { self, ... }: let
    pkgs = import self.inputs.nixpkgs {
      system = "x86_64-linux";
    };
  in {
    berzilinux = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.boot
        self.nixosModules.hardware
        self.nixosModules.networking
        self.nixosModules.desktop
        self.nixosModules.packages
        self.nixosModules.users

        ({ pkgs, ... }: {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          nixpkgs.config.allowUnfree = true;
          system.stateVersion = "23.11";
        })
      ];
    };
  };
}