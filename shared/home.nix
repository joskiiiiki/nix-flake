{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    # ../secrets
    # ../home/system/dms
    ../home/system/noctalia
    ../home/programs/vim
    ../home/programs/obsidian
<<<<<<< HEAD
    # ../home/system/vicinae
=======
    ../home/system/vicinae
    # ../home/programs/sherlock
>>>>>>> 65560a7afb8123dc50b6abd6a9d670e9af88773f
    ../home/programs/direnv
    ../home/programs/btop
    ../home/system/niri
    ../home/system/gtk
    ../home/system/batsignal
    ../home/system/zathura
    ../home/system/mime
    ../home/system/udiskie
    ../home/system/clipman
    ../home/scripts
    ../home/programs/kitty
    ../home/programs/shell
    ../home/programs/git
    ../home/programs/spicetify
    ../home/programs/yazi
    ../home/programs/lazygit
    ../home/programs/zed
    ../home/programs/helix
    ../home/programs/lsp

  ];
  programs.gh = {
    enable = true;
  };
  home.packages = with pkgs; [

    pkgs.claude-desktop

    sage

    vesktop # Chat
    vlc # Video player
    pomodoro-gtk

    proton-pass

    vivaldi
    vivaldi-ffmpeg-codecs
    ungoogled-chromium
    obsidian
    vscode

    kdePackages.filelight

    (texlive.combined.scheme-medium.withPackages (
      p: with p; [
        latexmk
        sagetex
      ]
    ))
    # office
    libreoffice-fresh
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-us-large
    zotero
    onlyoffice-desktopeditors
    # Dev
    python3
    jq
    figlet

    # Utils
    _7zz
    optipng
    pfetch
    pandoc
    overskride

    # nixshit
    nixpkgs-fmt
    nixpkgs-lint
    nil
    nixd

    nautilus
    nautilus

    # multimedia
    pavucontrol
    loupe
    showtime
    papers
    decibels
    gnome-calendar
    gnome-solanum

    ffmpeg

    palettify

    claude-code
    todoist-electron

    pdftk
    ghostscript
    gamescope

    typescript
    typescript-language-server
    biome
    tailwindcss-language-server

    vscode-langservers-extracted
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    # Import my profile picture, used by the hyprpanel dashboard

    # Don't touch this
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
