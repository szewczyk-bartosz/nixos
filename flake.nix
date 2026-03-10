{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
    mikoshi-vim,
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        modules/nixos-system-config.nix
        mikoshi.modules.nixos.gnomoshi
        mikoshi-vim.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cheryllamb = {
            home.stateVersion = "26.05";
            imports = [./modules/home.nix];
          };
        }
      ];
    };
    nixosConfigurations.m1k1 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        modules/m1k1-hardware.nix
        mikoshi.modules.nixos.gnomoshi
        mikoshi-vim.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          # Config file flattened
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          networking.hostName = "m1k1";
          users.users.cheryllamb = {
            isNormalUser = true;
            extraGroups = ["wheel" "gamemode"];
          };
          system.stateVersion = "25.11";
          nix.settings.experimental-features = ["nix-command" "flakes"];

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
