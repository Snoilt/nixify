{pkgs, ...}: let
  automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  dfreeScript = pkgs.writeShellScript "dfree.sh" ''
    /bin/df -k "$1" | tail -1 | awk '{print $3" "$5}'
  '';
in {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # sda -> fat 2tb
  # sdb -> crap 2tb
  # sdc -> trans0-2tb
  # sdd -> trans1-2tb
  fileSystems = {
    "/media/raids" = {
      device = "/dev/md0";
      fsType = "ext4";
    };
    "/media/hserver-home" = {
      device = "//hserver/o";
      fsType = "cifs";
      options = [
        "${automountOpts},credentials=/etc/nixos/hosts/lserver/smb-secrets,uid=1000,gid=100"
      ];
    };
    "/media/hserver-2TB" = {
      device = "//hserver/2TB-SPINNINGRUST";
      fsType = "cifs";
      options = [
        "${automountOpts},credentials=/etc/nixos/hosts/lserver/smb-secrets,uid=1000,gid=100"
      ];
    };
    "/media/hserver-1TB-SSD" = {
      device = "//hserver/1TB-SSD";
      fsType = "cifs";
      options = [
        "${automountOpts},credentials=/etc/nixos/hosts/lserver/smb-secrets,uid=1000,gid=100"
      ];
    };
    "/media/hserver-tk2tb" = {
      device = "//hserver/TK-2TB";
      fsType = "cifs";
      options = [
        "${automountOpts},credentials=/etc/nixos/hosts/lserver/smb-secrets,uid=1000,gid=100"
      ];
    };
    "/media/hserver-paperless" = {
      device = "//hserver/paperless";
      fsType = "cifs";
      options = [
        "${automountOpts},credentials=/etc/nixos/hosts/lserver/smb-secrets,uid=1000,gid=100"
      ];
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        security = "user";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.88. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "dfree command" = "${dfreeScript}";
        "dfree cache time" = "60";
      };
      home = {
        path = "/home/o";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "o";
      };
      raids = {
        path = "/media/raids";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "o";
      };
      paperless = {
        path = "/home/o/container-data/paperless/consume";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "o";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
