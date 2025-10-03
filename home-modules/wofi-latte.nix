{ config, pkgs, ... }:


{
  programs.wofi = {
    enable = true;
    style =
    ''
      @define-color arasaka #87a5ff;
      @define-color arasakaDark #b0c2f7;
      @define-color arasakaDarker #becdf7;
      @define-color arasakaDarkerer #cbd7f7;
      @define-color background #EEEEEE;
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
