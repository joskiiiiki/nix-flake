{ config, pkgs, ... }:
{
  # Razer driver stack + daemon (kernel modules, udev, DBus service)
  hardware.openrazer = {
    enable = true;

    # Your login user — gets added to the "openrazer" group so the
    # daemon runs for you and actually controls the devices.
    users = [ config.var.username ];

    # Lights off whenever the screen is locked / screensaver is active.
    # (This is already the default, but explicit beats implicit.)
    devicesOffOnScreensaver = true;
  };
  environment.systemPackages = [ pkgs.openrgb ];
  services.hardware.openrgb.enable = true;
}
