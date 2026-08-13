{ config, lib, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  foreground = "#${config.lib.stylix.colors.base05}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";

  c0 = "#${config.lib.stylix.colors.base00}";
  c1 = "#${config.lib.stylix.colors.base08}";
  c2 = "#${config.lib.stylix.colors.base0B}";
  c3 = "#${config.lib.stylix.colors.base0A}";
  c4 = "#${config.lib.stylix.colors.base0D}";
  c5 = "#${config.lib.stylix.colors.base0E}";
  c6 = "#${config.lib.stylix.colors.base0C}";
  c7 = "#${config.lib.stylix.colors.base05}";
  c8 = "#${config.lib.stylix.colors.base03}";
  c9 = "#${config.lib.stylix.colors.base08}";
  cA = "#${config.lib.stylix.colors.base0B}";
  cB = "#${config.lib.stylix.colors.base0A}";
  cC = "#${config.lib.stylix.colors.base0D}";
  cD = "#${config.lib.stylix.colors.base0E}";
  cE = "#${config.lib.stylix.colors.base0C}";
  cF = "#${config.lib.stylix.colors.base07}";

in
{

  # Generate the home.file content using the base16 colors
  # Create the home.file for configuration
  home.file = lib.mkForce {
    ".config/gtk-4.0/gtk.css".text = lib.mkForce ''
      @define-color accent_color ${c4};
      @define-color accent_bg_color ${c1};
      @define-color accent_fg_color ${c3};
      @define-color destructive_color ${c7};
      @define-color destructive_bg_color ${c7};
      @define-color destructive_fg_color ${c3};
      @define-color success_color ${cB};
      @define-color success_bg_color ${cB};
      @define-color success_fg_color ${c3};
      @define-color warning_color ${cA};
      @define-color warning_bg_color ${cA};
      @define-color warning_fg_color ${c3};
      @define-color error_color ${c7};
      @define-color error_bg_color ${c7};
      @define-color error_fg_color ${c3};
      @define-color window_bg_color ${c0};
      @define-color window_fg_color ${c3};
      @define-color view_bg_color ${c0};
      @define-color view_fg_color ${c3};
      @define-color headerbar_bg_color ${c1};
      @define-color headerbar_fg_color ${c3};
      @define-color headerbar_border_color rgba(0.179688, 0.218750, 0.234375, 0.7);
      @define-color headerbar_backdrop_color ${c0};
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
      @define-color sidebar_bg_color ${c1};
      @define-color sidebar_fg_color ${c3};
      @define-color sidebar_backdrop_color ${c0};
      @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
      @define-color secondary_sidebar_bg_color ${c1};
      @define-color secondary_sidebar_fg_color ${c3};
      @define-color secondary_sidebar_backdrop_color ${c0};
      @define-color secondary_sidebar_shade_color rgba(0, 0, 0, 0.07);
      @define-color card_bg_color ${c1};
      @define-color card_fg_color ${c3};
      @define-color card_shade_color rgba(0, 0, 0, 0.07);
      @define-color dialog_bg_color ${c1};
      @define-color dialog_fg_color ${c3};
      @define-color popover_bg_color ${c1};
      @define-color popover_fg_color ${c3};
      @define-color popover_shade_color rgba(0, 0, 0, 0.07);
      @define-color shade_color rgba(0, 0, 0, 0.07);
      @define-color scrollbar_outline_color ${c2};
    '';
  };
}
