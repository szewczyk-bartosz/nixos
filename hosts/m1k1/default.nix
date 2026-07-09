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
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
    ../../modules/devTools.nix
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      imports = [
        ../../modules/shared-home.nix
      ];
    };
  };

  # NETWORKING
  networking.hostName = "m1k1";

  # OTHER
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # OVERLAYS
  nixpkgs.overlays = [
    (final: prev: {
      claude-code =
        (import nixpkgs-unstable {
          system = prev.system;
          config.allowUnfree = true;
        }).claude-code;
    })
  ];
}
