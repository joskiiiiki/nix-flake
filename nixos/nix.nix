{
  config,
  inputs,
  lib,
  ...
}:
let
  autoGarbageCollector = config.var.autoGarbageCollector;
in
{

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    NIXPKGS_ALLOW_BROKEN = 1;
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "firefox-esr-140-bin-unwrapped-140.17.0esr"
    ];
  };
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      substituters = [ "https://niri.cachix.org" ];
      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    gc = {
      automatic = autoGarbageCollector;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
