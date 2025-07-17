{ pkgs
, home-manager
, flake
, lib
, config
, ...
}: {
  imports = [
    ../shared/aerospace.nix
    ../shared/brew.nix
    ../shared/system.nix
    ../shared/fonts.nix
  ];

  system.stateVersion = 5;
  system.primaryUser = "lukasbocker";

  ids.gids.nixbld = 30000;

  users.users."lukasbocker" = {
    home = "/Users/lukasbocker";
    shell = "${pkgs.fish}/bin/fish";
  };

  home-manager.users."lukasbocker" = {
    imports = [
      ../../home/gengar.nix
    ];
  };

  environment.systemPackages = with pkgs; [
    raycast
  ];

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  environment.shells = [ "${pkgs.fish}/bin/fish" ];

  documentation.enable = false;
  documentation.man.enable = true;

  time.timeZone = "Europe/Berlin";

  nix.settings = {
    trusted-users = [ "root" "lukasbocker" ];
    trusted-substituters = [
      "https://cachix.cachix.org"
      "https://nixpkgs.cachix.org"
    ];
    trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}
