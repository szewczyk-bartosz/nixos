{ config, pkgs, ...}:

{
  programs.tmux = {
    enable = false;
    extraConfig = 
    ''
    set -as terminal-overrides ',xterm*:RGB'
    set -s escape-time 0
    '';
  };
}
