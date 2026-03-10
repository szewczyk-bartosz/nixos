{...}: {
  imports = [
    ./hardware.nix
    ./system.nix
    ../../modules/shared-system.nix
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
