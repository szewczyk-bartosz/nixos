{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.enable = true;
  networking.hostName = "virt";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";
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

  system.stateVersion = "26.05";
}
