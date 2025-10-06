{ config, lib, pkgs, host, ... }:

{

  nixpkgs.config = {
    allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];
  };

  home.packages = with pkgs; [
    spotify
    grim
    slurp
  ];
}
