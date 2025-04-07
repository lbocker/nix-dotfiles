{ sops
, config
, pkgs
, ...
}: {
  sops = {
    age.keyFile = "${
    if pkgs.stdenv.hostPlatform.isDarwin
    then "/Users/kevin/Library/Application Support/sops/age/keys.txt"
    else "/home/kevin/.config/sops/age/keys.txt"
    }";

    defaultSopsFile = ./secrets.yaml;

    secrets.ssh_key = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa";
      format = "yaml";
      mode = "0600";
    };
  };

}
