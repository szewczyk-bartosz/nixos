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
      import-tree,
      disko,
    }:
    let
      dots = import-tree.lib ./modules;
    in
    {
      nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          ./hosts/m1k1
        ];
      };

      nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          ./hosts/t3kl4
        ];
      };

      nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          mikoshi.modules.nixos.default
          ./hosts/k1v1
        ];
      };

      nixosConfigurations.virt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/virt
        ];
      };
    };
}
