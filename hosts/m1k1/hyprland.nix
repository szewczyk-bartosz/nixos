{...}: {
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "spotify"
      "steam"
    ];

    # render.direct_scanout = lib.mkForce 1;

    windowrule = [
      "match:class ^([Ss]potify)$, workspace special:music, float on, size 2200  1100, center on"
      "match:class ^([Ss]team)$, workspace special:steam, float on, size 2200 1100, center on"
      "no_blur on, match:class ^([Aa]wakened-poe-trade)$"
      "match:class steam_app_.*, workspace 3, float off, fullscreen on"
    ];

    workspace = [
      "3, gapsin:0, gapsout:0, bordersize:0, rounding:0, decorate:false"
      # "3, defaultName:gaming, gapsin:0, gapsout:0, border:false, rounding:false, decorate:false"
    ];

    bind = [
      "$mainMod, S, togglespecialworkspace, music"
      "$mainMod, W, togglespecialworkspace, steam"
    ];
  };
}
