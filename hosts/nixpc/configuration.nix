{ config, ... }:
{
  imports = [
    ../../nixos/amd.nix # GPU SHIT FOR AMD
    ../../nixos/audio.nix
    # ../../nixos/auto-upgrade.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/razer.nix
    ../../nixos/network-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/xdg-portal.nix
    ../../nixos/variables-config.nix
    ../../nixos/qemu.nix
    ../../nixos/docker.nix
    ../../themes/stylix/nixy.nix

    ../../shared/configuration.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  services.gvfs.enable = true;

  # fileSystems."/mnt/space" = {
  #   device = "/dev/disk/by-uuid/aa22865e-7e8a-43d1-a164-c446dfa9f62f";
  #   fsType = "ext4";
  #   options = [
  #     "users"
  #     "nofail"
  #     "exec"
  #     "rw"
  #     "user_xattr"
  #     "acl"
  #   ];
  # };

  home-manager.users."${config.var.username}" = import ./home.nix;
  home-manager.backupFileExtension = "backup";
  # Don't touch this
  system.stateVersion = "26.05";
}
