{ pkgs, ... }:
{
  # For 24.11
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    mesa.opencl
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # hardware.opengl = {
  #   enable = true;
  #   # driSupport = true;
  #   # driSupport32Bit = true;
  # };
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
}
