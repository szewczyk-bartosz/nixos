{ config, pkg, ... }:

{
  programs.helix = {
    enable = true;
    settings  = {
      theme = "peachpuff";
      keys.insert = {
        j.k = "normal_mode";
      };
    };
  };
  
}
