# GTK & QT theme configuration
{ config, pkgs, lib, ... }: {
  qt = {
    enable = true;
    platformTheme = { name = lib.mkForce "adwaita"; };
    # style.name = lib.mkForce "adwaita-dark";
  };

  gtk = {
    enable = true;
    theme = lib.mkForce {
      package = pkgs.adw-gtk3;

      name = "adw-gtk3";
    };

    # iconTheme = {
    #   package = pkgs.whitesur-icon-theme.override {
    #     themeVariants = [ "all" ];
    #     alternativeIcons = true;
    #   };
    #   name = "WhiteSur";
    # };

    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy-green-dark";
    };

    font = { name = config.stylix.fonts.sansSerif.name; };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };

    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
}
