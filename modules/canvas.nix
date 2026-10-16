{
  config,
  lib,
  ...
}: let
  cfg = config.dots.canvas;
  card = id: ''.ic-DashboardCard:has(a[href="/courses/${id}"])'';

  dimRules = lib.optionalString (cfg.active != []) ''
    .ic-DashboardCard:not(:hover) { opacity: ${toString cfg.dimOpacity} !important; }
    ${lib.concatMapStrings (id: ''
        ${card id} { opacity: 1 !important; }
      '')
      cfg.active}
  '';

  imageRules = lib.concatStrings (lib.mapAttrsToList (id: url: ''
      ${card id} .ic-DashboardCard__header_hero {
        background-image: url("${url}") !important;
        background-size: cover !important;
        background-position: center !important;
      }
    '')
    cfg.images);
in {
  options.dots.canvas = {
    enable = lib.mkEnableOption "Canvas dashboard tweaks via Firefox userContent.css";

    profile = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "Name of the home-manager Firefox profile to apply the CSS to.";
    };

    active = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["39796"];
      description = "Course IDs shown at full opacity. Every other card is dimmed. Empty means nothing is dimmed.";
    };

    dimOpacity = lib.mkOption {
      type = lib.types.float;
      default = 0.1;
      description = "Opacity of non-active cards.";
    };

    images = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      example = {"39796" = "https://canvas.sussex.ac.uk/images/thumbnails/...";};
      description = "Course ID to banner image URL.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users = lib.genAttrs config.mikoshi.meta.users (user: {
      programs.firefox = {
        enable = true;
        profiles.${cfg.profile} = {
          settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          userContent = ''
            @-moz-document domain("canvas.sussex.ac.uk") {
            ${dimRules}
            ${imageRules}
            }
          '';
        };
      };
    });
  };
}
