{
  pkgs,
  config,
  lib,
  ...

}: let
    mkTemplate = pkgs.writeShellApplication {
      name = "mkTemplate";
      runtimeInputs = [ pkgs.git pkgs.nix ];
      text = ''
        if [[ $# -lt 1 || $# -gt 2 ]]; then
          echo "Usage: mkTemplate <template> [directory]"
          echo ""
          echo "Arguments:"
          echo "  template    Name of the Nix flake template"
          echo "  directory   Optional directory to create the project in"
          echo "Warning: without a second argument, will initiate in the current dir"
          exit 1
        fi

        if [[ $# -eq 2 ]]; then
          mkdir "$2"
          cd "$2"
        fi

        nix flake init -t "github:szewczyk-bartosz/shells#$1" --refresh
        git init
        git add .
        direnv allow
        '';
    };
in {
  options.dots.shellScripts = {
    mkTemplate.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "whether to enable mkTemplate script for creating a project template";
    };
  };
  config = {
    environment.systemPackages = lib.optional config.dots.shellScripts.mkTemplate.enable mkTemplate;   
  };
}
