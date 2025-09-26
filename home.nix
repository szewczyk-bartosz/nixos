{ config, pkgs, ... }:

rec {
  # = = = = = = = = = = = = = = = = = = = = =
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cheryllamb";
  home.homeDirectory = "/home/cheryllamb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  # = = = = = = = = = = = = = = = = = = = = =
  
  imports = [
    ./hyprland.nix # Hyprland config
    ./bsh.nix
    ./tmux.nix
    ./kitty.nix
  ];

  programs.git = {
    enable = true;
    userName = "szewczyk-bartosz";
    userEmail = "cheryllamb123098@protonmail.com";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    cowsay
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
  programs.neovim.enable = true;
  programs.bash.enable = true;

  programs.rofi = {
    enable = true;
    font = "JetbrainsMono Nerd Font 20";
  };

  programs.fastfetch = {
    enable = true;

  };

  
  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 48;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/szewczyk-bartosz/KanadaCursors/releases/download/ready/KanadaCursors.tar.gz"
        "sha256-lHDrGjj3lLeKTZG/DiX2qUdu1a/6szHDJVDRvZOZ7Fs="
        "Kanada";


  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Fixes cursor themes in gnome apps under hyprland
      "gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
      "gsettings set org.gnome.desktop.interface cursor-size ${toString home.pointerCursor.size}"
    ];
  };


  home.file.".config/waybar/config.jsonc".source = ./waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ./waybar-style.css;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
