{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.enable = true;
  networking.hostName = "t3kl4";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.syncthing = {
    enable = true;
    user = "cheryllamb";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
    dataDir = "/home/cheryllamb/.syncthing/data";
    configDir = "/home/cheryllamb/.syncthing/config";
    settings.folders."engram-raw" = {
      path = "/home/cheryllamb/engram-data/raw";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
  ];
  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      git
      python313
    ];
    initialHashedPassword = "$y$j9T$Gr446qulQ0U51PTb0aJog1$UTxOM8SaTVsk2zKt0aSST8IXfdNeDj5rPzVwG8.BBH2";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
    ];
  };

  services.caddy = {
    enable = true;

    virtualHosts."http://t3kl4".extraConfig = ''
      bind 0.0.0.0
      root * /var/www/engram
      file_server
    '';
  };

  systemd.services.caddy.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = ["/home/cheryllamb/engram-data"];
  };

  systemd.tmpfiles.rules = [
    "d /var/www 0755 cheryllamb users -"
    "d /var/www/engram 0755 cheryllamb users -"
  ];
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [80];

  nix.settings.trusted-users = ["root" "cheryllamb"];

  system.stateVersion = "25.11";
}
