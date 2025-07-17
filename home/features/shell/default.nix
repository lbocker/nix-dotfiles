{ pkgs, ... }: {

  home.packages = with pkgs; [
    fzf
    fd
    bat
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      # Overwrite default ctrl+r history-pager
      fzf_configure_bindings
    '';

    # workaround for fixing the path order: https://github.com/LnL7/nix-darwin/issues/122
    shellInit = ''
      # Homebrew config
      set -gx HOMEBREW_PREFIX "/opt/homebrew";
      set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
      set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
      ! set -q PATH; and set PATH \'\'; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
      ! set -q MANPATH; and set MANPATH \'\'; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
      ! set -q INFOPATH; and set INFOPATH \'\'; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

      # Volta
      set -gx VOLTA_HOME $HOME/.volta
      fish_add_path $VOLTA_HOME/bin

      # Go Binaries
      fish_add_path $GOPATH/bin

      # MySQL
      fish_add_path /opt/homebrew/opt/mysql-client/bin

      # XDG Config Home
      set -gx XDG_CONFIG_HOME $HOME/.config
    '';

    plugins = [
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file = { 
    ".config/starship.toml".source = ./starship.toml;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  home.shellAliases = {
    "cat" = "bat -pp";
    "python" = "python3";
    "pip" = "pip3";
    "cdcore" = "cd $HOME/work/sbp/Components/Core";
    "cdfrontend" = "cd $HOME/work/sbp/Components/Frontend";
    "cdaccount" = "cd $HOME/work/sbp/Components/Account2";
    "ls" = "eza --icons --group --group-directories-first";
    "ll" = "eza --icons --group --group-directories-first -l";
  };
}
