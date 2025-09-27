{
  description = "flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      k1v1 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./k1v1-config.nix ];
      };
    };
    homeConfigurations = {
      "cheryllamb@k1v1" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { host = "k1v1"; };
        modules = [
          ./home.nix
        ];
      };

      "cheryllamb@m1k1" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { host = "m1k1"; };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
