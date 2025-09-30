{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xsel
  ];

  programs.helix = {
    enable = true;
    settings  = {
      theme = "peachpuff";
      keys.insert = {
        j.k = "normal_mode";
      };
    };
  };
  
}
