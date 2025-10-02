{ config, pkgs, ... }:


{
  programs.wofi = {
    enable = true;
    style =
    ''
      @define-color arasaka #EE0000;
      @define-color arasakaDark #880000;
      @define-color arasakaDarker #440000;
      @define-color arasakaDarkerer #330000;
      @define-color background #090909;
      * {
        font-family: JetbrainsMono Nerd Font;
        color: @arasaka;
      }

      window {
        background-color: @background;
      }

      #input {
        background-color: @background;
        border-color: @arasakaDark;
      }

      #entry:selected {
        background-color: @arasakaDarkerer;
      }

      #input:focus,
      #input:focus-visible,
      #input:active {
        border-color: @arasakaDark;
        box-shadow: none;
        outline: none
      }
        '';
    };
}
