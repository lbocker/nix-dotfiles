{ pkgs, ... }: {

  home.packages = with pkgs; [
    delta
  ];

  programs.git = {
    enable = true;
    package = pkgs.git;
    lfs = {
      enable = true;
    };

    userName = "lbocker";
    userEmail = "l.boecker@shopware.com";

    signing.key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiWpk7HselMlV3bTrerZbv4Ej3PdKfqDk0FNzZ0y+bwaXURXYRCIma4Iq6/xAG+Xd92nZOXs8oJmg0mUTXrSnVzqf8/4NpFLh6X6WxSmnNBTkEDP8ffC3A6VsdFItGSazwKmDe4oxTseAGNWNO5Uh0MuFby7hgEC+iQNYTtMYAqk56ZOToKmJYNrgxde8Hky3iqW4VcdLF5Q0q4VP89HWcxWmlyueUvceNOM2iZThYCbPW9QY7Zh+70LvAfto9HMGR+H5h6JSp4lf7wlYdAKhq5Y7DF6G2oMFk9ZnSLjY/HKe/ZIVf35k0crT+h+JwQmQTDfuupOmWshHsaSq6HKPuuOvMw8PygezylaD/rWNehjfU7vcLAps09zStlvdKuzwoaUew7VsXB2LTf+9OBMeBrAOsRF39GefHFR6CGR2rQCqrimVO6Tf5gjlNCE+Q5dQKXbZg1NXKHnGw/eKZwi0hwDdB92FAZatbRr8IxIhlTcEKrW/1+xJEc4IbUZCX/YU=";
    signing.signByDefault = true;

    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      push.default = "simple";
      fetch.prune = true;

      gpg.format = "ssh";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      git = {
        overrideGpg = true;
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };

  home.file = {
    ".ssh/allowed_signers".text = "l.boecker@shopware.com namespaces=\"git\" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiWpk7HselMlV3bTrerZbv4Ej3PdKfqDk0FNzZ0y+bwaXURXYRCIma4Iq6/xAG+Xd92nZOXs8oJmg0mUTXrSnVzqf8/4NpFLh6X6WxSmnNBTkEDP8ffC3A6VsdFItGSazwKmDe4oxTseAGNWNO5Uh0MuFby7hgEC+iQNYTtMYAqk56ZOToKmJYNrgxde8Hky3iqW4VcdLF5Q0q4VP89HWcxWmlyueUvceNOM2iZThYCbPW9QY7Zh+70LvAfto9HMGR+H5h6JSp4lf7wlYdAKhq5Y7DF6G2oMFk9ZnSLjY/HKe/ZIVf35k0crT+h+JwQmQTDfuupOmWshHsaSq6HKPuuOvMw8PygezylaD/rWNehjfU7vcLAps09zStlvdKuzwoaUew7VsXB2LTf+9OBMeBrAOsRF39GefHFR6CGR2rQCqrimVO6Tf5gjlNCE+Q5dQKXbZg1NXKHnGw/eKZwi0hwDdB92FAZatbRr8IxIhlTcEKrW/1+xJEc4IbUZCX/YU=";
  };
}
