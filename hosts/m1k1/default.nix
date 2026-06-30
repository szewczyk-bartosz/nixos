{
  pkgs,
  lib,
  ...
}: let
  poe-trade = pkgs.writeShellScriptBin "poe-trade" ''
    echo "Running POE Trade Wrapper Version 0.6 (clean)"
    exec env XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 \
      ${pkgs.awakened-poe-trade}/bin/awakened-poe-trade --ozone-platform=x11 "$@"
  '';
in {
  imports = [
    ./hardware.nix
    ./disk.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
    ../../modules/devTools.nix
  ];

  programs.ydotool.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razergenie
    prismlauncher
    poe-trade
    wlrctl
  ];
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

  services.scx.enable = true;
  services.scx.scheduler = "scx_bpfland";
  networking.hostName = "m1k1";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "openrazer" "gamemode" "libvirtd"];
    packages = with pkgs; [];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [libva-vdpau-driver];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      programs.mangohud.enable = true;
      imports = [../../modules/shared-home.nix ./hyprland.nix];
    };
  };

  system.stateVersion = "26.05";
}
