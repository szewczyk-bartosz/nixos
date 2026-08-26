{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  ...
}:
{
  options.dots.dev.claude-unstable.enable =
    lib.mkEnableOption "claude-code, sourced from nixpkgs-unstable rather than the pinned nixpkgs";

  config = lib.mkIf config.dots.dev.claude-unstable.enable {
    nixpkgs.overlays = [
      (final: prev: {
        claude-code =
          (import nixpkgs-unstable {
            system = prev.system;
            config.allowUnfree = true;
          }).claude-code;
      })
    ];

    environment.systemPackages = [ pkgs.claude-code ];
  };
}
