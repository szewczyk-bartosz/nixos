{
  lib,
  config,
  ...
}: let
  controllerKeys = {
    m1k1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAHaK1ZfIKnemj7B5ZB8FBgJHi17R9fAvVfw9cZjbuU cheryllamb@m1k1";
    phone = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxqUwKe31pXQ1ahsNrbaGaHi8YYllaPObF2TOdbC/pg";
  };
in {
  options.dots = {
    ssh.users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options.allowFrom = lib.mkOption {
          type = lib.types.listOf (lib.types.enum (lib.attrNames controllerKeys));
          default = [];
          description = "Hosts whose keys will get added to the parent's list of authorised keys";
        };
      });
    };
    ssh.openTailscale = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "If true, port 22 is only opened on the tailscale0 interface.";
    };

    ssh.openPublic = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "If true, port 22 is opened for ssh connections";
    };

  };
  config = lib.mkIf (config.dots.ssh.openPublic || config.dots.ssh.openTailscale) {
    users.users = lib.mapAttrs (_: config: 
        {
        openssh.authorizedKeys.keys = lib.map (name: controllerKeys.${name}) config.dots.ssh.allowFrom;
        }
    ) config.dots.ssh.users;

    services.fail2ban = {
      enable = config.dots.ssh.openPublic;
      maxretry = 8;
      bantime = "1h";
      bantime-increment.enable = true;
    };

    services.openssh = {
      enable = true;
      openFirewall = config.dots.ssh.openPublic;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = lib.mkIf config.dots.ssh.openTailscale [
      22
    ];
  };
}
