{
  lib,
  config,
  ...
}:
let
  controllerKeys = {
    m1k1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAHaK1ZfIKnemj7B5ZB8FBgJHi17R9fAvVfw9cZjbuU cheryllamb@m1k1";
    phone = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxqUwKe31pXQ1ahsNrbaGaHi8YYllaPObF2TOdbC/pg";
  };
in
{
  options.dots = {
    ssh.allowFrom = lib.mkOption {
      type = lib.types.listOf (lib.types.enum (lib.attrNames controllerKeys));
      default = [ ];
      description = "Hosts whose key gets added to cheryllamb's list of authorised keys";
    };
  };
  config = lib.mkIf (config.dots.ssh.allowFrom != [ ]) {
    users.users.cheryllamb.openssh.authorizedKeys.keys = lib.map (
      name: controllerKeys.${name}
    ) config.dots.ssh.allowFrom;

    services.openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 22 ];
  };

}
