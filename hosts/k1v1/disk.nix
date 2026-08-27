{
  disko.devices = {
    main = {
      type = "disk";
      device = "/dev/nvme0n1";
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
              mountOptions = [
                "fmask=0077"
                "dmask=0077"
              ];
              extraArgs = [
                "-n"
                "NIXBOOT"
              ];
            };
          };
          swap = {
            size = "40G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
              extraArgs = [
                "-L"
                "NIXSWAP"
              ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              extraArgs = [
                "-L"
                "NIXROOT"
              ];
            };
          };
        };
      };
    };
  };
}
