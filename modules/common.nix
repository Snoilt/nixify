{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  userHome =
    if isDarwin
    then "/Users/${config.my.username}"
    else "/home/${config.my.username}";

  ytDlpUrl =
    if isDarwin
    then "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_macos"
    else "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_linux";

  ytDlpAuto = pkgs.writeShellScriptBin "yt-dlp" ''
    set -euo pipefail

    BIN="$HOME/.cache/yt-dlp/yt-dlp"
    MAX_AGE=$((48 * 60 * 60)) # 48 hours
    NOW=$(date +%s)

    stat_mtime() {
      stat -f %m "$1" 2>/dev/null || stat -c %Y "$1"
    }

    needs_update() {
      [ ! -x "$BIN" ] && return 0
      LAST=$(stat_mtime "$BIN")
      [ $((NOW - LAST)) -ge "$MAX_AGE" ]
    }

    if needs_update; then
      mkdir -p "$(dirname "$BIN")"
      curl -fL ${ytDlpUrl} -o "$BIN.tmp"
      chmod +x "$BIN.tmp"
      mv "$BIN.tmp" "$BIN"
    fi

    exec "$BIN" "$@"
  '';
in {
  options.my.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary user name used across hosts/platforms.";
  };

  config = {
    my.username = lib.mkDefault "p";

    nix = {
      settings.experimental-features = "nix-command flakes";
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.my.username} = {
        home.stateVersion = "24.05";
        programs.git = {
          enable = true;
          settings = {
            gpg.format = "ssh";
            user.signingkey = "${userHome}/.ssh/id_ed25519.pub";
            commit.gpgsign = true;
            tag.gpgsign = true;
            user.name = "Snoilt";
            user.email = "paul@oellers.net";
            pull.rebase = true;
          };
        };
      };
    };

    programs.zsh.enable = true;
    users.users.${config.my.username} = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # add m2 air 
      ];
    };

    environment.variables = {
      TUCKR_HOME =
        if isDarwin
        then "/etc/nix-darwin"
        else "/etc/nixos";
    };

    fonts.packages = [
      pkgs.nerd-fonts.fira-code
    ];

    environment.systemPackages = with pkgs; [
      age
      alejandra
      btop
      bun
      croc
      curl
      deno
      dust
      ffmpeg
      git
      go
      goreleaser
      gow
      nerd-fonts.jetbrains-mono
      nixd
      nodejs_24
      pnpm
      sops
      stow
      tree
      tuckr
      unzip
      wget
      zip

      ytDlpAuto
      nodePackages."@antfu/ni"
    ];
  };
}
