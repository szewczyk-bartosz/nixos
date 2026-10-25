{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  apt = pkgs.awakened-poe-trade.override { electron = pkgs.electron_42; };

  poe-trade = pkgs.writeShellScriptBin "poe-trade" ''
    exec env XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 \
      ${apt}/bin/awakened-poe-trade --ozone-platform=x11 --listen=127.0.0.1:4502 "$@"
  '';

  poe-trade-browser = pkgs.writeShellScriptBin "poe-trade-browser" ''
    exec env XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 \
      ${apt}/bin/awakened-poe-trade --ozone-platform=x11 \
      --no-overlay --listen=127.0.0.1:4502 "$@"
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
    lock.enable = false;
    meta = {
      users = ["cheryllamb"];
      keyboardLayouts = ["gb" "pl" "ua"];
    };
    theme.polarity = "dark";
    wm.sway.enable = true;
    wm.sway.wallpaper = ../../wallpapers/nixos.png;
    wm.sway.capsAsCtrl = true;
    # wm.plasma.enable = true;
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
    poe-trade-browser
    gocryptfs
    lutris
    wlrctl
    er-patcher
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
