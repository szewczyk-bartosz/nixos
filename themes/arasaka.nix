{ config, pkgs, ... }:

{
	imports = [ ../home-modules/wofi-arasaka.nix ];
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

  home.file.".config/waybar/config.jsonc".source = ../raw-configs/waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ../raw-configs/waybar-style-arasaka.css;
  home.file.".wal-cache".source = ../raw-configs/arasaka-wal;
  home.file."wallpapers/arasaka.png".source = ../wallpapers/arasaka.png;
}
