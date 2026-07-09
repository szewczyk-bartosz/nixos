{pkgs, ...}: {
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

  # MIKOSHI OPTIONS

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [prismlauncher];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "gamemode"];
    packages = with pkgs; [];
  };

  # HOME MANAGER
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      programs.mangohud.enable = true;
      imports = [../../modules/shared-home.nix];
    };
  };

  # NETWORKING
  networking.hostName = "k1v1";

  # OTHER
  # some optimisation i dont remember what they do
  boot.kernel.sysctl."kernel.sched_itmt_enabled" = 1;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    DXVK_ASYNC = "1";
  };

  # OVERLAYS
}
