{ pkgs, flake, ... }: {

  home.packages = with pkgs; [
    flake.inputs.devenv.packages.${system}.devenv
    cachix

    nixpkgs-fmt
    sops

    _1password-cli
    jq
    gnused
    ripgrep
    unixtools.watch
    nmap
    htop
    coreutils
    pigz
    ssm-session-manager-plugin
    wget
    uv
    claude-code

    nodejs_24

    act

    istioctl
    docker-client
    docker-buildx
    dive
    bun
    gh
  ];
}

