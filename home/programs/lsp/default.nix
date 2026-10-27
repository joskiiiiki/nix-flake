{ pkgs, lib, ... }:
let
  # JetBrains' standalone IntelliJ Platform language server for Java/Kotlin.
  # Not in nixpkgs; packaged here from JetBrains' CDN release.
  # intellij-server = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  #   pname = "intellij-server";
  #   version = "263.6379.0";

  #   src = pkgs.fetchurl {
  #     url = "https://download.jetbrains.com/language-server/intellij-server/${finalAttrs.version}/intellij-server-${finalAttrs.version}.tar.gz";
  #     hash = "sha256-dSnMcz1KAg4cE2kYOy9g4TXIW48HS78n0UdqWns4OcM=";
  #   };

  #   nativeBuildInputs = [
  #     pkgs.autoPatchelfHook
  #     pkgs.makeWrapper
  #   ];

  #   buildInputs = [
  #     pkgs.alsa-lib
  #     pkgs.fontconfig
  #     pkgs.freetype
  #     pkgs.glib
  #     pkgs.libxkbcommon
  #     pkgs.stdenv.cc.cc.lib
  #     pkgs.wayland
  #     pkgs.zlib
  #     pkgs.libx11
  #     pkgs.libxext
  #     pkgs.libxi
  #     pkgs.libxrender
  #     pkgs.libxtst
  #   ];

  #   launcherScript = ./intellij-server-launcher.sh;

  #   installPhase = ''
  #     runHook preInstall

  #     mkdir -p "$out/libexec/intellij-server" "$out/bin"
  #     cp -r . "$out/libexec/intellij-server/"
  #     chmod +x "$out/libexec/intellij-server/bin/intellij-server"

  #     install -m755 "$launcherScript" "$out/bin/intellij-server"
  #     wrapProgram "$out/bin/intellij-server" \
  #       --prefix PATH : ${lib.makeBinPath [ pkgs.coreutils pkgs.gawk ]}

  #     runHook postInstall
  #   '';

  #   meta = {
  #     description = "IntelliJ Platform Java/Kotlin language server, run as a standalone LSP backend";
  #     homepage = "https://blog.jetbrains.com/idea/2026/08/intellij-idea-goes-lsp/";
  #     license = lib.licenses.unfree;
  #     sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  #     platforms = [ "x86_64-linux" ];
  #     mainProgram = "intellij-server";
  #   };
  # });

  # Editors (Helix, Zed, Kakoune) spawn LSP servers with their own inherited
  # environment, not the project's direnv/flake devShell - so `ty`/`ruff`
  # resolve the wrong Python interpreter for direnv-managed projects (shows
  # up as everything typed `Unknown`, missing completions for anything from
  # a dependency). These wrappers re-run the real binary through `direnv
  # exec` for the LSP's cwd, falling straight back to the plain binary if
  # that fails (no .envrc, or an unapproved one) so nothing regresses for
  # non-direnv projects. Editor language-server configs reference these by
  # name ("ty-direnv"/"ruff-direnv"); plain `ty`/`ruff` stay unwrapped for
  # normal terminal use, where direnv's shell hook already does this.
  direnvWrap =
    name: pkg:
    pkgs.writeShellScriptBin "${name}-direnv" ''
      exec ${pkgs.direnv}/bin/direnv exec "$PWD" ${pkg}/bin/${name} "$@" 2>/dev/null || exec ${pkg}/bin/${name} "$@"
    '';
  tyDirenv = direnvWrap "ty" pkgs.ty;
  ruffDirenv = direnvWrap "ruff" pkgs.ruff;
in
{
  home.packages = with pkgs; [
    # intellij-server

    bash-language-server
    vscode-langservers-extracted
    docker-language-server
    typescript-language-server
    gopls
    graphql-language-service-cli
    jq-lsp
    texlab
    lua-language-server
    markdown-oxide
    mesonlsp
    rust-analyzer
    basedpyright
    svelte-language-server
    zls
    biome

    ty
    ruff
    tyDirenv
    ruffDirenv
  ];
}
