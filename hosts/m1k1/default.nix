{ ... }: {
  imports = [
    ./hardware.nix
    ./system.nix
    ../../modules/shared-system.nix
  ];

  home-manager.users.cheryllamb = {
    home.stateVersion = "26.05";
    imports = [ ../../modules/shared-home.nix ];
  };
}
