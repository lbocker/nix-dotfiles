{ pkgs, ... }:

let
  lib = pkgs.lib;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{

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

    shellInit = ''
      # Nix profile paths
      fish_add_path $HOME/.nix-profile/bin
      fish_add_path /etc/profiles/per-user/$USER/bin
      fish_add_path /run/current-system/sw/bin
      fish_add_path /nix/var/nix/profiles/default/bin

      # Host-local dotfiles scripts
      set -l dotfiles_host ""
      set -l dotfiles_host_alias_file "$HOME/.config/nix-dotfiles/.local/host-alias"

      if test -n "$DOTFILES_HOST_ALIAS"
        set dotfiles_host $DOTFILES_HOST_ALIAS
      else if test -f "$dotfiles_host_alias_file"
        set dotfiles_host (string trim -- (command cat "$dotfiles_host_alias_file"))
      end

      if test -z "$dotfiles_host"
        set dotfiles_host (hostname -s 2>/dev/null)
      end

      if test -z "$dotfiles_host"
        set dotfiles_host (hostname)
      end

      set -gx DOTFILES_HOST_ALIAS $dotfiles_host

      set -l dotfiles_host_bin "$HOME/.config/nix-dotfiles/systems/$dotfiles_host/bin"
      if test -d "$dotfiles_host_bin"
        fish_add_path --prepend "$dotfiles_host_bin"
      end
    '' + lib.optionalString isDarwin ''
      # Homebrew config
      set -gx HOMEBREW_PREFIX "/opt/homebrew";
      set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
      set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
      ! set -q PATH; and set PATH \'\'; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
      ! set -q MANPATH; and set MANPATH \'\'; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
      ! set -q INFOPATH; and set INFOPATH \'\'; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
    '' + ''
      # Go Binaries
      fish_add_path $GOPATH/bin

      # Krew
      fish_add_path $HOME/.krew/bin

      # Cargo
      fish_add_path $HOME/.cargo/bin

      # XDG Config Home
      set -gx XDG_CONFIG_HOME $HOME/.config
    '' + lib.optionalString isDarwin ''
      # MySQL
      fish_add_path /opt/homebrew/opt/mysql-client/bin
    '' + ''

      # Mise
      if command -q mise
        mise activate fish | source
      end
    '';

    plugins = [
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];

    functions = {
      c = ''
        set DIR (zoxide query -l | fzf)
        z $DIR
      '';
      t = ''
        tmux attach -t "$(tmux ls -F '#{session_name}:#{window_name}' | fzf)"
      '';
    };
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
    "cdaccount" = "cd $HOME/work/sbp/Components/Account";
    "find" = "fd";
    "grep" = "rg";
    "k" = "kubectl";
    "ls" = "eza --icons --group --group-directories-first";
    "ll" = "eza --icons --group --group-directories-first -l";
  };
}
