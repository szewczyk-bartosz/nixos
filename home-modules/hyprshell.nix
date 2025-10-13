{ config, pkgs, ... }:

{
  services.hyprshell = {
    enable = true;
    systemd.enable = true;
  };
}
