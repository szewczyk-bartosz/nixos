{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-26.05";

    mikoshi = {
      url = "github:szewczyk-bartosz/mikoshi";
      # url = "path:/home/cheryllamb/mikoshi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    engram = {
      url = "github:szewczyk-bartosz/engram";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    import-tree.url = "github:denful/import-tree";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    mikoshi,
    engram,
    import-tree,
    disko,
  }: let
    dots = import-tree ../modules;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      shellHook = ''
        echo "Dots Dev Shell Loaded"
        echo "run with: deploy-engram"
      '';
      packages = [
        (pkgs.writeShellScriptBin "deploy-engram" ''
          set -e
          nix flake update engram
          if git diff --quiet flake.lock; then
            echo "engram already up to date, skipping commit"
          else
            git add flake.lock
            git commit -m "bumped engram"
          fi
          nixos-rebuild switch --flake .#t3kl4 --target-host cheryllamb@t3kl4 --ask-sudo-password --sudo
        '')
      ];
    };

    nixosConfigurations.t3kl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit nixpkgs-unstable;};
      modules = [
        engram.nixosModules.default
        disko.nixosModules.disko
        mikoshi.modules.nixos.default
        dots
        ../hosts/t3kl4
      ];
    };
  };
}
