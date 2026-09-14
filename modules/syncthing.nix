{
  config,
  lib,
  ...
}: let
  syncthingDevices = {
    m1k1 = "TDHIEIT-KHXUAZS-ED66URH-T5RZTLL-EXY6G4F-HSISC4S-A3P6XTW-HU3JWQK";
    t3kl4 = "NXG3N4Q-5EBYPZB-EL7H5UX-AFVPGDO-NFCFDFY-FSSXMTV-SEUKT2U-ASLXOQX";
    # k1v1 = "<K1V1-ID>";
  };
  peers = lib.filterAttrs (name: _: name != config.networking.hostName) syncthingDevices;
in {
  options.dots.syncthing = {
    enable = lib.mkEnableOption "engram: sync notes to the fleet via syncthing over tailscale";
  };

  config = lib.mkIf config.dots.syncthing.enable {
    services.tailscale.enable = true;
    systemd.services.syncthing = {
      after = ["systemd-tmpfiles-setup.service"];
      requires = ["systemd-tmpfiles-setup.service"];
    };
    services.syncthing = {
      overrideDevices = true;
      overrideFolders = true;
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
          path = "/home/cheryllamb/engram-data/";
          devices = lib.attrNames peers;
        };
      };
    };
  };
}
