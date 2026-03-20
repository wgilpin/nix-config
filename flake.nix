{
  description = "MIND-26: M4 Mac Mini Dev Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."MIND-26" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ({ pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;

          # 1. Identity & Nix Settings
          system.primaryUser = "will";
          nix.enable = false; 

          # 2. CLI Tools
          environment.systemPackages = with pkgs; [
            uv python313 gh git tailscale 
            claude-code gemini-cli nodejs_22 _1password-cli
            whatsapp-for-mac
          ];

          # 3. GUI Apps
          homebrew = {
            enable = true;
            onActivation.cleanup = "zap"; 
            casks = [
              "1password" "google-chrome" "visual-studio-code" 
              "orbstack" "raycast" "claude" "ghostty" 
              "tableplus" "obsidian" "steam"
              "protonvpn" "google-drive"
              "brave-browser"
            ];
          };

          # 4. macOS Settings
          system.defaults = {
            dock.autohide = true;
            finder.AppleShowAllExtensions = true;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            LaunchServices.LSQuarantine = false;
          };

          system.defaults.CustomUserPreferences = {
            "com.apple.finder" = {
              AppleShowAllFiles = true;
            };
            "com.apple.UniversalAccess" = {
              showAllFiles = true;
            };
          }; # <--- THIS was missing the closing brace + semicolon

          # 5. Alias
          environment.shellAliases = {
            rebuild = "sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/.config/nix-config#MIND-26";
          };

          system.stateVersion = 5;
        })
      ];
    };
  };
}