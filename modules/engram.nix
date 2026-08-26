{
  config,
  lib,
  ...
}:
let
  syncthingDevices = {
    m1k1 = "C7TARJK-2YVSJ5G-GM2EDGL-A3HC27H-VM4XVYG-4NTPBZF-YJNOHQ6-73HQWQS";
    t3kl4 = "JP27KOO-FKJSWJ6-QOS7WDL-S2Y3373-GHK4M2M-DX37F7A-UUKUDLF-QJPXKA7";
    k1v1 = "<K1V1-ID>";
  };
  peers = lib.filterAttrs (name: _: name != config.networking.hostName) syncthingDevices;
in
{
  options.dots.engram = {
    enable = lib.mkEnableOption "engram: sync notes to the fleet via syncthing over tailscale";
  };

  config = lib.mkIf config.dots.engram.enable {
    services.tailscale.enable = true;
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
        devices = lib.mapAttrs (name: id: {
          inherit id;
          addresses = [ "tcp://${name}:22000" ];
        }) peers;
        folders."engram-raw" = {
          path = "/home/cheryllamb/engram-data/raw";
          devices = lib.attrNames peers;
        };
      };
    };
  };
}
