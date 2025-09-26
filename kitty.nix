{ config, pkgs, ... }:

{
  programs.kitty {
    enable = true;
    font = "JetbrainsMono Nerd Font";
    extraConfig = 
    ''
    confirm_os_window_close -1
    '';
  };
}
