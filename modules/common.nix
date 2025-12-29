{ pkgs, lib, config, ... }:

{
  options.my.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary user name used across hosts/platforms.";
  };

  config = {
    my.username = "o";

    nix.settings.experimental-features = "nix-command flakes";

    programs.zsh.enable = true;
    users.users.${config.my.username}.shell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      curl
      git
      stow
    ];
  };
}
