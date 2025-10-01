{ config, pkgs, host, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "switch-system" = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
      "switch-home" = "home-manager switch --flake ~/.dotfiles/#cheryllamb@k1v1";
      "switch-full" = "sudo nixos-rebuild switch --flake ~/.dotfiles/ && home-manager switch --flake ~/.dotfiles/#cheryllamb@k1v1";
    };

    bashrcExtra = 
    ''
    switch-home() {
      local target="$${1:-${host}}"
      home-manager switch --flake "$HOME/.dotfiles/#$${target}"
    }

    switch-system() {
      local target="$${1:-${host}}"
      nixos-rebuild switch --flake "$HOME/.dotfiles/"
    }

    switch-full() {
      local target="$${1:-${host}}"
      switch-system
      switch-home "$target"
    }

    cat ~/.wal-cache


    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      exec tmux
    fi
    eval "$(direnv hook bash)"
    fastfetch
    '';
  };

}
