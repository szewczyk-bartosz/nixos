{ config, pkgs, host, ... }:

let
  foo = "hello";
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
    ./home-modules/hyprland.nix # Hyprland config
    ./home-modules/bash.nix
    ./home-modules/kitty.nix
    ./home-modules/wofi-latte.nix
    ./home-modules/waybar.nix
    ./home-modules/vim.nix
    ./home-modules/helix.nix
    ./home-modules/git.nix
    ./home-modules/home-packages.nix
  ];

  programs.helix.settings.theme = "catppuccin_latte";

	wayland.windowManager.hyprland = {
		settings = {
			general = {
				"col.active_border" = "rgba(87a5ffee)";
				"col.inactive_border" = "rgba(595959aa)";
			};
		};
	};

	programs.kitty.extraConfig =
		''
			include catppuccin-mocha.conf
		'';


  home.pointerCursor = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.latteLight;
      size = 16;
    };

	gtk = {
    enable = true;
    theme = {
      # name = "catppuccin-mocha-sapphire-standard+normal";
      name = "Catppuccin-Latte-Standard-Sapphire-Light";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "latte";
      };
    };

		iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };    

  };
  xdg.configFile = {
	  "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
	  "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
	  "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};
  # wayland.windowManager.hyprland.settings = {
  #   exec-once = [
  #     # Fixes cursor themes in gnome apps under hyprland
  #     "gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
  #     "gsettings set org.gnome.desktop.interface cursor-size ${toString home.pointerCursor.size}"
  #   ];
  # };


  home.file.".config/waybar/config.jsonc".source = ./raw-configs/waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ./raw-configs/waybar-style-latte.css;
  home.file.".config/kitty/catppuccin-mocha.conf".source = ./raw-configs/catppuccin-latte1.conf;

  home.file.".wal-cache".source = ./raw-configs/wal-none;
  home.file."wallpapers/arasaka.png".source = ./wallpapers/beach.png;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
