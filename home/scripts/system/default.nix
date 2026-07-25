# - ## System
#-
#- Usefull quick scripts
#-
#- - `menu` - Open wofi with drun mode. (wofi)
#- - `powermenu` - Open power dropdown menu. (wofi)
#- - `lock` - Lock the screen. (hyprlock)
{ pkgs, ... }:

let
  dmenu =
    {
      pl ? "",
    }:
    "noctalia dmenu -p \"${pl}\"";
  mirror =
    pkgs.writeScriptBin "screen-mirror" # nu
      ''
        #!/usr/bin/env nu
        let focused: string = niri msg --json focused-output | from json | get name
        let outputs: list = niri msg --json outputs | from json | columns 

        let unfocused_outputs = $outputs | where $it != $focused;

        let target = $unfocused_outputs | to text | ${dmenu { pl = "Select an output..."; }}

        ${pkgs.wl-mirror}/bin/wl-mirror --fullscreen-output $target $focused
      '';

  powermenu = pkgs.writeScriptBin "powermenu" /* nu */ ''
    #!/usr/bin/env nu
    if (pidof dms | is-not-empty ) {
      dms ipc call powermenu open
      
    } else {
      let opts = {
        "󰍃  Logout": {|| niri msg action quit}
        "  Suspend": {|| systemctl suspend}
        "󰑐  Reboot": {|| systemctl reboot}
        "󰿅  Shutdown": {|| systemctl poweroff}
      }

      let selected = $opts | columns | str join "\n" | ${dmenu { pl = "Select an action ..."; }}

      do ($opts | get $selected)
    }
  '';
  powermode = pkgs.writeScriptBin "powermode" /* nu */ ''
    #!/usr/bin/env nu
    let opts = {
      "󰾆  Battery Saver": "power-saver"
      "󰾅  Balanced": "balanced"
      "󰓅  Performance": "performance"
    }

    let selected = $opts | columns | str join "\n" | ${dmenu { pl = "Select an action ..."; }}

    let value = $opts | get $selected
    powerprofilesctl set $value
    notify-send $"($selected) enabled" -a "Power Profiles" -i battery-symbolic

    '';

  quickmenu = pkgs.writeScriptBin "quickmenu" /* nu */ ''
      #!/usr/bin/env nu
      let opts = {
          "󰈊  Hyprpicker": {|| sleep 200ms;  ${pkgs.hyprpicker}/bin/hyprpicker -a}
          "󱜤  Screen Mirror": {|| screen-mirror}
          "󰚥  Power Mode": {|| powermode}
      }

      let selected = $opts | columns | str join "\n" | ${dmenu { pl = "Select an action ..."; }}
      do ($opts | get $selected)
  '';

in
{
  home.packages = [
    powermenu
    quickmenu
    mirror
    powermode
  ];
}
