{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
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
