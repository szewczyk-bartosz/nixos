{...}: {
  services.tailscale.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.blacklistedKernelModules = ["rxrpc"];
}
