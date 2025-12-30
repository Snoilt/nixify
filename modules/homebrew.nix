{ config, ... }:
{
  nix-homebrew = {
    enable = true;
    user = config.my.username;
    enableRosetta = true;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
      upgrade = false;
    };
    brews = [ ];
    casks = [
      "affinity"
      "aldente"
      "android-platform-tools"
      "audacity"
      "balenaetcher"
      "bambu-studio"
      "bentobox"
      "betterdisplay"
      "bettertouchtool"
      "blender"
      "bleunlock"
      "brave-browser"
      "connectmenow"
      "dbeaver-community"
      "docker-desktop"
      "finicky"
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
      "spotify"
      "stats"
      "telegram-desktop"
      "the-unarchiver"
      "utm"
      "visual-studio-code"
      "whatsapp"
    ];
    taps = [ ];
  };
}
