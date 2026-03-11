{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikoshi = {
      # url = "github:szewczyk-bartosz/mikoshi";
      url = "path:/home/cheryllamb/mikoshi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    mikoshi,
    disko,
  }: {
    nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        mikoshi.modules.nixos.gnomoshi
        ./hosts/m1k1
      ];
    };

    nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        mikoshi.modules.nixos.gnomoshi
        ./hosts/k1v1
      ];
    };

    nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        mikoshi.modules.nixos.neovim
        ./hosts/t3kl4
      ];
    };
  };
}
