{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dots = {
    dev.tools.default.enable = lib.mkEnableOption "the default development tools";
  };
  config = lib.mkIf config.dots.dev.tools.default.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    environment.systemPackages = with pkgs; [
      wget
      git
      rustc
      cargo
      rustfmt
      maven
      jdk
      (python313.withPackages (
        python-pkgs: with python-pkgs; [
          playwright-stealth
          pygame
          playwright
          beautifulsoup4
          requests
        ]
      ))
      playwright
    ];
  };
}
