{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  opacity = config.var.theme.system-opacity;
  rounding = config.var.theme.rounding;
  blur = config.var.theme.blur;
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  xdg.dataFile."vicinae/themes/system.toml".source =
    let
      stylix = config.lib.stylix.colors;
      toml = pkgs.formats.toml { };
      theme = {
        version = 1;
        name = "System";
        description = "System";
        variant = "dark";
        inherits = "vicinae-dark";
        colors.core = {
          background = "#${stylix.base00}";
          foreground = "#${stylix.base05}";
          secondary_background = "#${stylix.base01}";
          border = "#${stylix.base03}";
          accent = "#${stylix.base0A}";
        };
        colors.accents = {
          blue = "#${stylix.base0D}";
          green = "#${stylix.base0B}";
          magenta = "#${stylix.base0E}";
          orange = "#${stylix.base09}";
          purple = "#${stylix.base0E}";
          red = "#${stylix.base08}";
          yellow = "#${stylix.base0A}";
          cyan = "#${stylix.base0C}";
        };
      };
    in
    toml.generate "system.toml" theme;

  home.packages = with pkgs; [ vicinae ];
  programs.vicinae = {
    enable = true; # default: false
    package = pkgs.vicinae;
    settings = {
      closeOnFocusLoss = true;
      considerPreedit = false;
      faviconService = "twenty";
      font = {
        normal = {
          family = config.var.theme.font.name;
          size = 11;
        };
      };
      keybinding = "default";
      keybinds = { };
      popToRootOnClose = true;
      rootSearch = {
        searchFiles = true;
      };
      theme = {
        iconTheme = "Nordzy-cyan";
        name = "stylix";
      };
      window = {
        opacity = lib.mkForce (if blur then opacity else 1.0);
        csd = false;
        rounding = rounding;
      };
    };

  };
}
