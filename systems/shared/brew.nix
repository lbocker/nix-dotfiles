{ pkgs
, ...
}: {

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "aws/tap"
    ];

    brews = [
      "docker-credential-helper"
      "mysql-client"
      "ollama"
      "gettext"
      "mise"
      "lazygit"
    ];

    casks = [
      "orbstack"
      "hammerspoon"
      "gitify"
      "babeledit"
      "spotify"
      "logi-options+"
      "cursor"
      "jetbrains-toolbox"
      "yaak"
    ];
  };
}
