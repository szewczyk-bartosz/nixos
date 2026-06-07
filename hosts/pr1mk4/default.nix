{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
    ../../modules/devTools.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pr1mk4";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
  ];

  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "gamemode"];
    packages = with pkgs; [];
  };

  hardware.graphics.enable = true;
  programs.gamemode.enable = true;

  nix.settings.trusted-users = ["root" "cheryllamb"];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      imports = [../../modules/shared-home.nix];
    };
  };

  system.stateVersion = "25.11";
}
