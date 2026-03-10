{ config, pkgs, ... }: {
  home.username = "cheryllamb";
  home.homeDirectory = "/home/cheryllamb";

  programs.git = {
    enable = true;
    settings.user = {
      name = "szewczyk-bartosz";
      email = "cheryllamb123098@protonmail.com";
    };
  };

  programs.home-manager.enable = true;
}
