{
  description = "NixOS configuration with dendritic flake structure";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix
            git
          ];
        };
      }
    ) // {
      nixosConfigurations = import ./hosts self;
      nixosModules = {
        boot = (import ./nixos/boot/default.nix { inherit self; }).nixosModule;
        hardware = (import ./nixos/hardware/default.nix { inherit self; }).nixosModule;
        networking = (import ./nixos/networking/default.nix { inherit self; }).nixosModule;
        desktop = (import ./nixos/desktop/default.nix { inherit self; }).nixosModule;
        packages = (import ./nixos/packages/default.nix { inherit self; }).nixosModule;
        users = (import ./nixos/users/default.nix { inherit self; }).nixosModule;
      };

      lib = {
        nixpkgs = nixpkgs;
        nixpkgs-unstable = nixpkgs-unstable;
      };

      templates = {
        default = {
          path = ./templates;
          description = "NixOS flake templates";
        };
      };
    };
}