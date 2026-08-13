{ pkgs, inputs, ... }:
{
  stylix = {
    enable = true;

    # Horizon Terminal
    base16Scheme = {
      base00 = "#000000";
      base01 = "#1f1f1f";
      base02 = "#2e2e2e";
      base03 = "#a1a1a1";
      base04 = "#878787";
      base05 = "#ededed";
      base06 = "#f5f5f5";
      base07 = "#ffffff";
      base08 = "#52a8ff";
      base09 = "#ff9907";
      base0A = "#52a8ff";
      base0B = "#c472fb";
      base0C = "#52a8ff";
      base0D = "#62c073";
      base0E = "#1da9b0";
      base0F = "#f75f8f";
    };

    cursor = {
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };
    opacity.terminal = 0.8;
    polarity = "dark";
    image = ./a.png;
  };
  stylix.targets.chromium.enable = true;
  stylix.targets.gtk.enable = true;
  # stylix.targets.hyprland.hyprpaper.enable = false;

  stylix.targets.nixvim.enable = false;
}
