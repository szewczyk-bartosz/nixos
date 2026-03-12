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
    extraGroups = ["wheel" "gamemode"];
    packages = with pkgs; [];
  };

  # Optimisations specific to my laptop
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    intel-compute-runtime
  ];
  programs.gamemode.enable = true;
  boot.kernel.sysctl."kernel.sched_itmt_enabled" = 1;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    DXVK_ASYNC = "1";
  };

  system.stateVersion = "25.11";
}
