{ nixpkgs, inputs, ... }:
let
  lib = nixpkgs.lib.extend (import ./lib { lib = nixpkgs.lib; });
in
{
  mkDesktopSystem = { system, overlays, modules, config }: nixpkgs.lib.nixosSystem {
    inherit lib;
    system = system;
    modules = [
      {
        nixpkgs.overlays = overlays;
        _module.args = { inherit inputs; };
      }
      config
    ] ++ modules;
  };
}
