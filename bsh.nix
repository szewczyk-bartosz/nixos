{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "switch-system" = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      "switch-home" = "home-manager switch --flake ~/.dotfiles/";
      "switch-full" = "sudo nixos-rebuild switch --flake ~/.dotfiles && home-manager switch --flake ~/.dotfiles/";
    };

    bashrcExtra = 
    ''
    cat ~/.wal-cache


    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      exec tmux
    fi
    fastfetch
    '';
  };

}
