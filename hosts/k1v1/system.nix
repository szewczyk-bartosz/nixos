{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "k1v1";

  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [];
  };

  system.stateVersion = "25.11";
}
