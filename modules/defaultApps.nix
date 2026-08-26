{ pkgs, lib, config, ... }: {
  options.dots = {
    apps.default.enable = lib.mkEnableOption "default set of desktop apps I use";
  };
  config = lib.mkIf config.dots.apps.default.enable {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      chromium
      brave
      zip
      unzip
      firefox
      vlc
      discord
      keepassxc
      spotify
      ffmpeg
      telegram-desktop
      bolt-launcher
      rusty-path-of-building
    ];
  };
}
