{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          modules/m1k1-system-config.nix

          home-manager.nixosModules.home-manager 
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cheryllamb = import ./modules/home.nix;
          }
        ];
      };

    };
}
