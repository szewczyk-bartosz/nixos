{
  config,
  lib,
  ...
}: let
  syncthingDevices = {
    m1k1 = "<M1K1-DEVICE-ID>";
    k1v1 = "<K1V1-DEVICE-ID>";
    t3kl4 = "<T3KL4-DEVICE-ID>";
    pr1mk4 = "<PR1MK4-DEVICE-ID>";
    virt = "<VIRT-DEVICE-ID>";
  };
  peers = lib.filterAttrs (name: _: name != config.networking.hostName) syncthingDevices;
in {
  services.tailscale.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.blacklistedKernelModules = ["rxrpc"];

  systemd.tmpfiles.rules = [
    "d /home/cheryllamb/engram-data/raw 0755 cheryllamb users - -"
  ];
  services.syncthing = {
    enable = true;
    user = "cheryllamb";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
    dataDir = "/home/cheryllamb/.syncthing/data";
    configDir = "/home/cheryllamb/.syncthing/config";
    settings = {
      options = {
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
      };
      devices =
        lib.mapAttrs (name: id: {
          inherit id;
          addresses = ["tcp://${name}:22000"];
        })
        peers;
      folders."engram-raw" = {
        path = "/home/cheryllamb/engram-data/raw";
        devices = lib.attrNames peers;
      };
    };
  };
}
