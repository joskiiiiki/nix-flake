# /etc/nixos/flake.nix
# NixOS system flake — AMD GPU, Wayland, Julia GLMakie/GR
{
  description = "NixOS system config — AMD + Wayland + Julia plotting";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hardware-configuration.nix

        # ── nix-ld: lets upstream/unpatched binaries run on NixOS ──────────
        {
          programs.nix-ld.enable = true;

          # Libraries that GR and GLMakie dlopen at runtime.
          # AMD mesa provides the OpenGL/Vulkan stack; the rest are
          # X11 compat libs needed even under XWayland.
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
            amdvlk              # AMD Vulkan driver

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
        }

        # ── AMD GPU driver ──────────────────────────────────────────────────
        {
          hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [
              amdvlk
              mesa
              rocm-opencl-icd    # optional: OpenCL for GPU compute
              rocm-opencl-runtime
            ];
          };

          # amdgpu kernel module (usually auto-detected, but explicit is safer)
          boot.initrd.kernelModules = [ "amdgpu" ];
          services.xserver.videoDrivers = [ "amdgpu" ];
        }

        # ── Wayland compositor essentials ───────────────────────────────────
        # Adjust to your compositor (Hyprland, sway, GNOME, etc.)
        {
          # XDG portal needed for GLMakie window decorations under Wayland
          xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
          };

          # XWayland — GLMakie/GR may fall back to X11 protocol
          programs.xwayland.enable = true;
        }

        # ── Julia ───────────────────────────────────────────────────────────
        {
          environment.systemPackages = with pkgs; [
            julia                 # nixpkgs-patched Julia; use julia_19 etc. to pin
            git                   # needed by Julia package manager
          ];

          # System-wide env vars so GR/GLMakie find mesa drivers
          environment.sessionVariables = {
            # Point libGL to mesa (critical for GR and GLMakie on AMD)
            LIBGL_DRIVERS_PATH    = "${pkgs.mesa.drivers}/lib/dri";
            AMD_VULKAN_ICD        = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";

            # Tell GR where to find its libs when running under nix-ld
            GRDIR                 = "";   # let GR auto-detect; set to GR depot if needed

            # Wayland hint for Julia/GLFW (used by GLMakie)
            # GLFW_USE_WAYLAND = "1";   # uncomment if GLMakie opens on wrong display
          };
        }

      ];
    };
  };
}
