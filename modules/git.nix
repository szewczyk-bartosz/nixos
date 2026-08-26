{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.dots.dev.git.enable = lib.mkEnableOption "personal git identity";

  config = lib.mkIf config.dots.home.git.enable {
    home-manager.users = lib.genAttrs config.mikoshi.meta.users (user: {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          user = {
            name = "szewczyk-bartosz";
            email = "cheryllamb123098@protonmail.com";
          };
        };
      };
    });
  };
}
