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
    ];

    casks = [
      "orbstack"
      "hammerspoon"
      "gitify"
      "warp"
      "notion"
      "babeledit"
      "spotify"
      "logi-options+"
    ];
  };
}
