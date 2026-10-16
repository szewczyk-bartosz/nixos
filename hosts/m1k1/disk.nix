{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_2TB_2451CT400968";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["fmask=0077" "dmask=0077"];
                extraArgs = ["-n" "NIXBOOT"];
              };
            };
            swap = {
              size = "40G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = ["-L" "NIXROOT"];
              };
            };
          };
        };
      };

      external = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_870_QVO_1TB_S5RRNF0W414762W";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home/cheryllamb/ssd";
                extraArgs = ["-L" "BIG_STORAGE"];
              };
            };
          };
        };
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /home/cheryllamb/ssd 0755 cheryllamb users - -"
  ];
}
