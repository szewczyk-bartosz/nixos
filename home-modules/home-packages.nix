{ config, lib, pkgs, host, ... }:

{

  nixpkgs.config = {
    allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "spotify"
    ];
  };

  home.packages = with pkgs; [
    spotify
    grim
    slurp
    path-of-building
  ];
}
