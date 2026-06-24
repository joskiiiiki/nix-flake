{ pkgs, ... }:

{
  xdg.configFile."niri/binds.kdl".text = /* kdl */ ''
    binds {
        Alt+Print { screenshot-window; }
        Ctrl+Alt+Delete { quit; }
        Ctrl+Print { screenshot-screen; }
        Mod+A { focus-column-or-monitor-left; }
        Mod+Alt+period { clear-dynamic-cast-target; }
        Mod+C { close-window; }
        Mod+Ctrl+Q { maximize-column; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=500 { move-window-up-or-to-workspace-up; }
        Mod+Ctrl+WheelScrollUp cooldown-ms=500 { move-window-down-or-to-workspace-down; }
        Mod+D { focus-column-or-monitor-right; }
        Mod+Down { expel-window-from-column; }
        Mod+E { spawn "${pkgs.kitty}/bin/kitty" "-1" "yazi"; }
        Mod+Home { focus-window-previous; }
        Mod+Left { consume-or-expel-window-left; }
        Mod+Next { focus-window-or-workspace-down; }
        Mod+Prior { focus-window-or-workspace-up; }
        Mod+Q { spawn "${pkgs.kitty}/bin/kitty" "-1"; }
        Mod+R cooldown-ms=500 { spawn "menu"; }
        Mod+Right { consume-or-expel-window-right; }
        Mod+S { focus-window-or-workspace-down; }
        Mod+Shift+A { move-column-left-or-to-monitor-left; }
        Mod+Shift+C { spawn "${pkgs.vicinae}/bin/vicinae" "vicinae://extensions/vicinae/clipboard/history"; }
        Mod+Shift+D { move-column-right-or-to-monitor-right; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Shift+Next { move-window-down-or-to-workspace-down; }
        Mod+Shift+Prior { move-window-up-or-to-workspace-up; }
        Mod+Shift+Q { switch-preset-column-width; }
        Mod+Shift+S { move-window-down-or-to-workspace-down; }
        Mod+Shift+W { move-window-up-or-to-workspace-up; }
        Mod+Shift+period { set-dynamic-cast-monitor; }
        Mod+Tab { toggle-overview; }
        Mod+Up { consume-window-into-column; }
        Mod+V { toggle-window-floating; }
        Mod+W { focus-window-or-workspace-up; }
        Mod+WheelScrollDown cooldown-ms=500 { focus-window-or-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=500 { focus-window-or-workspace-up; }
        Mod+X cooldown-ms=500 { spawn "powermenu"; }
        Mod+Y cooldown-ms=500 { spawn "quickmenu"; }
        Mod+period { set-dynamic-cast-window; }
        MouseBack { focus-column-or-monitor-right; }
        MouseForward { focus-column-or-monitor-left; }
        Print { screenshot; }
        Shift+Mod+MouseMiddle { maximize-column; }
        Shift+MouseBack { move-column-right-or-to-monitor-right; }
        Shift+MouseForward { move-column-left-or-to-monitor-left; }
        Shift+MouseMiddle { switch-preset-column-width; }
        XF86AudioLowerVolume { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioRaiseVolume { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
    }
  '';
}
