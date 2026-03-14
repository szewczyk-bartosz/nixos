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
      inputs.home-manager.follows = "home-manager";
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
        mikoshi.nixosModules.gnomoshi
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
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        mikoshi.modules.nixos.neovim
        mikoshi.modules.nixos.tmux
        ./hosts/t3kl4
      ];
    };

    nixosConfigurations.virt = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        mikoshi.nixosModules.gnomoshi
        disko.nixosModules.disko
        ./hosts/virt
      ];
    };
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      shellHook = ''
        alias deploy-t3kl4="sudo nixos-rebuild switch --flake .#t3kl4 --target-host cheryllamb@195.201.32.53 --sudo --ask-sudo-password"
      '';
    };
  };
}
