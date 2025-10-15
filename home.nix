{ config, pkgs, host, theme, ... }:

let
  foo = "hello";
  themeConfig = import (
    ./themes + "/${theme}.nix"
  );
in rec {
  # = = = = = = = = = = = = = = = = = = = = =
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cheryllamb";
  home.homeDirectory = "/home/cheryllamb";

  
  imports = [
    ./home-modules/hyprland.nix # Hyprland config
    ./home-modules/bash.nix
    ./home-modules/kitty.nix
    ./home-modules/waybar.nix
    ./home-modules/vim.nix
    ./home-modules/helix.nix
    ./home-modules/git.nix
    ./home-modules/hyprshell.nix
    ./home-modules/home-packages.nix
    themeConfig
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  # = = = = = = = = = = = = = = = = = = = = =
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
