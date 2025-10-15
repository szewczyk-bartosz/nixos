{
  description = "flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkSystemConfig = hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system-configs/${hostname}-config.nix ];
        };

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
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (host: { name = host; value = mkSystemConfig host; }) hosts
      );
      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (theme: builtins.map (host: { name = "${theme}.${host}"; value = mkHomeConfig theme host; }) hosts) themes
      );

    };
}
