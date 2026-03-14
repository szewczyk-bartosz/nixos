{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.enable = true;
  networking.hostName = "virt";
  swapDevices = [
    {
      device = "/swapfile";
      size = 2048;
    }
  ];
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      git
    ];
  };

  system.stateVersion = "25.11";
}
