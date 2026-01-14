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
    brews = [
      "mas"
    ];
    taps = [
      "mhaeuser/mhaeuser" # battery toolkit
      "psharma04/dorion" # dorion discord client
      "nikitabobko/aerospace" # aerospace app
    ];
    casks = [
      "audacity"
      "aerospace"
      "bambu-studio"
      "battery-toolkit"
      "betterdisplay"
      "blender"
      "dbeaver-community"
      "displaylink"
      "docker-desktop"
      "discord"
      "finicky"
      "zen"
      "hoppscotch"
      "iterm2"
      "jordanbaird-ice@beta"
      "keepingyouawake"
      "mullvad-vpn"
      "obs"
      "obsidian"
      "prismlauncher"
      "raspberry-pi-imager"
      "raycast"
      "readdle-spark"
      "spotify"
      "stats"
      "steam"
      "telegram-desktop"
      "the-unarchiver"
      "utm"
      "visual-studio-code"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
      WireGuard = 1451685025;
    };
  };
}
