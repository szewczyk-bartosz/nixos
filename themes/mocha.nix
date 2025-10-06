{ config, pkgs, ... }:

{
	imports = [ ../home-modules/wofi-mocha.nix ];
  programs.helix.settings.theme = "catppuccin_mocha";

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
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };

	gtk = {
    enable = true;
    theme = {
      # name = "catppuccin-mocha-sapphire-standard+normal";
      name = "Catppuccin-Mocha-Standard-Sapphire-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
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

	# home.sessionVariables = {
	#   GTK_THEME = "Catppuccin-Mocha-Standard-Sapphire-Dark";
	#   XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
	#   XDG_CURRENT_DESKTOP = "Hyprland";
	#   XDG_SESSION_TYPE = "wayland";
	#   QT_QPA_PLATFORMTHEME = "gtk3";
	# };
  home.file.".config/waybar/config.jsonc".source = ../raw-configs/waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ../raw-configs/waybar-style-mocha.css;
  home.file.".config/kitty/catppuccin-mocha.conf".source = ../raw-configs/catppuccin-mocha1.conf;
  home.file.".wal-cache".source = ../raw-configs/wal-none;
  home.file."wallpapers/arasaka.png".source = ../wallpapers/blue-swirls.png;
}
