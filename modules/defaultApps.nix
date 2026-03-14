{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    chromium
    brave
    firefox
    claude-code
    discord
    keepassxc
    spotify
  ];
}
