{ lib, ... }:

{
  description = "NixOS modules organized by category";

  outputs = { self, ... }: let
    tree = {
      hardware = import ./hardware { inherit self; };
      boot = import ./boot { inherit self; };
      networking = import ./networking { inherit self; };
      desktop = import ./desktop { inherit self; };
      users = import ./users { inherit self; };
      packages = import ./packages { inherit self; };
    };
  in {
    modules = lib.lists.mapModules tree;
    nixosModule = lib.combineModules tree;
  };
}