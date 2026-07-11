{
  config,
  pkgs,
  ...
}: {
  home.username = "cheryllamb";
  home.homeDirectory = "/home/cheryllamb";

  programs.bash = {
    enable = true;
    shellAliases = {
      "cdd" = "cd ~/Desktop/";
    };
  };

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

  programs.home-manager.enable = true;
}
