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

      mkHomeConfig = theme: hostname:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = hostname;
            theme = theme;
          };
          modules = [ ./home.nix ];
        };

      themes = [ "mocha" "latte" "arasaka" ];
      hosts = [ "k1v1" "m1k1" "t3kl4" ];
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

      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (theme: builtins.map (host: { name = "${theme}.${host}"; value = mkHomeConfig theme host; }) hosts) themes
      );

    };
}
