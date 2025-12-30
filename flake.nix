{
  description = "vaaski's nixify-everything™ config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
    }:
    let
      mkDarwin =
        { system, host }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit self host; };
          modules = [
            ./modules/common.nix
            ./modules/darwin.nix
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            ./modules/homebrew.nix
            ./hosts/${host}/default.nix
          ];
        };
    in
    {
      darwinConfigurations = {
        # sudo darwin-rebuild switch --flake ".#m2-air"
        m2-air = mkDarwin {
          system = "aarch64-darwin";
          host = "m2-air";
        };
      };
    };
}
