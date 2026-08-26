{
  lib,
  config,
  ...
}:
{
  options.dots.remoteDeployment.enable = lib.mkEnableOption "allow cheryllamb to be a trusted user so remote deployment is possible without root access";

  config = lib.mkIf config.dots.remoteDeployment.enable {
    nix.settings.trusted-users = [ "root" "cheryllamb" ];
  };

}
