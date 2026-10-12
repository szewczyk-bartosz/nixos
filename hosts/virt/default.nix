{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  imports = [
    ./disk.nix
    ./hardware.nix
  ];
  system.stateVersion = "25.11";

  # BOOT
  boot.loader.grub.enable = true;

  # DOTS OPTIONS
  dots = {
  };

  # MIKOSHI OPTIONS
  mikoshi = {
    wm.sway.enable = true;
    meta = {
      users = ["anon"];
      keyboardLayouts = ["gb"];
    };
  };

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    git
    python313
  ];

  # USERS
  users.users = {
    anon = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  # HOME MANAGER
  home-manager = {
    users.anon = {
      home.stateVersion = "26.05";
    };
  };

  # NETWORKING
  networking.hostName = "virt";

  # OTHER

  # OVERLAYS
}
