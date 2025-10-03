{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv
    nix-direnv
    ffmpeg
    git
    vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    dunst
    wofi
    brave
    xdg-desktop-portal-gtk
    bash
    xxkb
    alacritty
    libnotify
    # tmux disabled pending resolving the helix issue
    pywal
    swaybg
    nwg-look
    brightnessctl
  ];
}
