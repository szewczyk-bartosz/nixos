{
  pkgs,
  lib,
  nixpkgs-unstable,
  ...
}: let
  algorithms = "39796";
  dataScience = "39874";
  databases = "39802";
  compilers = "38069";
in {
  system.stateVersion = "25.11";
  imports = [
    ./hardware.nix
    ./disk.nix
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # DOTS OPTIONS
  dots = {
    ssh.users.cheryllamb.allowFrom = ["m1k1" "phone"];
    remoteDeployment.enable = true;
    syncthing.enable = true;
    canvas = {
      enable = true;
      active = [algorithms dataScience databases compilers];
      images = {
        ${algorithms} = "https://canvas.sussex.ac.uk/images/thumbnails/5147631/WcMTB8al50KqykfEOVjqZ6DFSVbUd7puZWpv0R1S";
        ${compilers} = "https://t2informatik.de/en/wp-content/uploads/sites/2/2023/03/compiler.png";
      };
    };
    apps.default.enable = true;
    dev = {
      tools.default.enable = true;
      git.enable = true;
      shellConfig.enable = true;
    };
  };

  # MIKOSHI OPTIONS
  mikoshi = {
    meta = {
      keyboardLayouts = [
        "gb"
        "pl"
        "ua"
      ];
      users = ["cheryllamb"];
    };

    # stylix = {
    #   enable = true;
    #   base16Scheme = "catppuccin-mocha";
    # };

    wm.sway = {
      capsAsCtrl = true;
      enable = true;
      wallpaper = ../../wallpapers/nixos.png;
    };
    waybar.battery.enable = true;
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [];

  # USERS
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gamemode"
    ];
    packages = with pkgs; [];
  };

  # HOME MANAGER
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
    };
  };

  # NETWORKING
  networking.hostName = "k1v1";

  # OTHER

  # OVERLAYS
}
