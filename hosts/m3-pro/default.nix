{...}: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  my.username = "A200007423";

  networking = {
    hostName = "T001849997";
    computerName = "T001849997";
    localHostName = "T001849997";
  };

  system.defaults.CustomUserPreferences."NSGlobalDomain" = {
    NSColorSimulateHardwareAccent = null;
    NSColorSimulatedHardwareEnclosureNumber = null;
    AppleAccentColor = 6;
  };

  system.defaults.dock.persistent-apps = [
    "/System/Applications/Messages.app"
    "/Applications/Spark Desktop.app"
    "/System/Applications/Photos.app"
    "/System/Applications/Notes.app"
    "/System/Applications/FaceTime.app"
    "/System/Applications/Reminders.app"
    "/System/Applications/Home.app"
    "/System/Applications/System Settings.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/Microsoft Outlook.app"
    "/Applications/Microsoft Edge.app"
    "/Applications/Helium.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/iTerm.app"
    "/Applications/Hoppscotch.app"
    "/Applications/Obsidian.app"
    "/Applications/WhatsApp.app"
    "/Applications/Telegram Desktop.app"
    "/Applications/Spotify.app"
    "/Applications/Xcode.app"
    "/Applications/UTM.app"
    "/Applications/BambuStudio.app"
  ];
}
