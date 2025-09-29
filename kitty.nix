{ config, pkgs, host, ... }:

let 
  font_size = if (host == "k1v1") then "11.0" else (if (host == "m1k1") then "15.0" else "4.0");
in
{
  programs.kitty = {
    enable = true;
    extraConfig = 
    ''
    confirm_os_window_close 0
    font_size ${font_size}
    '';
  };
}
