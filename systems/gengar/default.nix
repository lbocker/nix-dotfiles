{ pkgs
, home-manager
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

  users.users.lukasbocker = {
    home = "/Users/lukasbocker";
    shell = "${pkgs.fish}/bin/fish";
  };

  home-manager.users.lukasbocker = {
    imports = [
      ../../home/gengar.nix
    ];
  };

  environment.systemPackages = with pkgs; [
    raycast
  ];

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  environment.shells = [ "${pkgs.fish}/bin/fish" ];

  documentation.enable = false;
  documentation.man.enable = true;

  time.timeZone = "Europe/Berlin";

  nix.enable = false;
}
