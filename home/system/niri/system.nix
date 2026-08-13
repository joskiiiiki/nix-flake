{ pkgs, config, inputs, ... }: {

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
  environment = {
    variables.NIXOS_OZONE_WL = "1";
    sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite
      xdg-desktop-portal-gtk
    ];
  };
}
