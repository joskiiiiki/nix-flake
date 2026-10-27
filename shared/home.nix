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
    # ../home/system/vicinae
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
    ../home/programs/kakoune
    ../home/programs/lsp

  ];
  programs.gh = {
    enable = true;
  };
  home.packages = with pkgs; [

    claude-desktop

    vesktop # Chat
    vlc # Video player
    pomodoro-gtk
    typora

    proton-pass

    vivaldi
    vivaldi-ffmpeg-codecs
    ungoogled-chromium
    obsidian
    zellij
    vscode
    notion-electron
    intellij-idea
    anki

    kdePackages.filelight

    texliveMedium
    # office
    libreoffice-stable
    spotatui
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

    fresh-editor

    # nixshit
    nixpkgs-fmt
    nixpkgs-lint
    nil
    nixd

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
    code-cursor

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
