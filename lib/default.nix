{ self, nixpkgs, nixpkgs-unstable, ... }:

let
  lists = {
    mapModules = tree: builtins.mapAttrs (name: path: import path { inherit self; }) tree;
    concatModules = builtins.concatLists;
  };

  combineModules = tree: let
    mods = lists.mapModules tree;
    paths = builtins.attrValues mods;
  in builtins.foldl' (a: b: a // b) {} paths;

  mergeModules = modules:
    builtins.foldl' (a: b: a // b) {} modules;

  types = {
    module = { imports = []; };
  };

in {
  inherit lists combineModules mergeModules types;

  nixpkgs = nixpkgs;
  nixpkgs-unstable = nixpkgs-unstable;
}