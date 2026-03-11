{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.enable = true;
  networking.hostName = "t3kl4";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
  ];
  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];
  users.users.cheryllamb = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [];
    initialHashedPassword = "$y$j9T$Gr446qulQ0U51PTb0aJog1$UTxOM8SaTVsk2zKt0aSST8IXfdNeDj5rPzVwG8.BBH2
";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWIO068BP8YipXaSHkjJL/xzyv2PBfveoXt5Z9GsSKM cheryllamb@m1k1"
    ];
  };

  system.stateVersion = "25.11";
}
