{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    libfaketime
    ddcutil
    openjdk
  ];
  xdg.terminal-exec.settings.default = [ "kitty.desktop" ];
  imports = [
    # ../home/system/gnome/system.nix
    ../home/system/niri/system.nix
    # ../home/system/mango/system.nix
    ../nixos/printing.nix
    ../nixos/docker.nix
    # ../home/programs/flatpak/system.nix
  ];
  stylix.targets.plymouth.enable = true;
  services.gvfs.enable = true;

  boot.kernelModules = [
    "i2c-dev"
    "i2c-algo-bit"
  ];
  hardware.i2c.enable = true;
}
