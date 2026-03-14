{...}: {
  imports = [
    ./system.nix
    ./disk.nix
    ./hardware.nix
    ../../modules/shared-system.nix
    ../../modules/defaultApps.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cheryllamb = {
      home.stateVersion = "26.05";
      imports = [../../modules/shared-home.nix];
    };
  };
}
