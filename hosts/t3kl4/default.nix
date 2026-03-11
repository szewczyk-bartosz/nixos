{...}: {
  imports = [
    ./system.nix
    ./disk.nix
    ./hardware.nix
    ../../modules/shared-system.nix
  ];
}
