{config, ...}: {
  nix-homebrew = {
    enable = true;
    user = config.my.username;
    enableRosetta = true;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
      upgrade = false;
    };
    brews = ["mas"];
    taps = ["mhaeuser/mhaeuser"];
    casks = [
      "affinity"
      "aldente"
      "android-platform-tools"
      "audacity"
      "balenaetcher"
      "bambu-studio"
      "battery-toolkit"
      "bentobox"
      "betterdisplay"
      "bettertouchtool"
      "blender"
      "bleunlock"
      "connectmenow"
      "darkmodebuddy"
      "dbeaver-community"
      "displaylink"
      "docker-desktop"
      "finicky"
      "helium-browser"
      "hoppscotch"
      "iina"
      "iterm2"
      "jordanbaird-ice@beta"
      "keepingyouawake"
      "mullvad-vpn"
      "naps2"
      "obs"
      "obsidian"
      "prismlauncher"
      "raspberry-pi-imager"
      "raycast"
      "readdle-spark"
      "scroll-reverser"
      "spotify"
      "stats"
      "telegram-desktop"
      "the-unarchiver"
      "utm"
      "visual-studio-code"
      "whatsapp"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
