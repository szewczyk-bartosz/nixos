{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    chromium
    brave
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
