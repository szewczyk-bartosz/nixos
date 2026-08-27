{
  pkgs,
  lib,
  nixpkgs-unstable,
  ...
}:
{
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
    ssh.allowFrom = [ "m1k1" ];
    remoteDeployment.enable = true;
    engram.enable = true;
    apps.default.enable = true;
    dev.tools.default.enable = true;
    dev.git.enable = true;
    dev.shellConfig.enable = true;
  };

  # MIKOSHI OPTIONS
  mikoshi = {
    meta = {
      keyboardLayouts = [
        "gb"
        "pl"
        "ua"
      ];
      users = [ "cheryllamb" ];
    };

    stylix = {
      enable = true;
      base16Scheme = "catppuccin-mocha";
    };

    hyprland.enable = true;
    waybar.battery.enable = true;
    hyprland.wallpaper = ../../wallpapers/nixos.png;
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [ ];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gamemode"
    ];
    packages = with pkgs; [ ];
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

  # OVERLAYS
}
