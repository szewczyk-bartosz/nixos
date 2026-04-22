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
  ];

  networking.hostName = "m1k1";
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "openrazer" "gamemode" "libvirtd"];
    packages = with pkgs; [];
  };

  system.stateVersion = "25.11";
}
