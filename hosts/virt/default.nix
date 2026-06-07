{pkgs, ...}: {
  imports = [
    ./disk.nix
    ./hardware.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
  ];

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      imports = [../../modules/shared-home.nix];
    };
  };

  system.stateVersion = "26.05";
}
