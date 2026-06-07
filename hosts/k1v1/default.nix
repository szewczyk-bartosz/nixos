{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./disk.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
    ../../modules/devTools.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "k1v1";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";

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

  environment.systemPackages = with pkgs; [prismlauncher];
  programs.gamemode.enable = true;
  boot.kernel.sysctl."kernel.sched_itmt_enabled" = 1;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    DXVK_ASYNC = "1";
  };

  services.scx.enable = true;
  services.scx.scheduler = "scx_bpfland";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      programs.mangohud.enable = true;
      imports = [../../modules/shared-home.nix];
    };
  };

  system.stateVersion = "26.05";
}
