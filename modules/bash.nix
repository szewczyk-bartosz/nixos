# modules/home-shell.nix
{ config, lib, ... }:
{
  options.dots.dev.shellConfig.enable = lib.mkEnableOption "personal shell aliases";

  config = lib.mkIf config.dots.home.shell.enable {
    home-manager.users = lib.genAttrs config.mikoshi.meta.users (user: {
      programs.bash = {
        enable = true;
        shellAliases = {
          "cdd" = "cd ~/Desktop/";
        };
      };
    });
  };
}
