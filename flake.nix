{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vercel-nvim = {
      url = "github:tiesen243/vercel.nvim";
      flake = false;
    };
    stylix.url = "github:danth/stylix";
    # vicinae = {
    #   url = "github:vicinaehq/vicinae";
    # };

    claude-desktop = {
      url = "github:aaddrick/claude-desktop-debian";
      inputs.nixpkgs.follows = "nixpkgs";
    };
<<<<<<< HEAD
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
    # affinity = {
    #   url = "github:mrshmllow/affinity-nix";
    # };
=======
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
>>>>>>> 65560a7afb8123dc50b6abd6a9d670e9af88773f
    palettify = {
      url = "github:joskiiiiki/palettify-rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      utils = import ./utils.nix { inherit nixpkgs inputs; };
      lib = nixpkgs.lib.extend (_: _: import ./lib/colors.nix { lib = nixpkgs.lib; });
      overlays = [
        inputs.niri.overlays.niri
        inputs.claude-desktop.overlays.default
        (final: prev: {
<<<<<<< HEAD
          # affinity = inputs.affinity.packages.${system}.affinity-v3;
=======
          zen-browser = inputs.zen-browser.packages.${system}.beta;
>>>>>>> 65560a7afb8123dc50b6abd6a9d670e9af88773f
          palettify = inputs.palettify.packages.${system}.default;
        })
      ];
      modules = with inputs; [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        niri.nixosModules.niri
      ];
    in
    {
      nixosConfigurations = {
        nixos = utils.mkDesktopSystem {
          inherit system overlays;
          modules = modules ++ [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14 ];
          config = ./hosts/nixos/configuration.nix;
        };
        nixpc = utils.mkDesktopSystem {
          inherit system overlays modules;
          config = ./hosts/nixpc/configuration.nix;
        };
      };
    };
}
