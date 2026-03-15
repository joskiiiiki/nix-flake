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
      # inputs.niri-unstable.url = "git+https://github.com/visualglitch91/niri?ref=feat/blur";
    };
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
    };

    affinity = {
      url = "github:mrshmllow/affinity-nix";
    };
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
      overlays = [
        inputs.niri.overlays.niri
        (final: prev: {
          zen-browser = inputs.zen-browser.packages.${system}.beta;
          affinity = inputs.affinity.packages.${system}.v3;
          palettify = inputs.palettify.packages.${system}.default;
        })
      ];
      modules = with inputs; [
        # enable Home Manager
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
