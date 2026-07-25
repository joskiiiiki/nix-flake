{ lib, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  stylix.targets.noctalia.enable = true;
  programs.noctalia = {
    enable = true;

    settings = {
      bar = {
        default = {
          auto_hide = false;
          background_opacity = 0.4999999888241291;
          border_width = 1.0;
          capsule = true;
          capsule_group = [
            {
              enabled = true;
              fill = "surface_variant";
              id = "g1";
              members = [
                "network"
                "bluetooth"
                "volume"
                "brightness"
                "power_profile"
                "battery"
              ];
              opacity = 0.5;
              padding = 8.0;
            }
            {
              enabled = true;
              fill = "surface_variant";
              id = "g3";
              members = [
                "cpu"
                "spacer_2"
                "ram"
                "spacer_2"
                "network_rx"
                "network_tx"
              ];
              opacity = 0.6000000238418579;
              padding = 8.0;
            }
            {
              enabled = true;
              fill = "surface_variant";
              id = "g2";
              members = [
                "clock"
              ];
              opacity = 0.5;
              padding = 8.0;
            }
          ];
          capsule_opacity = 0.4999999888241291;
          capsule_padding = 8.0;
          capsule_thickness = 0.7999999858438969;
          center = [
            "media"
            "group:g2"
            "control-center"
          ];
          concave_edge_corners = false;
          end = [
            "tray"
            "clipboard"
            "group:g1"
            "notifications"
          ];
          margin_edge = 6;
          margin_ends = 400;
          padding = 4;
          position = "bottom";
          radius = 80;
          reserve_space = false;
          smart_auto_hide = true;
          start = [
            "wallpaper"
            "group:g3"
          ];
          thickness = 36;
        };
      };
      calendar = {
        account = {
          personal_google = {
            type = "google";
          };
        };
        enabled = true;
      };
      control_center = {
        shortcuts = [
          {
            type = "wifi";
          }
          {
            type = "bluetooth";
          }
          {
            type = "nightlight";
          }
          {
            type = "notification";
          }
          {
            type = "audio";
          }
          {
            type = "mic_mute";
          }
        ];
      };
      desktop_widgets = {
        enabled = false;
        grid = {
          cell_size = 8;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          desktop-widget-0000000000000001 = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 960.0;
            cy = 540.0;
            output = "DP-1";
            rotation = 0.0;
            type = "clock";
          };
          desktop-widget-0000000000000003 = {
            box_height = 128.0;
            box_width = 288.0;
            cx = 1009.0;
            cy = 668.0;
            output = "DP-1";
            rotation = 0.0;
            settings = {
              layout = "horizontal";
            };
            type = "media_player";
          };
          desktop-widget-0000000000000004 = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 1164.0;
            cy = 540.0;
            output = "DP-1";
            rotation = 0.0;
            type = "weather";
          };
          desktop-widget-0000000000000005 = {
            box_height = 112.0;
            box_width = 104.0;
            cx = 808.0;
            cy = 764.0;
            output = "DP-1";
            rotation = 0.0;
            settings = {
              background_opacity = 0.0;
              background_padding = 0;
              bands = 128;
              centered = true;
              mirrored = false;
              show_when_idle = true;
            };
            type = "audio_visualizer";
          };
        };
        widget_order = [
          "desktop-widget-0000000000000003"
          "desktop-widget-0000000000000001"
          "desktop-widget-0000000000000004"
          "desktop-widget-0000000000000005"
        ];
      };
      dock = {
        background_opacity = 1.0;
      };
      location = {
        address = "Halberstadt, Germany";
      };
      lockscreen_widgets = {
        enabled = false;
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "DP-1";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@HDMI-A-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
            type = "login_box";
          };
          "lockscreen-login-box@winit" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 470.0;
            cy = 935.0;
            output = "winit";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
            type = "login_box";
          };
        };
        widget_order = [
          "lockscreen-login-box@winit"
          "lockscreen-login-box@DP-1"
          "lockscreen-login-box@HDMI-A-1"
        ];
      };
      nightlight = {
        enabled = true;
      };
      notification = {
        background_opacity = 1.0;
      };
      osd = {
        background_opacity = 1.0;
      };
      shell = {
        font_family = "JetBrains Mono Nerd Font";
        launcher = {
          categories = false;
        };
        panel = {
          control_center_placement = "floating";
          open_near_click_control_center = true;
          transparency_mode = "glass";
        };
      };
      wallpaper = {
        default = {
          path = lib.mkForce "/home/johannes/Pictures/imgs/macos-tahoe-26-5120x2880-22674.jpg";
        };
        directory = "/home/johannes/Pictures/imgs";
        enabled = true;
        last = {
          path = "/home/johannes/Pictures/imgs/macos-tahoe-26-5120x2880-22674.jpg";
        };
      };
      widget = {
        clock = {
          format = "{:%a. %d.%m.} - {:%H:%M}";
        };
        control-center = {
          glyph = "settings";
        };
        media = {
          hide_artist = true;
          max_length = 300;
          title_scroll = "on_hover";
        };
        network = {
          show_label = false;
        };
        network_rx = {
          display = "text";
          network_speed_compact = true;
        };
        network_tx = {
          display = "text";
        };
        spacer_2 = {
          type = "spacer";
        };
        volume = {
          show_label = false;
        };
      };
    };
  };
}
