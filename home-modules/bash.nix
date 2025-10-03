{ config, pkgs, host, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "open" = "xdg-open";
    };

    bashrcExtra = 
    ''
    switch-home() {
      local target="''${1:-${host}}"
      echo "Home Manager: Loading config for ''${target}..."
      home-manager switch --flake "$HOME/.dotfiles/#''${target}"
    }

    switch-system() {
      local target="''${1:-${host}}"
      sudo nixos-rebuild switch --flake "$HOME/.dotfiles/"
    }

    switch-full() {
      local target="''${1:-${host}}"
      echo "Home Manager: Loading config for ''${target}..."
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
