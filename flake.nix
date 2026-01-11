{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikoshi-vim = {
      url = "github:szewczyk-bartosz/mikoshi-neovim";
      #url = "path:/home/cheryllamb/mikoshi-neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    mikoshi-vim,
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        modules/m1k1-system-config.nix
        mikoshi-vim.nixosModules.default

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cheryllamb = {
            home.stateVersion = "26.05";
            imports = [
              ./modules/home.nix
            ];
          };
        }
      ];
    };
  };
}
