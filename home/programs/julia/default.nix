{ pkgs, ... }:
{

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # C++ runtime
    stdenv.cc.cc.lib

    # OpenGL / GPU (AMD mesa)
    mesa
    mesa.drivers
    libGL
    libGLU
    vulkan-loader
    vulkan-headers

    rocmPackages.clr
    rocmPackages.rocblas
    rocmPackages.hipblas

    # Wayland + XWayland compat
    wayland
    wayland-protocols
    libxkbcommon
    xorg.libX11
    xorg.libXrender
    xorg.libXext
    xorg.libXfixes
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libxcb

    # Font / text rendering (GR needs these)
    freetype
    fontconfig
    expat

    # General
    zlib
    libz
    glib
    dbus
  ];

  environment.sessionVariables = {
    # Point libGL to mesa (critical for GR and GLMakie on AMD)
    LIBGL_DRIVERS_PATH = "${pkgs.mesa.drivers}/lib/dri";

    # Tell GR where to find its libs when running under nix-ld
    GRDIR = ""; # let GR auto-detect; set to GR depot if needed

    # Wayland hint for Julia/GLFW (used by GLMakie)
    # GLFW_USE_WAYLAND = "1";   # uncomment if GLMakie opens on wrong display
  };

}
