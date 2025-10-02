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
    ./hyprland.nix # Hyprland config
    ./bsh/bash.nix
    ./kitty.nix
    ./wofi-cat.nix
    ./waybar.nix
    ./vim.nix
    ./helix.nix
    ./git.nix
    ./home-packages.nix
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

  # home.pointerCursor = 


  # wayland.windowManager.hyprland.settings = {
  #   exec-once = [
  #     # Fixes cursor themes in gnome apps under hyprland
  #     "gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
  #     "gsettings set org.gnome.desktop.interface cursor-size ${toString home.pointerCursor.size}"
  #   ];
  # };


  home.file.".config/waybar/config.jsonc".source = ./waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ./waybar-style-latte.css;
  home.file.".config/kitty/catppuccin-mocha.conf".source = ./kitty/catppuccin-latte1.conf;

  home.file.".wal-cache".source = ./wal-none;
  home.file."wallpapers/arasaka.png".source = ./wallpapers/beach.png;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
