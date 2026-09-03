{ pkgs, nixpkgs-unstable, ... }: {
  imports = [
    ./disk.nix
    ./hardware.nix
  ];
  system.stateVersion = "25.11";

  # BOOT
  boot.loader.grub.enable = true;

  # DOTS OPTIONS
  dots = {
    ssh.allowFrom = ["m1k1" "phone"];
    remoteDeployment.enable = true;
    engram.enable = true;
    dev = {
      git.enable = true;
      shellConfig.enable = true;
      claude-unstable.enable = true;
    };
  };

  # MIKOSHI OPTIONS
  mikoshi = {
    meta = {
      users = ["cheryllamb"];
      keyboardLayouts = ["gb"];
    };
    bmd.enable = true;
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    git
    python313
  ];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # HOME MANAGER
  home-manager = {
    users.cheryllamb = {
      home.stateVersion = "26.05";
    };
  };

  # NETWORKING
  networking.hostName = "t3kl4";
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 80 ];


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
    BindReadOnlyPaths = [ "/home/cheryllamb/engram-data" ];
  };

  # OTHER
  systemd.tmpfiles.rules = [
    "d /var/www 0755 cheryllamb users -"
    "d /var/www/engram 0755 cheryllamb users -"
  ];

  # OVERLAYS
}
