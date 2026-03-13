{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    chromium
    ghostty
    brave
    firefox
    claude-code
    discord
    keepassxc
    spotify
  ];
}
