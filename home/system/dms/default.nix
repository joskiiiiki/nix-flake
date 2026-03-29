{
  config,
  lib,
  inputs,
  ...
}:
let
  hexToRgb = hex: {
    r = lib.fromHexString (builtins.substring 0 2 hex);
    g = lib.fromHexString (builtins.substring 2 2 hex);
    b = lib.fromHexString (builtins.substring 4 2 hex);
  };
  darkenRgb =
    f:
    {
      r,
      g,
      b,
    }:
    {
      r = builtins.floor (r * f);
      b = builtins.floor (b * f);
      g = builtins.floor (g * f);
    };
  mixRgb =
    f: c1: c2:
    let
      mixComponent =
        f: a: b:
        builtins.floor ((1 - f) * a + (f * b));
    in
    {
      r = mixComponent f c1.r c2.r;
      b = mixComponent f c1.b c2.b;
      g = mixComponent f c1.g c2.g;
    };

  pad =
    l: s:
    let
      padLen = lib.max 0 (l - (lib.stringLength s));
      padStr = lib.concatStrings (lib.replicate padLen "0");
    in
    padStr + s;

  rgbToHex =
    hex:
    let
      s = lib.mapAttrs (k: v: pad 2 (lib.toLower (lib.toHexString v))) hex;
    in
    "${s.r}${s.g}${s.b}";
  darkenHex =
    hex: f:
    lib.pipe hex [
      hexToRgb
      (darkenRgb f)
      rgbToHex
    ];
  mixHex =
    f: hex1: hex2:
    let
      c1 = hexToRgb hex1;
      c2 = hexToRgb hex2;
      res = mixRgb f c1 c2;
    in
    rgbToHex res;

in
{
  imports = [

    inputs.dms.homeModules.dank-material-shell
    # inputs.dms.homeModules.dankMaterialShell.niri
  ];

  stylix.targets.dank-material-shell.enable = false;

  programs.dank-material-shell = {
    enable = true;

    settings = {

      acLockTimeout = 0;
      acMonitorTimeout = 0;
      acProfileName = "";
      acSuspendBehavior = 0;
      acSuspendTimeout = 0;
      activeDisplayProfile = { };
      animationSpeed = 1;
      appDrawerSectionViewModes = { };
      appIdSubstitutions = [
        {
          pattern = "Spotify";
          replacement = "spotify";
          type = "exact";
        }
        {
          pattern = "beepertexts";
          replacement = "beeper";
          type = "exact";
        }
        {
          pattern = "home assistant desktop";
          replacement = "homeassistant-desktop";
          type = "exact";
        }
        {
          pattern = "com.transmissionbt.transmission";
          replacement = "transmission-gtk";
          type = "contains";
        }
        {
          pattern = "^steam_app_(\\d+)$";
          replacement = "steam_icon_$1";
          type = "regex";
        }
      ];
      appLauncherGridColumns = 5; # was 4
      appLauncherViewMode = "list";
      appPickerViewMode = "grid";
      appsDockActiveColorMode = "primary";
      appsDockColorizeActive = false;
      appsDockEnlargeOnHover = false;
      appsDockEnlargePercentage = 125;
      appsDockHideIndicators = false;
      appsDockIconSizePercentage = 100;
      audioInputDevicePins = { };
      audioOutputDevicePins = { };
      audioScrollMode = "volume";
      audioVisualizerEnabled = false; # was true
      audioWheelScrollAmount = 5;
      barConfigs = [
        {
          autoHide = false;
          autoHideDelay = 250;
          borderColor = "surfaceText";
          borderEnabled = true; # was false
          borderOpacity = 0.2; # was 1
          borderThickness = 1;
          bottomGap = 0;
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          clickThrough = false;
          enabled = true;
          fontScale = 1;
          gothCornerRadiusOverride = true;
          gothCornerRadiusValue = 20;
          gothCornersEnabled = true;
          iconScale = 1;
          id = "default";
          innerPadding = 4;
          leftWidgets = [
            "workspaceSwitcher"
            "focusedWindow"
          ];
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          name = "Main Bar";
          noBackground = false;
          openOnOverview = true; # was false
          popupGapsAuto = true;
          popupGapsManual = 4;
          position = 2; # was 1 (bottom->top)
          removeWidgetPadding = false;
          rightWidgets = [
            "systemTray"
            "clipboard"
            "cpuUsage"
            "memUsage"
            "notificationButton"
            "battery"
            "controlCenterButton"
          ];
          screenPreferences = [
            "all"
          ];
          shadowColorMode = "surface";
          shadowIntensity = 0;
          shadowOpacity = 48;
          showOnLastDisplay = true;
          spacing = 0;
          squareCorners = true;
          transparency = 1;
          visible = true;
          widgetOutlineColor = "surfaceText";
          widgetOutlineEnabled = true; # was false
          widgetOutlineOpacity = 0.1;
          widgetOutlineThickness = 1;
          widgetPadding = 10;
          widgetTransparency = 0.52; # was 1
        }
      ];
      barMaxVisibleApps = 0;
      barMaxVisibleRunningApps = 0;
      barShowOverflowBadge = true;
      batteryChargeLimit = 100;
      batteryLockTimeout = 0;
      batteryMonitorTimeout = 0;
      batteryProfileName = "";
      batterySuspendBehavior = 0;
      batterySuspendTimeout = 0;
      bluetoothDevicePins = { };
      blurWallpaperOnOverview = false;
      blurredWallpaperLayer = false;
      brightnessDevicePins = { };
      browserPickerViewMode = "grid";
      browserUsageHistory = { };
      builtInPluginSettings = { };
      buttonColorMode = "primary";
      centeringMode = "index";
      clipboardEnterToPaste = false; # new
      clockCompactMode = false;
      clockDateFormat = "";
      configVersion = 6; # was 5
      controlCenterShowAudioIcon = true;
      controlCenterShowAudioPercent = false;
      controlCenterShowBatteryIcon = false;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowBrightnessIcon = false;
      controlCenterShowBrightnessPercent = false;
      controlCenterShowMicIcon = false;
      controlCenterShowMicPercent = false;
      controlCenterShowNetworkIcon = true;
      controlCenterShowPrinterIcon = false;
      controlCenterShowScreenSharingIcon = true;
      controlCenterShowVpnIcon = true;
      controlCenterTileColorMode = "primary";
      controlCenterWidgets = [
        {
          enabled = true;
          id = "volumeSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "brightnessSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "wifi";
          width = 50;
        }
        {
          enabled = true;
          id = "bluetooth";
          width = 50;
        }
        {
          enabled = true;
          id = "audioOutput";
          width = 50;
        }
        {
          enabled = true;
          id = "audioInput";
          width = 50;
        }
        {
          enabled = true;
          id = "nightMode";
          width = 50;
        }
        {
          enabled = true;
          id = "darkMode";
          width = 50;
        }
      ];
      cornerRadius = 12;
      currentThemeCategory = "custom";
      currentThemeName = "custom";
      cursorSettings = {
        dwl = {
          cursorHideTimeout = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        niri = {
          hideAfterInactiveMs = 0;
          hideWhenTyping = false;
        };
        size = 24;
        theme = "System Default";
      };
      customAnimationDuration = 500;
      customPowerActionHibernate = "";
      customPowerActionLock = "";
      customPowerActionLogout = "";
      customPowerActionPowerOff = "";
      customPowerActionReboot = "";
      customPowerActionSuspend = "";
      customThemeFile = lib.mkForce "/home/johannes/.config/dms/system.json";
      dankLauncherV2BorderColor = "surfaceText"; # was "primary"
      dankLauncherV2BorderEnabled = false;
      dankLauncherV2BorderThickness = 1; # was 2
      dankLauncherV2ShowFooter = true;
      dankLauncherV2Size = "compact";
      dankLauncherV2UnloadOnClose = false; # new
      desktopClockColorMode = "primary";
      desktopClockCustomColor = {
        a = 1;
        b = 1;
        g = 1;
        hslHue = -1;
        hslLightness = 1;
        hslSaturation = 0;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        r = 1;
        valid = true;
      };
      desktopClockDisplayPreferences = [
        "all"
      ];
      desktopClockEnabled = false;
      desktopClockHeight = 180;
      desktopClockShowAnalogNumbers = false;
      desktopClockShowAnalogSeconds = true;
      desktopClockShowDate = true;
      desktopClockStyle = "analog";
      desktopClockTransparency = 0.8;
      desktopClockWidth = 280;
      desktopClockX = -1;
      desktopClockY = -1;
      desktopWidgetGridSettings = { };
      desktopWidgetGroups = [ ];
      desktopWidgetInstances = [ ];
      desktopWidgetPositions = { };
      displayNameMode = "system";
      displayProfileAutoSelect = false;
      displayProfiles = { };
      displayShowDisconnected = false;
      displaySnapToEdge = true;
      dockAutoHide = false;
      dockBorderColor = "surfaceText";
      dockBorderEnabled = true; # was false
      dockBorderOpacity = 0.15; # was 1
      dockBorderThickness = 1;
      dockBottomGap = 0;
      dockGroupByApp = false;
      dockIconSize = 40;
      dockIndicatorStyle = "line"; # was "circle"
      dockIsolateDisplays = false;
      dockLauncherEnabled = true; # was false
      dockLauncherLogoBrightness = 0.5;
      dockLauncherLogoColorOverride = "";
      dockLauncherLogoContrast = 1;
      dockLauncherLogoCustomPath = "";
      dockLauncherLogoMode = "compositor"; # was "apps"
      dockLauncherLogoSizeOffset = 0;
      dockMargin = 5; # was 0
      dockMaxVisibleApps = 0;
      dockMaxVisibleRunningApps = 0;
      dockOpenOnOverview = true; # was false
      dockPosition = 3; # was 1
      dockShowOverflowBadge = true;
      dockSmartAutoHide = true; # was false
      dockSpacing = 10; # was 4
      dockTransparency = lib.mkForce 1;
      dwlShowAllTags = false;
      enableFprint = true;
      enableRippleEffects = true;
      enabledGpuPciIds = [ ];
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      filePickerUsageHistory = { };
      focusedWindowCompactMode = false;
      fontFamily = "JetBrains Mono Nerd Font";
      fontScale = 1;
      fontWeight = 400;
      groupWorkspaceApps = true;
      gtkThemingEnabled = false;
      hideBrightnessSlider = false;
      hyprlandLayoutBorderSize = -1;
      hyprlandLayoutGapsOverride = -1;
      hyprlandLayoutRadiusOverride = -1;
      hyprlandOutputSettings = { };
      iconTheme = "System Default";
      keyboardLayoutNameCompactMode = false;
      launchPrefix = "";
      launcherLogoBrightness = 0.5;
      launcherLogoColorInvertOnMode = false;
      launcherLogoColorOverride = "";
      launcherLogoContrast = 1;
      launcherLogoCustomPath = "";
      launcherLogoMode = "apps";
      launcherLogoSizeOffset = 0;
      launcherPluginOrder = [ ];
      launcherPluginVisibility = { };
      lockAtStartup = false;
      lockBeforeSuspend = false;
      lockDateFormat = "";
      lockScreenActiveMonitor = "all";
      lockScreenInactiveColor = "#000000";
      lockScreenNotificationMode = 0;
      lockScreenPowerOffMonitorsOnLock = false;
      lockScreenShowDate = true;
      lockScreenShowMediaPlayer = true;
      lockScreenShowPasswordField = true;
      lockScreenShowPowerActions = true;
      lockScreenShowProfileImage = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      loginctlLockIntegration = true;
      mangoLayoutBorderSize = -1;
      mangoLayoutGapsOverride = -1;
      mangoLayoutRadiusOverride = -1;
      matugenScheme = "scheme-tonal-spot";
      matugenTargetMonitor = "";
      matugenTemplateAlacritty = true;
      matugenTemplateDgop = true;
      matugenTemplateEmacs = true;
      matugenTemplateEquibop = true;
      matugenTemplateFirefox = true;
      matugenTemplateFoot = true;
      matugenTemplateGhostty = true;
      matugenTemplateGtk = true;
      matugenTemplateHyprland = true;
      matugenTemplateKcolorscheme = true;
      matugenTemplateKitty = true;
      matugenTemplateMangowc = true;
      matugenTemplateNeovim = true;
      matugenTemplateNiri = true;
      matugenTemplatePywalfox = true;
      matugenTemplateQt5ct = true;
      matugenTemplateQt6ct = true;
      matugenTemplateVesktop = true;
      matugenTemplateVscode = true;
      matugenTemplateWezterm = true;
      matugenTemplateZenBrowser = true;
      maxFprintTries = 15;
      maxWorkspaceIcons = 3;
      mediaSize = 1;
      modalAnimationSpeed = 1;
      modalCustomAnimationDuration = 150;
      modalDarkenBackground = true;
      monoFontFamily = "JetBrains Mono Nerd Font";
      networkPreference = "auto";
      nightModeEnabled = false;
      niriLayoutBorderSize = -1;
      niriLayoutGapsOverride = -1;
      niriLayoutRadiusOverride = -1;
      niriOutputSettings = { };
      niriOverviewOverlayEnabled = true;
      notepadFontFamily = "";
      notepadFontSize = 14;
      notepadLastCustomTransparency = 0.7;
      notepadShowLineNumbers = false;
      notepadTransparencyOverride = -1;
      notepadUseMonospace = true;
      notificationCompactMode = false;
      notificationHistoryEnabled = true;
      notificationHistoryMaxAgeDays = 7;
      notificationHistoryMaxCount = 50;
      notificationHistorySaveCritical = true;
      notificationHistorySaveLow = true;
      notificationHistorySaveNormal = true;
      notificationOverlayEnabled = false;
      notificationPopupPosition = 0;
      notificationRules = [ ];
      notificationTimeoutCritical = 0;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      osdAlwaysShowValue = false;
      osdAudioOutputEnabled = true;
      osdBrightnessEnabled = true;
      osdCapsLockEnabled = true;
      osdIdleInhibitorEnabled = true;
      osdMediaPlaybackEnabled = true;
      osdMediaVolumeEnabled = true;
      osdMicMuteEnabled = true;
      osdPosition = 0; # was 5
      osdPowerProfileEnabled = false;
      osdVolumeEnabled = true;
      padHours12Hour = false;
      popoutAnimationSpeed = 1;
      popoutCustomAnimationDuration = 150;
      popupTransparency = 1;
      powerActionConfirm = true;
      powerActionHoldDuration = 0.5;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
      ];
      powerMenuDefaultAction = "logout";
      powerMenuGridLayout = false;
      privacyShowCameraIcon = false;
      privacyShowMicIcon = false;
      privacyShowScreenShareIcon = false;
      qtThemingEnabled = false;
      registryThemeVariants = { };
      reverseScrolling = false;
      runDmsMatugenTemplates = true;
      runUserMatugenTemplates = true;
      runningAppsCompactMode = true;
      runningAppsCurrentMonitor = false;
      runningAppsCurrentWorkspace = true;
      runningAppsGroupByApp = false;
      screenPreferences = { };
      scrollTitleEnabled = true;
      selectedGpuIndex = 0;
      showBattery = true;
      showCapsLockIndicator = true;
      showClipboard = true;
      showClock = true;
      showControlCenterButton = true;
      showCpuTemp = true;
      showCpuUsage = true;
      showDock = false;
      showFocusedWindow = true;
      showGpuTemp = true;
      showLauncherButton = true;
      showMemUsage = true;
      showMusic = true;
      showNotificationButton = true;
      showOccupiedWorkspacesOnly = false;
      showOnLastDisplay = { };
      showPrivacyButton = true;
      showSeconds = false;
      showSystemTray = true;
      showWeather = true;
      showWorkspaceApps = false;
      showWorkspaceIndex = false;
      showWorkspaceName = false;
      showWorkspacePadding = false;
      showWorkspaceSwitcher = true;
      sortAppsAlphabetically = false;
      soundNewNotification = true;
      soundPluggedIn = true;
      soundVolumeChanged = true;
      soundsEnabled = true;
      spotlightCloseNiriOverview = true;
      spotlightModalViewMode = "list";
      spotlightSectionViewModes = { };
      syncComponentAnimationSpeeds = true;
      syncModeWithPortal = true;
      systemMonitorColorMode = "primary";
      systemMonitorCustomColor = {
        a = 1;
        b = 1;
        g = 1;
        hslHue = -1;
        hslLightness = 1;
        hslSaturation = 0;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        r = 1;
        valid = true;
      };
      systemMonitorDisplayPreferences = [
        "all"
      ];
      systemMonitorEnabled = false;
      systemMonitorGpuPciId = "";
      systemMonitorGraphInterval = 60;
      systemMonitorHeight = 480;
      systemMonitorLayoutMode = "auto";
      systemMonitorShowCpu = true;
      systemMonitorShowCpuGraph = true;
      systemMonitorShowCpuTemp = true;
      systemMonitorShowDisk = true;
      systemMonitorShowGpuTemp = false;
      systemMonitorShowHeader = true;
      systemMonitorShowMemory = true;
      systemMonitorShowMemoryGraph = true;
      systemMonitorShowNetwork = true;
      systemMonitorShowNetworkGraph = true;
      systemMonitorShowTopProcesses = false;
      systemMonitorTopProcessCount = 3;
      systemMonitorTopProcessSortBy = "cpu";
      systemMonitorTransparency = 0.8;
      systemMonitorVariants = [ ];
      systemMonitorWidth = 320;
      systemMonitorX = -1;
      systemMonitorY = -1;
      terminalsAlwaysDark = false;
      updaterCustomCommand = "";
      updaterHideWidget = false;
      updaterTerminalAdditionalParams = "";
      updaterUseCustomCommand = false;
      use24HourClock = true;
      useAutoLocation = false;
      useFahrenheit = false;
      useSystemSoundTheme = false;
      wallpaperFillMode = "Fill";
      waveProgressEnabled = false; # was true
      weatherEnabled = true;
      widgetBackgroundColor = "sth"; # was "sch"
      widgetColorMode = "default";
      wifiNetworkPins = { };
      windSpeedUnit = "kmh";
      workspaceAppIconSizeOffset = 0;
      workspaceColorMode = "default";
      workspaceDragReorder = true;
      workspaceFocusedBorderColor = "primary";
      workspaceFocusedBorderEnabled = false;
      workspaceFocusedBorderThickness = 2;
      workspaceFollowFocus = false;
      workspaceNameIcons = { };
      workspaceOccupiedColorMode = "none";
      workspaceScrolling = false;
      workspaceUnfocusedColorMode = "default";
      workspaceUrgentColorMode = "default";
    };

    # Core features
    systemd.enable = false;
    enableSystemMonitoring = true;
    enableVPN = false;
    enableDynamicTheming = false;
    enableAudioWavelength = false;
    enableCalendarEvents = true;

  };

  xdg.configFile."dms/system.json".text =
    let
      stylix = config.lib.stylix.colors;
      primary = stylix.base0E;
      background = stylix.base00;
      surface = stylix.base01;
      foreground = stylix.base07;
      foreground-muted = stylix.base06;
      colors = builtins.mapAttrs (k: v: "#${v}") {
        inherit primary background surface;
        primaryText = background;
        primaryContainer = "#${lib.colors.mixHex 0.8 background primary}";
        backgroundText = foreground;
        surfaceContainer = stylix.base00;
        surfaceContainerHigh = stylix.base01;
        surfaceContainerHighest = stylix.base02;
        surfaceVariant = stylix.base00;
        surfaceText = foreground-muted;
        surfaceTint = background;
        outline = stylix.base04;
        error = stylix.base08;
        warning = stylix.base0A;
        info = primary;
      };
    in
    (builtins.toJSON (colors // { name = "System"; }));
}
