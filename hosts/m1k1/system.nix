{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razergenie
    prismlauncher
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

  system.stateVersion = "26.05";
}
