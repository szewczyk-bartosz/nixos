{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    jdt-language-server
  ];

  programs.helix = {
    enable = true;
    settings  = {
      keys.insert = {
        j.k = "normal_mode";
      };
    };
  };
  
}
