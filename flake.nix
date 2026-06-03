{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikoshi = {
      url = "github:szewczyk-bartosz/mikoshi";
      # url = "path:/home/cheryllamb/mikoshi";
    };

    nixpkgs.follows = "mikoshi/nixpkgs";
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
        mikoshi.nixosModules.mikoshi-hyprland
        mikoshi.nixosModules.bmd
        disko.nixosModules.disko
        mikoshi.nixosModules.steam
        home-manager.nixosModules.home-manager
        {
          mikoshi.stylix.base16Scheme = "catppuccin-mocha";
          mikoshi.hyprland.monitors = ["DP-2,2560x1440@240,0x0,1"];
          mikoshi.hyprland.kb = "gb,ua,pl";
        }
        ./hosts/m1k1
      ];
    };

    nixosConfigurations.pr1mk4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        mikoshi.nixosModules.mikoshi-gnome
        home-manager.nixosModules.home-manager
        {
          mikoshi.stylix.base16Scheme = "catppuccin-mocha";
        }
        ./hosts/pr1mk4
      ];
    };

    nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        mikoshi.nixosModules.mikoshi-gnome
        ./hosts/k1v1
      ];
    };

    nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        mikoshi.nixosModules.neovim
        mikoshi.nixosModules.bmd
        mikoshi.nixosModules.tmux
        ./hosts/t3kl4
      ];
    };

    nixosConfigurations.virt = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        ./hosts/virt

        mikoshi.nixosModules.ghostty
        mikoshi.nixosModules.audio
        mikoshi.nixosModules.fonts
        mikoshi.nixosModules.icons
        mikoshi.nixosModules.neovim
        mikoshi.nixosModules.network
        mikoshi.nixosModules.tmux
      ];
    };

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      shellHook = ''
        [ -f .env ] && source .env
        alias deploy-t3kl4="nixos-rebuild switch --flake .#t3kl4 --target-host cheryllamb@$T3KL4_IP --sudo --ask-sudo-password"
      '';
    };
  };
}
