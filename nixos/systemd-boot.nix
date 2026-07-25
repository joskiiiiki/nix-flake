{ pkgs, config, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    plymouth = {
      enable = true;
      #   theme = "dna";
      #   themePackages = with pkgs; [
      #     # By default we would install all themes
      #     (adi1090x-plymouth-themes.override {
      #       selected_themes = [ "rings" ];
      #     })
      #   ];
    }; # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "psmouse.synaptics_intertouch=0"
    ];
    initrd.verbose = false;
  };
}
