{ pkgs, config, ... }:
let
  accent     = "#${config.lib.stylix.colors.base0D}";
  background = "#${config.lib.stylix.colors.base00}";
  border = "#${config.lib.stylix.colors.base04}";
  border-size = toString config.var.theme.border-size;
  gaps-out = toString config.var.theme.gaps-out;
  rounding = toString config.var.theme.rounding;
  blur = if config.var.theme.blur then "on" else "off";
in
{
  imports = [ ./binds.nix ];

  programs.niri.config = null;

  xdg.configFile."niri/config.kdl".text = /* kdl */ ''
    include "~/.config/niri/binds.kdl"
    input {
        keyboard {
            xkb {
                layout "de"
                model ""
                rules ""
                variant ""
            }
            repeat-delay 300
            repeat-rate 50
            track-layout "global"
        }
        touchpad {
            tap
            natural-scroll
            click-method "clickfinger"
        }
        focus-follows-mouse max-scroll-amount="10%"
    }
    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d %H-%M-%S.png"
    prefer-no-csd
    overview { backdrop-color "${background}"; }
    layout {
        gaps ${gaps-out}
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
        focus-ring {
            width ${border-size}
            active-color "${accent}"
        }
        border {
            width ${border-size}
            active-color "${accent}"
            inactive-color "${border}"
        }
        background-color "transparent"
        tab-indicator {
            hide-when-single-tab
            gap 5.0
            width 4.0
            length total-proportion=0.333333
            position "right"
            gaps-between-tabs 0.0
            corner-radius ${rounding}
        }
        default-column-width { proportion 0.5; }
        preset-column-widths {
            proportion 0.333333
            proportion 0.5
            proportion 1.0
            proportion 0.666667
        }
        center-focused-column "on-overflow"
        default-column-display "tabbed"
        always-center-single-column
        empty-workspace-above-first
    }
    cursor {
        xcursor-theme "WhiteSur-cursors"
        xcursor-size 24
    }
    hotkey-overlay { skip-at-startup; }
    clipboard { disable-primary; }
    environment {
        "ANKI_WAYLAND" "1"
        "CLUTTER_BACKEND" "wayland"
        "DISABLE_QT5_COMPAT" "0"
        DISPLAY ":0"
        "ELECTRON_OZONE_PLATFORM_HINT" "auto"
        "GTK_THEME" "adw-gtk3"
        "MOZ_ENABLE_WAYLAND" "1"
        "NIXOS_OZONE_WL" "1"
        "QT_AUTO_SCREEN_SCALE_FACTOR" "1"
        "QT_QPA_PLATFORM" "wayland"
        "QT_QPA_PLATFORMTHEME" "gtk3"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"
        "SDL_VIDEODRIVER" "wayland"
        "CLAUDE_USE_WAYLAND" "1"
        TERM "kitty"
        TERMINAL "kitty"
        "WLR_BACKEND" "vulkan"
        "WLR_DRM_NO_ATOMIC" "1"
        "WLR_NO_HARDWARE_CURSORS" "1"
        "WLR_RENDERER" "vulkan"
        "XDG_CURRENT_DESKTOP" "Niri"
        "XDG_SESSION_DESKTOP" "Niri"
        "XDG_SESSION_TYPE" "wayland"
        "__GL_GSYNC_ALLOWED" "0"
        "__GL_VRR_ALLOWED" "0"
    }
    spawn-at-startup "noctalia"
    window-rule {
        draw-border-with-background false
        geometry-corner-radius ${rounding} ${rounding} ${rounding} ${rounding}
        clip-to-geometry true
    }
    layer-rule {
      match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
      background-effect {
        xray false
        // blur false
      }
    }
    layer-rule {
        match namespace="quickshell"
        match namespace="swww-daemon"
        place-within-backdrop true
    }

    layer-rule {
      match namespace="^noctalia-wallpaper"
      place-within-backdrop true
    }
    blur {
        ${blur}
        passes 2
<<<<<<< HEAD
        offset 2
        noise 0.03
=======
        offset 7
        noise 0.03
>>>>>>> 65560a7afb8123dc50b6abd6a9d670e9af88773f
        saturation 1.5
    }
    debug {
      // Allows notification actions and window activation from Noctalia.
      honor-xdg-activation-with-invalid-serial
    }
  '';
}
