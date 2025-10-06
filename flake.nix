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
      hostname = builtins.getEnv "HOSTNAME";
    in {
      nixosConfigurations = {
        k1v1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system-configs/k1v1-config.nix ];
        };

        m1k1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system-configs/m1k1-config.nix ];
        };
	
      	t3kl4 = nixpkgs.lib.nixosSystem {
      	  inherit system;
      	  modules = [ ./system-configs/t3kl4-config.nix ];
      	};
      };
      homeConfigurations = {

        "arasaka" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { host = hostname; };
          modules = [
            ./home-arasaka.nix
          ];
        };

        "mocha" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { host = hostname; };
          modules = [
            ./home-cat.nix
          ];
        };

        "latte" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { host = hostname; };
          modules = [
            ./home-albino-cat.nix
          ];
        };
      };
    };
}
