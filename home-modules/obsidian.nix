{ config, pkg, ... }:

{
  programs.obsidian = {
    enable = true;
    defaultSettings.communityPlugins = [ "vimrc-support" ];
  };
}
