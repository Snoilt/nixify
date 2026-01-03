# nixify

sets up my stuff just how i like it, especially the macs.

### structure

- `modules/`: config "layers"
- `hosts/`: overrides for specific machines
- `dotfiles/`: used with [tuckr](https://github.com/RaphGL/Tuckr)
- `plist/`: 3rd party app configs that i couldn't figure out a nixy way to configure
- `manual-config/`: 3rd party app configs that i couldn't figure out an automated way to configure

### setup

```sh
xcode-select --install
softwareupdate --install-rosetta --agree-to-license
```

```sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

```sh
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

nix flake init -t nix-darwin/master
sudo nix run nix-darwin/master#darwin-rebuild -- switch
```

```sh
sudo darwin-rebuild switch --flake github:vaaski/nixify#m2-air
```

```sh
sudo rm -fr /etc/nix-darwin/*
sudo git clone https://github.com/vaaski/nixify /etc/nix-darwin
sudo chown -R $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

tuckr add --only-files -fy \*

./plist/apply.sh
```

### manual steps

- apply exports from `./manual-config`
- hide spotlight icon in menubar in `system settings > menu bar`
- in `system settings > lock screen`
  - turn display off 20 mins, 30 mins
  - require password immediately
  - disable show user name and photo
- turn off optimized charging and display dimming on battery `system settings > battery`
