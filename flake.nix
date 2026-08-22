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
    nixpkgs.follows = "mikoshi/nixpkgs"; }; outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    mikoshi,
    disko,
  }: {
    nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit nixpkgs-unstable;};
      modules =
        [
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          ./hosts/m1k1
        ];
    };

    nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          disko.nixosModules.disko
          mikoshi.modules.nixos.default
          ./hosts/t3kl4
        ];
    };

    nixosConfigurations.pr1mk4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit nixpkgs-unstable;};
      modules = [
        mikoshi.modules.nixos.default
        ./hosts/pr1mk4
      ];
    };

    nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit nixpkgs-unstable;};
      modules = [
        disko.nixosModules.disko
        ./hosts/k1v1
      ]
        ++ (with mikoshi.modules.nixos; [
          hyprland
          bmd
        ]);
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
