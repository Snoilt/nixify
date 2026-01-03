{
  self,
  config,
  host,
  ...
}:
let
  userHome = "/Users/${config.my.username}";
in
{
  users.users.${config.my.username}.home = userHome;
  security.pam.services.sudo_local.touchIdAuth = true;

  launchd.user.agents.set-wallpaper = {
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/osascript"
        "-e"
        ''tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Stone.png" as POSIX file''
      ];
      RunAtLoad = true;
      StandardOutPath = "/tmp/set-wallpaper.out";
      StandardErrorPath = "/tmp/set-wallpaper.err";
    };
  };

  networking = {
    hostName = host;
    computerName = host;
    localHostName = host;
  };

  power.sleep = {
    display = 20;
    computer = 30;
  };

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;

    primaryUser = config.my.username;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      loginwindow = {
        LoginwindowText = host;
      };

      NSGlobalDomain = {
        NSWindowResizeTime = 0.05;

        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.8;
        "com.apple.sound.beep.feedback" = 0;

        AppleInterfaceStyleSwitchesAutomatically = false;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        NSTableViewDefaultSizeMode = 1;
        AppleKeyboardUIMode = 2;
        NSUseAnimatedFocusRing = true;

        # Enable spring loading for directories
        "com.apple.springing.enabled" = true;
        # Remove the spring loading delay for directories
        "com.apple.springing.delay" = 0.0;
      };

      CustomUserPreferences = {
        "com.apple.Spotlight" = {
          # hide spotlight menu bar item
          "NSStatusItem VisibleCC Item-0" = null;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "NSGlobalDomain" = {
          NSColorSimulateHardwareAccent = true;
          NSColorSimulatedHardwareEnclosureNumber = 5;
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # use option+^ to "Move focus to next window" (german keyboard, works after re-login)
            "27" = {
              enabled = true;
              value = {
                parameters = [
                  65535
                  10
                  1048576
                ];
                type = "standard";
              };
            };
          };
        };
      };

      LaunchServices = {
        # disable "Application Downloaded from Internet" popup
        LSQuarantine = false;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.15;
        minimize-to-application = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 34;
        magnification = true;
        largesize = 38;

        # bottom-left is screen saver, rest is disabled
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 5;
        wvous-br-corner = 1;

        persistent-apps = [
          "/System/Applications/Messages.app"
          "/Applications/Spark Desktop.app"
          "/System/Applications/Photos.app"
          "/System/Applications/Notes.app"
          "/System/Applications/FaceTime.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/Home.app"
          "/System/Applications/System Settings.app"
          "/Applications/Brave Browser.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/iTerm.app"
          "/Applications/Hoppscotch.app"
          "/Applications/Obsidian.app"
          "/Applications/WhatsApp.app"
          "/Applications/Telegram Desktop.app"
          "/Applications/Xcode.app"
          "/Applications/UTM.app"
          "/Applications/BambuStudio.app"
        ];
        persistent-others = [
          {
            folder = {
              path = "${userHome}/Downloads/";
              arrangement = "date-added";
              displayas = "stack";
              showas = "fan";
            };
          }
          {
            folder = {
              path = "${userHome}/Desktop/";
              arrangement = "date-added";
              displayas = "stack";
              showas = "fan";
            };
          }
        ];
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        NewWindowTarget = "Desktop";
        QuitMenuItem = false;
        ShowPathbar = true;
        ShowStatusBar = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      screencapture = {
        location = "~/Desktop";
        show-thumbnail = true;
        target = "preview";
        type = "png";
      };

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };

      menuExtraClock = {
        FlashDateSeparators = false;
        ShowDate = 2;
        ShowDayOfMonth = false;
        ShowDayOfWeek = false;
        ShowSeconds = true;
      };

      hitoolbox = {
        AppleFnUsageType = "Do Nothing";
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false;
        EnableTiledWindowMargins = false;
        StageManagerHideWidgets = true;
        StandardHideWidgets = true;
      };

      controlcenter = {
        BatteryShowPercentage = true;
        NowPlaying = false;
        Sound = true;
      };
    };
  };
}
