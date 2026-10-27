{
  pkgs,
  lib,
  nixpkgs-unstable,
  ...
}: {
  system.stateVersion = "25.11";
  imports = [
    ./hardware.nix
    ./disk.nix
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # DOTS OPTIONS
  dots = {
    ssh.users.cheryllamb.allowFrom = ["m1k1" "phone"];
    remoteDeployment.enable = true;
    syncthing.enable = true;
    canvasPatch.enable = true;
    apps.default.enable = true;
    dev = {
      tools.default.enable = true;
      git.enable = true;
      shellConfig.enable = true;
    };
  };

  # MIKOSHI OPTIONS
  mikoshi = {
    meta = {
      keyboardLayouts = [
        "gb"
        "pl"
        "ua"
      ];
      users = ["cheryllamb"];
    };
    bluetooth.enable = true;

    # stylix = {
    #   enable = true;
    #   base16Scheme = "catppuccin-mocha";
    # };

    bmd.enable = true;
    wm.sway = {
      capsAsCtrl = true;
      enable = true;
      wallpaper = ../../wallpapers/nixos.png;
    };
    waybar.battery.enable = true;
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [ dbeaver-bin ];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gamemode"
    ];
    packages = with pkgs; [];
  };

  # HOME MANAGER
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
    };
  };

  # NETWORKING
  networking.hostName = "k1v1";

  # OTHER
  services.fwupd.enable = true;

  # OVERLAYS
}
