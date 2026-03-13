{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wget
    git
    rustc
    cargo
    rustfmt
    maven
    jdk
    python313
  ];
}
