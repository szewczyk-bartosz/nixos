{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  poe-trade = pkgs.writeShellScriptBin "poe-trade" ''
    echo "Running POE Trade Wrapper Version 0.6 (clean)"
    exec env XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 \
      ${pkgs.awakened-poe-trade}/bin/awakened-poe-trade --ozone-platform=x11 "$@"
  '';
in {
  system.stateVersion = "26.05";
  imports = [
    ./hardware.nix
    ./disk.nix
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # DOTS OPTIONS
  dots = {
    engram.enable = true;
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
      users = ["cheryllamb"];
      keyboardLayouts = ["gb" "pl" "ua"];
    };
    wm.plasma.enable = true;
    gaming.enable = true;
    bmd.enable = true;
    obs-amd.enable = true;
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razergenie
    prismlauncher
    poe-trade
    wlrctl
  ];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "openrazer" "gamemode" "libvirtd"];
  };

  # HOME MANAGER
  home-manager = {
    users.cheryllamb = {
      home.stateVersion = "26.05";
      programs.mangohud.enable = true;
    };
  };

  # NETWORKING
  networking.hostName = "m1k1";

  # OTHER
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # OVERLAYS
}
