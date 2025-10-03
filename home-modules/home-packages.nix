{ config, pkgs, host, ... }:

{
  home.packages = with pkgs; [
    python312
    jdk24
    cowsay
    gimp
    grim
    slurp
    fastfetch
  ];
}
