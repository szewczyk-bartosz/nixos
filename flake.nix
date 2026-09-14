{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikoshi = {
      url = "github:szewczyk-bartosz/mikoshi";
      # url = "path:/home/cheryllamb/mikoshi";
    };

    engram = {
      url = "github:szewczyk-bartosz/engram";
      inputs.nixpkgs.follows = "mikoshi/nixpkgs";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "mikoshi/nixpkgs";

    import-tree.url = "github:denful/import-tree";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      mikoshi,
      engram,
      import-tree,
      disko,
    }:
    let
      dots = import-tree ./modules;
    in
    {
      nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          dots
          ./hosts/m1k1
        ];
      };

      nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          engram.nixosModules.default
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          dots
          ./hosts/t3kl4
        ];
      };

      nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          mikoshi.modules.nixos.default
          disko.nixosModules.disko
          dots
          ./hosts/k1v1
        ];
      };

      nixosConfigurations.virt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          mikoshi.modules.nixos.default
          disko.nixosModules.disko
          dots
          ./hosts/virt
        ];
      };
    };
}
