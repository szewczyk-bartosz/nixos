{ config, pkgs, host, ... }:

let
  foo = "hello";
  bshConfig = import (
    ./bsh + "/${host}.nix"
  );
in rec {
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
  # = = = = = = = = = = = = = = = = = = = = =
  
  imports = [
    ./hyprland.nix # Hyprland config
    ./bsh/bash.nix
    ./kitty.nix
    ./wofi-arasaka.nix
    ./waybar.nix
    ./vim.nix
    ./helix.nix
    ./git.nix
    ./home-packages.nix
  ];


  programs.helix.settings.theme = "peachpuff";
	wayland.windowManager.hyprland = {
		settings = {
			general = {
				"col.active_border" = "rgba(DD0000ee)";
				"col.inactive_border" = "rgba(595959aa)";
			};
		};
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
  home.file.".config/waybar/style.css".source = ./waybar-style-arasaka.css;

  home.file.".wal-cache".source = ./arasaka-wal;
  home.file."wallpapers/arasaka.png".source = ./wallpapers/arasaka.png;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
