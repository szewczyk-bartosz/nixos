{ config, pkgs, ...}:

{
	home.username = "cheryllamb";
	home.homeDirectory = "/home/cheryllamb";

	home.stateVersion = 26.05;
	home.packages = with pkgs; [ cowsay ];

	programs.git = {
		enable = true;
		userName = "szewczyk-bartosz";
		userEmail = "cheryllamb123098@protonmail.com";
	};

	programs.home-manager.enable = true;
}
