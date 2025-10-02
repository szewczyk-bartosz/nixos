{ config, pkgs, ... }:


{
  programs.wofi = {
    enable = true;
    style =
    ''
      @define-color arasaka #87a5ff;
      @define-color arasakaDark #3d528f;
      @define-color arasakaDarker #253973;
      @define-color arasakaDarkerer #131f40;
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
