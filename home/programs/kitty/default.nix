{ lib, pkgs, ... }:
{

  programs.kitty = {
    enable = true;
    keybindings = {
      "alt+q" = "new_window";
      "alt+a" = "previous_window";
      "alt+d" = "next_window";
      "alt+c" = "close_window";
      "shift+alt+q" = "next_layout";
      "ctrl+alt+a" = "previous_tab";
      "ctrl+alt+d" = "next_tab";
      "ctrl+alt+c" = "close_tab";
      "ctrl+alt+q" = "new_tab";
      "shift+alt+a" = "move_window_backward";
      "shift+alt+d" = "move_window_forward";
      "shift+alt+w" = "move_window_to_top";
    };
    settings = {
      placement_strategy = "top-left";
      scrollback_lines = 10000;
      initial_window_width = 1200;
      initial_window_height = 600;
      update_check_interval = 0;
      enable_audio_bell = false;
      confirm_os_window_close = "0";
      remember_window_size = "no";
      disable_ligatures = "never";
      url_style = "curly";
      cursor_shape = "Underline";
      cursor_underline_thickness = 3;
      window_padding_width = 10;
      background_opacity = lib.mkForce 0.9;
      background_blur = 64;
      hide_window_decorations = true;
      tab_bar_edge = "bottom";
      tab_style = "slant";
      tab_switch_strategy = "left";
      enabled_layouts = "grid,horizontal,vertical";
    };
  };
}
