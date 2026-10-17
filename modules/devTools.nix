{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dots = {
    dev.tools.default.enable = lib.mkEnableOption "the default development tools";
  };
  config = lib.mkIf config.dots.dev.tools.default.enable {
    dots.dev.claude-unstable.enable = lib.mkDefault true;
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    environment.systemPackages = with pkgs; [
      wget
      git
      (python313.withPackages (
        python-pkgs:
          with python-pkgs; [
            pygame
            beautifulsoup4
            requests
          ]
      ))
    ];
  };
}
