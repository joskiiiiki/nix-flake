{ pkgs, ... }:
let
  # jdtls needs a dedicated, stable workspace dir per-project (not per-editor-instance),
  # otherwise unrelated Java projects corrupt each other's cached project model.
  jdtlsLauncher = pkgs.writeShellScriptBin "jdtls-launcher" ''
    hash=$(${pkgs.coreutils}/bin/realpath "$PWD" | ${pkgs.coreutils}/bin/md5sum | ${pkgs.coreutils}/bin/cut -d' ' -f1)
    exec ${pkgs.jdt-language-server}/bin/jdtls -data "$HOME/.cache/jdtls/workspaces/$hash" "$@"
  '';
in
{
  imports = [
    ./themes/default.nix
    ./settings.nix
    ./languages.nix
  ];
  home.packages = with pkgs; [
    helix
    rustc
    rust-analyzer
    rustfmt
    clippy
    cargo
    pkg-config
    cargo
    cargo-deny
    cargo-edit
    cargo-watch
    wgsl-analyzer
    jdt-language-server
    kotlin-language-server
    jdtlsLauncher
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

  };

}
