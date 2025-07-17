{ config
, pkgs
, lib
, flake
, ... }:

{
  imports = [
    flake.inputs.mac-app-util.homeManagerModules.default
    ./default.nix
  ];

  home.username = "lukasbocker";
  home.homeDirectory = lib.mkForce "/Users/lukasbocker";
}
