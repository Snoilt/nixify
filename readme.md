# nixify

sets up my stuff just how i like it, especially the macs.

### structure

- `dotfiles/`: used with `stow .`

### setup

```sh
xcode-select --install
softwareupdate --install-rosetta --agree-to-license
```

```sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

```sh
nix flake init -t nix-darwin/master
sudo nix run nix-darwin/master#darwin-rebuild -- switch
```

```sh
darwin-rebuild switch --flake github:vaaski/nixify#m2-air
```

```sh
sudo mkdir -p /etc/nix-darwin
sudo git clone https://github.com/vaaski/nixify /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

tuckr set --only-files -fy \*
```
