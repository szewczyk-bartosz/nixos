{ config, pkgs, host, ... }:

{
  programs.git = {
    enable = true;
    userName = "szewczyk-bartosz";
    userEmail = "cheryllamb123098@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
