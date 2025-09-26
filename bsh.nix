{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "switch-system" = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      "switch-home" = "home-manager switch --flake ~/.dotfiles/";
      "switch-full" = "sudo nixos-rebuild switch --flake ~/.dotfiles && home-manager switch --flake ~/.dotfiles/";
    };
  };

}
