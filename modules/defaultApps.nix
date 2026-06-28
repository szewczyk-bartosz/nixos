{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    chromium
    brave
    zip
    unzip
    firefox
    vlc
    claude-code
    discord
    keepassxc
    spotify
    ffmpeg
    telegram-desktop
    bolt-launcher
    rusty-path-of-building
  ];
}
