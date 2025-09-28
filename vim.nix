{ config, pkg, ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = 
    ''
      set number
      set expandtab
      set tabstop=2
      set shiftwidth=2
      inoremap jk <ESC>
      syntax on
    '';
  };
}
