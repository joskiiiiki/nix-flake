{ config, lib, ... }:
let
  capitalize =
    set:
    builtins.mapAttrs (
      name: value: if builtins.isString value then "#" + (lib.toUpper value) else value
    ) set;
  colors = capitalize config.lib.stylix.colors;
  content = {
    "Appearance-dark@@theme-dark-style-select" = "theme-dark-background-darker";
    "Appearance-dark@@accent-dark" = "${colors.base0D}";
    "Appearance-dark@@card-layout-open-dark" = true;
    "Editor@@border-focus-mode" = true;
    "Components@@tab-autohide" = false;
    "Components@@status-bar-autohide" = false;
    "Components@@Ribbon-autohide" = true;
    "Components@@nav-header-autohide" = true;
    "Components@@tab-title-bar-autohide" = false;
    "Components@@vault-profile-autohide" = false;
    "Appearance-dark@@background-primary-alt@@dark" = "${colors.base00}";
    "Appearance-dark@@background-underlying-select-dark" = "background-underlying-primary-dark";
    "Appearance-dark@@background-secondary@@dark" = "${colors.base01}";
    "Appearance-dark@@accent-color-override-dark" = true;
    "Appearance-dark@@color-red-rgb@@dark" = "${colors.base0E}";
    "Appearance-dark@@color-orange-rgb@@dark" = "${colors.base09}";
    "Appearance-dark@@color-yellow-rgb@@dark" = "${colors.base0A}";
    "Appearance-dark@@color-green-rgb@@dark" = "${colors.base0D}";
    "Appearance-dark@@color-cyan-rgb@@dark" = "${colors.base0C}";
    "Appearance-dark@@color-blue-rgb@@dark" = "${colors.base0A}";
    "Appearance-dark@@color-pink-rgb@@dark" = "${colors.base08}";
    "Appearance-dark@@color-purple-rgb@@dark" = "${colors.base0B}";
    "Appearance-dark@@background-tertiary@@dark" = "${colors.base01}";
    "Appearance-dark@@background-modifier-hover@@dark" = "${colors.base02}";
    "Appearance-dark@@background-modifier-active-hover@@dark" = "${colors.base04}";
    "Appearance-dark@@background-modifier-border@@dark" = "${colors.base02}";
    "Appearance-dark@@background-modifier-border-hover@@dark" = "${colors.base04}";
    "Appearance-dark@@background-modifier-border-focus@@dark" = "${colors.base03}";
    
    "Appearance-dark@@background-secondary-alt@@dark" = "${colors.base01}";
    "Appearance-dark@@workspace-background-translucent@@dark" = "${colors.base02}";
    "Appearance-dark@@text-normal@@dark" = "${colors.base07}";
    "Appearance-dark@@text-muted@@dark" = "${colors.base06}";
    "Appearance-dark@@text-faint@@dark" = "${colors.base05}";
    "Appearance-dark@@text-accent@@dark" = "#26BBD9";
    "Appearance-dark@@text-accent-hover@@dark" = "#3FC6DE";
    "Appearance-dark@@text-on-accent@@dark" = "#59E3E3";
    "Appearance-dark@@text-on-accent-inverted@@dark" = "#6BE6E6";
    "Appearance-dark@@card-border-radius-dark" = "10px";
    "Editor@@line-active-bg@@light" = "#232530";
    "Editor@@line-active-bg@@dark" = "#232530";
    "Editor@@editor-grid-background-pattren" = false;
    "Components@@outline-enhanced" = false;
    "Editor@@line-normal-opacity" = 0.75;
    "Editor@@table-width-select" = "table-width-customized";
    "Editor@@table-width" = 60;
    "Editor@@callout-border-opacity" = 1;
    "Editor@@callout-title-color@@light" = "#000FFF";
    "Appearance-dark@@background-primary@@dark" = "${colors.base00}";
  };
in
{
  imports = [ ./theme.nix ];
  home.file.".style-settings.json".text = builtins.toJSON content;
}
