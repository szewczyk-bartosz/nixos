{pkgs, ...}: {
  system.stateVersion = "25.11";
  imports = [
    ./hardware.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
    ../../modules/devTools.nix
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [];

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
      imports = [../../modules/shared-home.nix];
    };
  };

  # NETWORKING
  networking.hostName = "pr1mk4";
  services.openssh.enable = true;

  # OTHER
  # users.users.root.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
  # ];
  # nix.settings.trusted-users = ["root" "cheryllamb"];

  # OVERLAYS
}
