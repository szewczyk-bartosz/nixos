{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ modules/m1k1-system-config.nix ];
      };

    };
}
