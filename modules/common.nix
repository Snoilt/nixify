{
  pkgs,
  lib,
  config,
  ...
}:
let
  ytDlpUrl =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_macos"
    else
      "https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/latest/download/yt-dlp_linux";

  ytDlpAuto = pkgs.writeShellScriptBin "yt-dlp" ''
    set -euo pipefail

    BIN="$HOME/.cache/yt-dlp/yt-dlp"
    MAX_AGE=$((48 * 60 * 60))
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
in
{
  options.my.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary user name used across hosts/platforms.";
  };

  config = {
    my.username = "o";

    nix.settings.experimental-features = "nix-command flakes";

    programs.git = {
      enable = true;
      extraConfig = {
        gpg.format = "ssh";
        user.signingkey = "/Users/${config.my.username}/.ssh/id_ed25519.pub";
        commit.gpgsign = true;
        tag.gpgsign = true;
      };
    };

    programs.zsh.enable = true;
    users.users.${config.my.username} = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # atlas
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn75kBDz7/E92HNrgITF1rGQvoKIL9kZfECCEgNKaCtoTxr10L/TO1Uvq8LZMdxL3HIYO6PGJKzuYIsfEvN7Bx/PG0FXU7QWge0H0j3jCjgWx5p7RPwH76omIIryz0V7Vt+xPFJeGykiW0qmuHl8zK/uxVtHN/cVW+ukmpQ6ztmnRJ9HrGiYIOuOfNgnVr7J6i7lYv8kL+0l7gmBABnMIQk+7cIntgd54jroAdvcPQpja8pO6uki5Eh9XJrAmo/nW9KTjRSx+DtxuQny5lh7jZlwmKZtkIyV6MgoeWopDDWl69BmCzbRDh8GpnkHlCP09WGi6XMFQSGgmOIOhokE+D"

        # i15p
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYlfzHsYEWnzrrdM4t8GC9uA8SIIvjtieZEmIbw/yNn"

        # work mac
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoiophA8kvDCGunKUiRX91opLWPoNUi+LIsVv+bCmz2"

        # m2-air
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1Z1+udAEvwovjH5/0Mqzrg/iC10+A9KMl2rssjglLB"
      ];
    };

    environment.variables = {
      TUCKR_HOME = "/etc/nix-darwin";
    };

    environment.systemPackages = with pkgs; [
      btop
      bun
      croc
      curl
      deno
      dust
      ffmpeg
      git
      gnupg
      nerd-fonts.fira-code
      nixd
      nixfmt-rfc-style
      nodejs_24
      stow
      tree
      tuckr
      unzip
      wget
      zip

      ytDlpAuto
    ];
  };
}
