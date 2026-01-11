{
  config,
  pkgs,
  ...
}: {
  home.username = "cheryllamb";
  home.homeDirectory = "/home/cheryllamb";

  home.packages = with pkgs; [cowsay];

  programs.kitty = {
    enable = true;
    font = {
      name = "iosevka nerd font";
      size = 14;
      package = pkgs.nerd-fonts.iosevka;
    };
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "szewczyk-bartosz";
      email = "cheryllamb123098@protonmail.com";
    };
  };

  programs.home-manager.enable = true;
}
