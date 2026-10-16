{
  config,
  lib,
  ...
}: let
  algorithms = "39796";
  dataScience = "39874";
  databases = "39802";
  compilers = "38069";

  active = [algorithms dataScience databases compilers];
  images = {
    ${algorithms} = "https://canvas.sussex.ac.uk/images/thumbnails/5147631/WcMTB8al50KqykfEOVjqZ6DFSVbUd7puZWpv0R1S";
    ${compilers} = "https://t2informatik.de/en/wp-content/uploads/sites/2/2023/03/compiler.png";
  };

  card = id: ''.ic-DashboardCard:has(a[href="/courses/${id}"])'';

  dimRules = ''
    .ic-DashboardCard:not(:hover) { opacity: 0.25 !important; }
    ${lib.concatMapStrings (id: ''
        ${card id} { opacity: 1 !important; }
      '')
      active}
  '';

  imageRules = lib.concatStrings (lib.mapAttrsToList (id: url: ''
      ${card id} .ic-DashboardCard__header_hero {
        background-image: url("${url}") !important;
        background-size: cover !important;
        background-position: center !important;
      }
    '')
    images);
in {
  options.dots.canvasPatch.enable = lib.mkEnableOption "Canvas dashboard tweaks via Firefox userContent.css";

  config = lib.mkIf config.dots.canvasPatch.enable {
    home-manager.users = lib.genAttrs config.mikoshi.meta.users (user: {
      programs.firefox = {
        enable = true;
        profiles.default = {
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
