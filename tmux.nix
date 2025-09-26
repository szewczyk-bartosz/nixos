{ config, pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    extraConfig = 
    ''
    set -as terminal-overrides ',xterm*:RGB'
    '';
  };
}
