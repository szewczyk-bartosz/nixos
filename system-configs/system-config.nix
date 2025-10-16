{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.thunar.enable = true;
  programs.dconf.enable = true;
  services.lorri.enable = true;
  environment.systemPackages = with pkgs; [
    razergenie
    easyeffects
    libreoffice
    syncthing
    direnv
    nix-direnv
    python312
    ffmpeg
    fastfetch
    keepassxc
    cmatrix
    git
    gimp
    vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    dunst
    # wofi
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
    vlc
    obs-studio
    webcord
  ];
}
