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
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    mikoshi,
    disko,
  }: {
    nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit nixpkgs-unstable;};
      modules =
        [
          disko.nixosModules.disko
          ./hosts/m1k1
        ]
        ++ (with mikoshi.modules.nixos; [
          plasma
          gaming
          bmd
          obs-amd
        ]);
    };

    nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          disko.nixosModules.disko
          ./hosts/t3kl4
        ]
        ++ (with mikoshi.modules.nixos; [
          base
          bmd
        ]);
    };

    nixosConfigurations.pr1mk4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/pr1mk4
      ]

        ++ (with mikoshi.modules.nixos; [
          plasma
          gaming
          bmd
        ]);
    };

    nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
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
