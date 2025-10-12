{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "YOUR_HOSTNAME"; # <<<< HOSTNAME
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Don't think this is that important tbh but I haven't tested without it
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # SET USER HERE
  users.users.USERNAME_GOES_HERE = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
  };

  # PROGRAMS YOU WANT GO DOWN HERE I ALREADY PUT IN GIT AND VIM
  environment.systemPackages = with pkgs; [ vim wget git ];

  system.stateVersion = "25.05"; # DO NOT CHANGE THIS
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # <<< VERY IMPORTANT
}

