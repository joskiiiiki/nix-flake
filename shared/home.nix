{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    # ../secrets
    ../home/system/dms
    ../home/programs/obsidian
    ../home/programs/affinity
    ../home/system/vicinae
    # ../home/programs/sherlock
    ../home/programs/direnv
    ../home/programs/btop
    # ../home/programs/gemini
    # ../home/programs/cava
    ../home/system/niri
    # ../home/system/mango
    ../home/system/gtk
    # ../home/system/wofi
    ../home/system/batsignal
    ../home/system/zathura
    ../home/system/mime
    ../home/system/udiskie
    ../home/system/clipman
    # ../home/system/tofi
    ../home/scripts
    ../home/programs/kitty
    # ../home/programs/ollama
    ../home/programs/shell
    # ../home/programs/fetch
    ../home/programs/git
    ../home/programs/spicetify
    ../home/programs/yazi
    ../home/programs/nautilus
    ../home/programs/lazygit
    ../home/programs/zed
    ../home/programs/helix
    ../home/programs/nextcloud
    ../home/programs/lsp
    ../home/programs/gowall
    # ../home/programs/kakoune
  ];
  programs.gh = {
    enable = true;
  };
  home.packages = with pkgs; [
    # Apps
    # jetbrains.rust-rover
    vesktop # Chat
    vlc # Video player
    blanket # White-noise app
    pomodoro-gtk
    vicinae

    proton-pass

    zen-browser
    obsidian
    vscode

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
    just

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

    # multimedia
    pavucontrol
    loupe
    totem
    evince

    # Backup
    firefox


    appimage-run
    ffmpeg

    # palettify
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
