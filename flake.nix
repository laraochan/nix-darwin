{
  description = "laraochan's nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    configuration = { pkgs, ... }: {
      # DeterminateSystems経由の場合、DeterminateSystemsはNixのインストール自体を管理するためこのオプションが必要
      nix.enable = false;

      nixpkgs.config.allowUnfree = true;

      # home-managerではGUIアプリケーションを管理できないためこちらに記載する
      environment.systemPackages = with pkgs; [
        google-chrome
        vscode
        obsidian
      ];

      programs.zsh.enable = true;

      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.stateVersion = 6;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."laraochans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.laraochan = import ./home-manager;
        }
      ];
    };
  };
}
