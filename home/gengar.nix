{ lib, inputs, ... }:

{
  imports = [
    inputs.mac-app-util.homeManagerModules.default
    ./default.nix
  ];

  home.username = "lukasbocker";
  home.homeDirectory = lib.mkForce "/Users/lukasbocker";
}
