{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pr1mk4";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
  ];

  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel" "gamemode"];
    packages = with pkgs; [];
  };

  hardware.graphics.enable = true;
  programs.gamemode.enable = true;

  system.stateVersion = "25.11";
}
