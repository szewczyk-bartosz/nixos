{pkgs, ...}: {
  imports = [
    ./disk.nix
    ./hardware.nix
    ../../modules/shared-system.nix
  ];
  system.stateVersion = "25.11";

  # BOOT
  boot.loader.grub.enable = true;

  # MIKOSHI OPTIONS

  #SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    git
    python313
  ];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialHashedPassword = "$y$j9T$Gr446qulQ0U51PTb0aJog1$UTxOM8SaTVsk2zKt0aSST8IXfdNeDj5rPzVwG8.BBH2";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAHaK1ZfIKnemj7B5ZB8FBgJHi17R9fAvVfw9cZjbuU cheryllamb@m1k1"
    ];
  };

  # HOME MANAGER
  home-manager = {
    users.cheryllamb = {
      home.stateVersion = "26.05";
      imports = [../../modules/shared-home.nix];
    };
  };

  # NETWORKING
  networking.hostName = "t3kl4";
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [80];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
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
    ProtectHome = pkgs.lib.mkForce "tmpfs";
    BindReadOnlyPaths = ["/home/cheryllamb/engram-data"];
  };

  # OTHER
  systemd.tmpfiles.rules = [
    "d /var/www 0755 cheryllamb users -"
    "d /var/www/engram 0755 cheryllamb users -"
  ];
  nix.settings.trusted-users = ["root" "cheryllamb"];

  # OVERLAYS
}
